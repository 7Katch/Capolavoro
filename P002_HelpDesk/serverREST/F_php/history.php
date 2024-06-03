<?php

session_start();
if (!($_SESSION["google_id"])) {
    header("Location: auth");
}
;

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="google" content="notranslate">
    <title>Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://www.itiszuccante.edu.it/wp-content/uploads/2024/03/ZuccanteSquared.png">



    <style>
        #titolo {
            display: block;
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

        #content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly;
            margin: 20px;
            padding: 0px 50px;
            min-height: 100vh;
        }

        #content table {
            height: fit-content;
            border: 1px solid black;
            /* min-width: 100%; */
            width: fit-content;
        }

        th {
            min-width: 250px;
        }

        td {
            width: 200px;
        }

        td i {
            cursor: pointer;
            user-select: none;
        }


        #search {
            width: 200px;
        }

        #filtro {
            margin-top: 20px;
            margin-left: 30px;
            padding: 5px;
            display: flex;
            flex-direction: row;
            align-items: center;
        }



        footer {
            position: relative;
        }
    </style>
</head>

<body>
    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h5 class="max center-align">History</h5>
            <button class="circle transparent" id="icona">
                <!-- <img class="responsive" src="/favicon.png"> -->
                <?php
                session_start();
                if (isset($_SESSION["google_picture"])) {
                    $picture = $_SESSION["google_picture"];
                    echo "<img src='$picture'>";
                }
                ?>
            </button>
        </nav>
    </header>


    <!-- barra a destra -->
    <?php
    echo file_get_contents("F_php/header.php");
    ?>
    <div class="overlay " id="barra-laterale-dx">
        <dialog class="right scroll">

            <nav class="m l right drawer">
                <header>
                    <button class="circle transparent" id="chiusura-menu-tendina-dx">
                        <i><span>close</span></i>
                    </button>
                </header>
                <a>
                    <i>settings</i>
                    <span>Impostazioni</span>
                </a>
                <a href="https://github.com/Katch7K">
                    <i>code</i>
                    <span>Autore</span>
                </a>
                <a href="logout">
                    <i>output</i>
                    <span>Logout</span>
                </a>
            </nav>
        </dialog>
    </div>
    <h2 id="titolo">Titolo</h2>

    <nav class="scroll" id="filtro">
        <div class="field large prefix round fill" id="search">
            <i class="front">search</i>
            <input placeholder="Cerca">
        </div>

    </nav>


    <div id="content">
        <table class="stripes medium-space center-align">
            <thead>
                <?php
                session_start();
                $header = '
                <tr>
                <th>Utente</th>
                <th>Data</th>
                <th>Stato</th>
                <th>Descrizione</th>
                ';
                if ($_SESSION["ruolo"] == "admin") {
                    $header = $header . "<th>asdasd</th>";
                }
                $header = $header . "</tr>";

                echo $header;
                ?>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>

    <?php
    echo file_get_contents("F_html/footer.html");
    ?>

    <script>

        let urlParams = new URLSearchParams(window.location.search);

        function richiediSegnalazioni(isDevice) {
            let fetchRequest = "segnalazioni?s=" + urlParams.get("s");
            if(isDevice){
                fetchRequest = "segnalazioni?d=" + urlParams.get("d");
            }
            fetch(fetchRequest).then((value) => value.json()).then((json) => {
                console.log(json); 

                

                json.sort((a, b) => {
                    const dateA = new Date(a.data);
                    const dateB = new Date(b.data);
                    return dateB - dateA; // Ordina in base alla differenza delle date (dalla più recente alla più vecchia)
                });

                let i = 1;
                for (let segnalazione of json) {
                    if(segnalazione["id_dispositivo"] != null && !isDevice){
                        continue;
                    }

                    // Crea una nuova riga
                    var newRow = tbody.insertRow();

                    // Aggiungi le celle alla nuova riga
                    let utente = newRow.insertCell();
                    let data = newRow.insertCell();
                    let stato = newRow.insertCell();
                    stato.style["color"] = "red";
                    let descrizione = newRow.insertCell();


                    // Aggiungi il testo alle celle
                    utente.textContent = segnalazione["id_utente"];
                    data.textContent = segnalazione["data"];
                    stato.textContent = segnalazione["stato"];
                    descrizione.textContent = segnalazione["descrizione"];

                    newRow.id = "riga-" + i;

                    let btn = document.createElement("button");


                    let pulsante_modificatori = newRow.insertCell();

                    <?php

                    if ($_SESSION["ruolo"] != "admin") {
                        echo 'pulsante_modificatori.style["display"] = "none";';
                    }

                    ?>

                    pulsante_modificatori.innerHTML = `
                    <i>Edit</i>
                    <i class='${newRow.id}'>Delete</i>
                `;

                    pulsante_modificatori.querySelector(`.${newRow.id}`).addEventListener("click", () => {
                        //Se l'utente vuole eliminare

                        if (confirm("Vuoi eliminare questa segnalazione definitivamente?") == true) {
                            // tbody.innerHTML = "";
                            let path = (pulsante_modificatori.querySelectorAll("i")[1]).classList[0];

                            //prima nascondiamo, poi richiediamo la cancellazione al server
                            tbody.querySelector("#" + path).style["display"] = "none";

                            let data = {
                                "id_utente": segnalazione["id_utente"],
                                "data": segnalazione["data"]
                            };

                            console.log(JSON.stringify(data));

                            fetch("elimina-segnalazione", {
                                method: "POST",
                                body: JSON.stringify(data)
                            }).then((response) => response.json()).then((json) => {
                                console.log(json);
                            });


                        }
                        else {

                        }
                    });


                    i++;
                }
            });
        }



        let schema = document.querySelector("#content");
        let tbody = document.querySelector(".stripes tbody");

        let titolo = document.querySelector("#titolo");
        let contenuti = [];

        //se d è null allora storico della stanza, altrimenti storico del device

        if (urlParams.get("d") != null) {
            titolo.innerHTML = "Storico delle segnalazioni del dispositivo " + urlParams.get("n");
            richiediSegnalazioni(true);
        }
        else {
            titolo.innerHTML = "Storico delle segnalazioni della stanza " + urlParams.get("s");
            richiediSegnalazioni(false);
        }




    </script>
    <!-- //BARRA LATERALE -->
    <script src="F_js/barralaterale.js"></script>
</body>

</html>