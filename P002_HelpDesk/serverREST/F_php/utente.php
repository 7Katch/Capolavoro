<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica dati - Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/4969/4969093.png">


    <style>
        main {
            width: 60vw;
            background-color: white;
            border: 1px solid black;

            left: 50%;
            transform: translateX(-50%);
            min-height: 60vh;
            height: fit-content;
            top: 10vh;
            padding: 30px 30px;
        }

        #form-segnalazione {
            width: 100%;

        }

        form {
            /* background-color: orange; */
            margin-top: 2vh;
        }
    </style>
</head>

<body>
    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h5 class="max center-align" id="titolo">Modifica i dati utente</h5>
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


    <main>
        <h5>Modifica dati utente</h5>

        <div id="id-segnalazione">
            <form action = "aggiorna-utente" id="form-segnalazione" method="POST">


                <label for="">
                    <h6>Scegli il ruolo</h6>
                </label>
                <div class="field middle-align">
                    <nav>
                        <label class="radio">
                            <input type="radio" name="ruolo" value="utente" class="radio_ruolo">
                            <span>Utente</span>
                        </label>
                        <label class="radio">
                            <input type="radio" name="ruolo" value="tecnico" class="radio_ruolo">
                            <span>Tecnico</span>
                        </label>
                        <label class="radio">
                            <input type="radio" name="ruolo" value="collaboratore" class="radio_ruolo">
                            <span>Collaboratore</span>
                        </label>
                        <label class="radio">
                            <input type="radio" name="ruolo" value="admin" class="radio_ruolo">
                            <span>Amministratore</span>
                        </label>

                    </nav>
                </div>

                <label for="">
                    <h6>Ban</h6>
                </label>
                <div class="field middle-align">
                    <nav>
                        <label class="radio">
                            <input type="radio" name="ban" value="no" class="radio_ban">
                            <span>No</span>
                        </label>
                        <label class="radio">
                            <input type="radio" name="ban" value="si" class="radio_ban">
                            <span>Si</span>
                        </label>
                    </nav>
                </div>


                <div id="mansione">
                    <label for="">
                        <h6>Mansione</h6>
                    </label>
                    <div class="field textarea border fill">
                        <textarea name="mansione"></textarea>
                    </div>
                </div>

                <input type="text" value="admin" name="id_utente" id="id_utente"  style="display:none" >
                            
                <button id="submit-button">
                    Salva i dati aggiornati
                </button>

            </form>
        </div>
    </main>

    <?php
    session_start();

    if (!isset($_SESSION["cookie"])) {
        echo file_get_contents("F_html/cookie.html");
    }

    ?>

    <!-- //BARRA LATERALE -->
    <script src="F_js/barralaterale.js"></script>
    <script>
        let main = document.querySelector("main");
        // let opzioni_ruolo = main.querySelectorAll("input[type='radio']");
        let opzioni_ruolo = main.querySelectorAll(".radio_ruolo");
        let opzioni_ban = main.querySelectorAll(".radio_ban");
        let mansione = main.querySelector("#mansione");

        let urlParams = new URLSearchParams(window.location.search);
        let utente = urlParams.get("id");
        let ruolo_utente = "";
        let ban_utente = false;
        fetch("utente/" + utente).then((response) => response.json()).then((json) => {
            console.log(json);
            
            document.querySelector("#id_utente").value = utente;
            ruolo_utente = json["ruolo"];

            document.querySelector("#titolo").innerText = "Modifica i dati utente di " + json["nome"] + " " + json["cognome"];





            //TODO impostare il ban
            if(json["ban"] == 1){
                opzioni_ban[1].checked = true;
            }
            else {
                opzioni_ban[0].checked = true;
            }

            for (var ruolo of opzioni_ruolo) {
                if (ruolo.value == ruolo_utente) {
                    ruolo.checked = true;
                }
            }
            for (var ruolo of opzioni_ruolo) {
                if (ruolo.checked && ruolo.value == 'tecnico') {
                    ruolo.checked = true;
                    mansione.style["display"] = "block";
                    mansione.querySelector("textarea").innerText = json["mansione"];
                    break;
                }
                
                mansione.style["display"] = "none";
            }

        });


        for (const ruolo of opzioni_ruolo) {


            ruolo.addEventListener("click", () => {
                if (ruolo.value == "tecnico") {
                    mansione.style["display"] = "block";
                }
                else {
                    mansione.style["display"] = "none";
                }
            });
        }


        let form = main.querySelector("form");
        // form.addEventListener("submit", (event)=>{
        //     let formData = new FormData(this);
        // });


    </script>

</body>

</html>