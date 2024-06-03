<?php
class Database
{
    public $db;
    public $dbname = "helpdesk";
    public $user = "user";
    public $password = "userpassword";

    public $stanze;
    public $dispositivi;
    public function __construct()
    {
        
        $this->db = new DB\SQL(
            "mysql:host=localhost;port=3306;dbname=$this->dbname",
            $this->user,
            $this->password
        );

        $this->stanze = $this->db->exec("SELECT * FROM stanze");
        $this->dispositivi = $this->db->exec("SELECT * FROM dispositivi");
    }

    public function dispositivi($stanza)
    {
        if ($stanza == "") {
            return $this->dispositivi;
        }
        return $this->db->exec("select * from dispositivi WHERE stanza = ?", $stanza);
    }

    public function segnalazioni($dispositivo)
    {

        if ($dispositivo == "") {
            return $this->db->exec("select * from segnalazione");
        }

        if(is_string($dispositivo)){
            $id_stanza = "";
            foreach($this->stanze as $row){
                if(strcmp($row["nome"], $dispositivo) == 0){
                    $id_stanza = $row["codice"];
                    return $this->db->exec("select * from segnalazione WHERE id_stanza = ?", $id_stanza);
                
                }
            }
        }
        //passo il codice del dispositivo

        return $this->db->exec("select * from segnalazione WHERE id_dispositivo = ?", $dispositivo);
    }

    //ritorna tutte le stanze salvate
    public function stanze()
    {

        return $this->stanze;
    }

    public function alerts()
    {
        return $this->db->exec("SELECT * FROM alert_tecnico WHERE tecnico = ?", $_SESSION["google_email"]);
    }


    public function utenti($get_user)
    {
        if ($get_user != "") {
            $user = $get_user . "@itiszuccante.edu.it";
            return $this->db->exec("SELECT * from utente WHERE email = ?" , $user);

        }
        return $this->db->exec("SELECT * from utente");
    }

    public function aggiornaUtente($get)
    {
  
        $ruolo = $get["ruolo"];
        $ban = $get["ban"] == "si" ? true : false;
        $descrizione = $get["mansione"];
        $email = $get["id_utente"]."@itiszuccante.edu.it";
        
        $this->db->exec("UPDATE utente SET ruolo = ?, ban = ?, mansione= ? WHERE email= ?",
            [
                $ruolo, $ban, $descrizione, $email
            ]);
    }

    public function inserisciSegnalazione($get)
    {
        session_start();

        $isMobileSide = false;
        $utente = "";

        if(isset($get["id_utente"])){
            $utente = $get["id_utente"];
            $isMobileSide = true;
        }
        else {
            $utente = $_SESSION["google_email"];
        }
        $tipo = "strutturale";
        $id_dispositivo = "";


        //ottenere i codici di dispositivo e di stanza

        //codice stanza dato il nome
        $stanze = $this->stanze();
        $id_stanza = "";
        foreach ($stanze as $row) {
            if (strcmp($row["nome"], $get["stanza"]) == 0) {
                $id_stanza = $row["codice"];
            }
        }

        //codice dispositivo dato il nome

        if (!isset($get["dispositivo"])) {
            $id_dispositivo = null;
        } else {
            if (strcmp($get["tipo"], "dispositivo") == 0) {
                $tipo = "tecnico";
                //Cerchiamo il codice del dispositivo
                $dispositivi = $this->dispositivi($get["stanza"]);
                foreach ($dispositivi as $row) {
                    if (strcmp($row["nome"], $get["dispositivo"]) == 0) {
                        $id_dispositivo = $row["id"];
                    }
                }
            }
        }


        $param = array(
            $utente,
            date("Y-m-d H:i:s"),
            $get["descrizione"],
            $tipo,
            "non assegnato",
            $id_dispositivo,
            $id_stanza
        );

        $this->db->exec("INSERT INTO segnalazione(id_utente,data,descrizione,tipo,stato,id_dispositivo,id_stanza)
        VALUES (?, ?, ?, ?, ?, ?, ?)", $param);

        if(!$isMobileSide){
            //...
        }
        else {
            echo json_encode(["status" => "OK","risposta" => "Segnalazione inviata con successo", "array"=> $param]);
            exit();
        }

    }

    public function eliminaSegnalazione($dati){
        //utente e email (chiavi primarie)

        $utente = $dati["id_utente"];
        $data = $dati["data"];

        $this->db->exec("DELETE FROM segnalazione WHERE id_utente = ? AND data = ?", [$utente, $data]);
    

    }

    public function inserisciAlert($dati){
        $utente = $_SESSION["google_email"];
        $id_stanza = $dati["id_stanza"];
        $id_dispositivo = $dati["id_dispositivo"];

        
        $this->db->exec("INSERT INTO alert_tecnico (tecnico, stanza, dispositivo) VALUES (?, ?, ?);", [$utente, $id_stanza,$id_dispositivo]);

    }


    public function eliminaAlert($dati){
        $utente = $_SESSION["google_email"];
        $id_stanza = $dati["id_stanza"];
        $id_dispositivo = $dati["id_dispositivo"];

        if($id_stanza == null){
            $this->db->exec("DELETE FROM alert_tecnico WHERE tecnico = ? AND dispositivo = ?", [$utente,$id_dispositivo]);
        }
        else {
            $this->db->exec("DELETE FROM alert_tecnico WHERE tecnico = ? AND stanza = ?", [$utente, $id_stanza]);
        }

        

    }


    function t()
    {
        echo "ciao";
    }

}
?>