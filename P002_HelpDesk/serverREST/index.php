<?php
require ("vendor/autoload.php");
require ("database.php");

session_start();

$server = Base::instance();
$db = new Database();
$view = new View();

$server->route("GET /", function () use ($view) {
    echo $view->render("home.php");
});


$server->route("GET /index", function () use ($view, $server, $db) {

    $id_utente = substr($_SESSION["google_email"], 0, strpos($_SESSION["google_email"], "@"));
    $dati_utente = $db->utenti($id_utente)[0];
    $_SESSION["ruolo"] = $dati_utente["ruolo"];

    echo $view->render("home.php");
});

$server->route("GET /dispositivi", function () use ($server, $db) {
    $server->set("CONTENT_TYPE", "application/json");
    $stanza = $server->get("GET.stanza");
    $result = "";

    $result = $db->dispositivi(isset ($stanza) ? $stanza : "");

    print json_encode($result);

});

//TODO SEGNALAZIONI
//Form-segnalazione
$server->route("GET /form", function () use ($view, $server, $db) {
    $db->inserisciSegnalazione($server->get("GET"));

    header("Location: stanza");

});

$server->route("GET /formDaMobile", function () use ($view, $server, $db) {
    try {
        $db->inserisciSegnalazione($server->get("GET"));
    } catch (e) {
        echo json_encode(["messaggio" => "Errori nel form"]);
    }

});
$server->route("POST /formDaMobile", function () use ($view, $server, $db) {
    try {
        $db->inserisciSegnalazione(json_decode($server->get('BODY'), true));
    } catch (e) {
        echo json_encode(["messaggio" => "Errori nel form"]);
    }

});



$server->route("GET /segnala", function () use ($view) {
    echo $view->render("F_php/segnalazione.php");
});

$server->route("GET /segnalazioni", function () use ($server, $db) {
    $server->set("CONTENT_TYPE", "application/json");
    $dispositivo = $server->get("GET.d");
    $stanza = $server->get("GET.s");
    $result = "";
    if (isset ($dispositivo)) {
        $result = $db->segnalazioni($dispositivo);
    } else if (isset ($stanza)) {
        //$stanza e' il nome della stanza, NON IL CODICE
        $result = $db->segnalazioni($stanza);
    } else {
        $result = $db->segnalazioni("");
    }
    print json_encode($result);
});

$server->route("POST /elimina-segnalazione", function () use ($server, $db) {

    $body = json_decode($server->get('BODY'), true);
    $db->eliminaSegnalazione($body);

    echo json_encode(["status" => "OK", "risposta" => "Eliminazione avvenuta con successo"]);
    exit ();
});

$server->route("GET /alerts", function () use ($db) {
    echo json_encode($db->alerts());
});

$server->route("GET /alert", function () use ($view) {
    echo $view->render("F_php/alert.php");
});


//TODO Alert
$server->route("POST /aggiungiAlert", function () use ($server, $db) {
    $body = json_decode($server->get('BODY'), true);

    $db->inserisciAlert($body);
    // echo json_encode($body);

    echo json_encode(["status" => "OK", "risposta" => "Aggiunta alert avvenuta con successo"]);

});

$server->route("POST /eliminaAlert", function () use ($server, $db) {
    $body = json_decode($server->get('BODY'), true);

    $db->eliminaAlert($body);
    // echo json_encode($body);


    echo json_encode(["status" => "OK", "risposta" => "Eliminazione alert avvenuta con successo"]);

});



$server->route("GET /history", function () use ($view) {

    echo $view->render("F_php/history.php");
});


$server->route("GET /stanze", function () use ($server, $db, $view) {
    $server->set("CONTENT_TYPE", "application/json");
    $result = $db->stanze();
    print json_encode($result);

});

$server->route("GET /stanza", function () use ($server, $view) {
    $stanza = $server->get("GET.s");
    if (isset ($stanza)) {
        $_SESSION["stanza"] = $stanza;
        echo $view->render("F_php/dispositivi.php");
    } else {
        echo $view->render("F_php/stanze.php");
    }
});


$server->route("GET /gestione-utenti", function () use ($view, $server) {
    //Cercare se l'utente esiste
    $user_id = $server->get("GET.id");
    if (isset ($user_id)) {
        echo $view->render("F_php/utente.php");
    } else {
        echo $view->render("F_php/gestione_utenti.php");
    }

});

//TODO SEZIONE UTENTE
$server->route("GET /utenti", function () use ($db) {
    //Cercare se l'utente esiste
    $results = json_encode($db->utenti(""));
    echo $results;
});

$server->route("GET /utente/@id", function () use ($server, $view, $db) {
    //Cercare se l'utente esiste


    $get_user = $server->get("PARAMS.id");
    if ($get_user != null) {
        $results = json_encode($db->utenti($get_user)[0]);
        echo $results;
    } else {
        echo json_encode(["errore" => "mancato codice dell'utente"]);
    }
});

$server->route("POST /aggiorna-utente", function () use ($db, $server) {

    $db->aggiornaUtente($server->get("POST"));

    header("Location: gestione-utenti");
});


//PRIVACY-POLICY
$server->route("GET /privacy-policy", function () use ($view) {
    echo $view->render("F_php/privacy_policy.php");

});
//COOKIE-POLICY
$server->route("GET /cookie-policy-ue", function () use ($view) {
    // echo "cookie-policy-ue"; 
    echo $view->render("F_php/cookie_policy.php");
});
//COOKIE-PERSONALIZZATI
$server->route("GET /custom_cookie", function () use ($view) {
    echo $view->render("F_php/custom_cookie.php");
});

$server->route("GET /auth", function () use ($server, $view) {
    session_start();
    require ("auth.php");
});

$server->route("GET /logout", function () {
    session_unset();
    session_destroy();
    header("Location: index");
});



$server->route("GET /t", function () use ($server, $view) {
    echo $view->render("testPOST.php");
});

$server->route("POST /t", function () use ($server, $view) {

    $json = $server->get("BODY");
    // var_dump($server->get("BODY"));

    ;

    $query_string = "patata=fritta&fritta=bollente";
    parse_str($query_string, $body);
    echo json_encode(array_keys($body));
});


$server->route("GET /b", function () use ($view) {
    echo $view->render("F_html/beer.html");

});


$server->run();
?>