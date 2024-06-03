<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Segnalazione - Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://www.itiszuccante.edu.it/wp-content/uploads/2024/03/ZuccanteSquared.png">


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
            <h5 class="max center-align">Segnala</h5>
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
        <h5>Effettua la tua segnalazione</h5>

        <div id="id-segnalazione">
            <form action="form" id="form-segnalazione" method="GET">


                <div class="field middle-align">
                    <nav>
                        <label class="radio">
                            <input type="radio" name="tipo" checked="checked" value="dispositivo">
                            <span>Dispositivo</span>
                        </label>
                        <label class="radio">
                            <input type="radio" name="tipo" value="stanza">
                            <span>Stanza</span>
                        </label>

                    </nav>
                </div>

                <label for="">
                    <h6>Scegli la classe</h6>
                </label>
                <div class="field label suffix border large fill">
                    <select id="opzioni-stanza" name="stanza">
                        <option>--seleziona--</option>
                    </select>
                    <label>Scegli la classe</label>
                    <i>arrow_drop_down</i>
                </div>


                <div id="dispositivo-container">
                    <label for="">
                        <h6>Scegli il dispositivo</h6>
                    </label>
                    <div class="field label suffix border large fill">
                        <select id="opzioni-dispositivo" name="dispositivo">

                            <option>--seleziona--</option>
                        </select>
                        <label>Scegli il dispostivo</label>
                        <i>arrow_drop_down</i>
                    </div>
                </div>


                <label for="">
                    <h6>Descrizione</h6>
                </label>
                <div class="field textarea border fill">
                    <textarea name="descrizione"></textarea>
                </div>

                <button id="submit-button">
                    Invia
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
        let opzioni_radio = main.querySelectorAll("input[type='radio']");
        let disp_container = main.querySelector("#dispositivo-container");

        let opzioni_stanza = main.querySelector("#opzioni-stanza");
        let opzioni_dispositivo = main.querySelector("#opzioni-dispositivo");


        fetch("stanze").then(value => value.json()).then(json => {
            json.sort((a, b) => {

                const nomeA = a.nome.toUpperCase();
                const nomeB = b.nome.toUpperCase();
                if (nomeA < nomeB) {
                    return -1;
                }
                if (nomeA > nomeB) {
                    return 1;
                }
                return 0;
            });


            for (let row of json) {
                let option = document.createElement("option");
                option.innerHTML = row["nome"];
                opzioni_stanza.appendChild(option);
            }
        }).then(() => {
            opzioni_radio[0].addEventListener("change", () => {
                disp_container.style["display"] = "block";

            });
            opzioni_radio[1].addEventListener("change", () => {
                disp_container.style["display"] = "none";
            });

            opzioni_stanza.addEventListener("change", () => {
                fetch("dispositivi?stanza=" + opzioni_stanza.value).then(value => value.json()).then(json => {
                    opzioni_dispositivo.innerHTML = ` <option>--seleziona--</option>`;
                    for (let row of json) {
                        let option = document.createElement("option");
                        option.innerHTML = row["nome"];
                        opzioni_dispositivo.appendChild(option);
                    }
                });

            });

            //Se l'utente ha raggiunto questa pagina tramite il click di un pulsante della pagina stanze
            let urlParams = new URLSearchParams(window.location.search);
            let stanza_selezionata = urlParams.get("s");
            console.log(stanza_selezionata);
            if (stanza_selezionata != null) {
                opzioni_stanza.value = stanza_selezionata;
            }

            if (urlParams.get("d") != null) {
                fetch("dispositivi?stanza=" + opzioni_stanza.value).then(value => value.json()).then(json => {
                    opzioni_dispositivo.innerHTML = ` <option>--seleziona--</option>`;
                    for (let row of json) {
                        let option = document.createElement("option");
                        option.innerHTML = row["nome"];
                        opzioni_dispositivo.appendChild(option);
                    }
                    return urlParams;
                }).then((urlParams) => {
                    if (opzioni_stanza.value != "--seleziona--") {
                        opzioni_dispositivo.value = urlParams.get("d");
                    }
                });
            }
            else {
                opzioni_radio[1].checked = "checked";
                disp_container.style["display"] = "none";
            }




        });




        let submit_button = main.querySelector("#submit-button");
        submit_button.addEventListener("click", (event) => {

            //controllare se i campi non sono vuoti
            if (opzioni_stanza.value == "--seleziona--") {
                alert("Manca la stanza del dispositio da segnalare!");
                event.preventDefault();
                return;
            }

            //controllare se i campi non sono vuoti
            if (opzioni_radio[0].value) {
                console.log("dispositivo selezionato");
            }

            if (disp_container.style["display"] == "none") {
                opzioni_dispositivo.value = "null";
            }
            if (opzioni_dispositivo.value == "--seleziona--") {
                alert("Mancato dispositivo");
                event.preventDefault();
                return;
            }

            //Se la opzione e' stanza, allora inviare il dispositivo con null


        });

    </script>

</body>

</html>