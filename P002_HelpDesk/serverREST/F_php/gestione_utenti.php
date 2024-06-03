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
    <title>User manager - Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/4969/4969093.png">


    <style>
        #content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly;
            min-height: 100vh;
        }


        .round {
            width: auto;
            height: fit-content;
            width: 300px;
            margin: 20px;
            display: block;

        }

        .schema:hover {
            transform: scale(1.1);
            transition-duration: 0.5s;
        }

        #search {
            width: 500px;

        }

        menu{
            width: fit-content;
        }

        #filtro {
            margin-top: 20px;
            margin-left: 30px;
            padding: 5px;
            display: flex;
            flex-direction: row;
            align-items: center;
        }
    </style>
</head>

<body>
    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h5 class="max center-align">Gestione utenti</h5>
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


    <nav class="" id="filtro">
        <div class="field large prefix round fill" id="search">
            <i class="front">search</i>
            <input placeholder="Es: Nome Cognome">
        </div>

        <button>
            <i>Tune</i>
            <span>Filtro</span>
            <menu>
            <div class="field middle-align filtro-stanza">
            <nav>
                <div class="max">
                    <h6>Utenti</h6>
                </div>
                <label class="switch">
                    <input id="utente" type="checkbox" checked>
                    <span></span>
                </label>
            </nav>
        </div>
        <div class="field middle-align filtro-stanza">
            <nav>
                <div class="max">
                    <h6>Tecnici</h6>
                </div>
                <label class="switch">
                    <input id="tecnico" type="checkbox" checked>
                    <span></span>
                </label>
            </nav>
        </div>
        <div class="field middle-align filtro-stanza">
            <nav>
                <div class="max">
                    <h6>Collaboratori</h6>
                </div>
                <label class="switch">
                    <input id="collaboratore" type="checkbox" checked>
                    <span></span>
                </label>
            </nav>
        </div>
        <div class="field middle-align filtro-stanza">
            <nav>
                <div class="max">
                    <h6>Ammistratori</h6>
                </div>
                <label class="switch">
                    <input id="admin" type="checkbox" checked>
                    <span></span>
                </label>
            </nav>
        </div>

        <div class="field middle-align filtro-stanza">
            <nav>
                <div class="max">
                    <h6>Seleziona tutti</h6>
                </div>
                <label class="switch">
                    <input id="seleziona-tutti" type="checkbox" checked>
                    <span></span>
                </label>
            </nav>
        </div>
            </menu>
        </button>

    </nav>

    <div id="content"></div>

    <?php
    echo file_get_contents("F_html/footer.html");
    ?>

    <script>

        let schema = document.querySelector("#content");
        let infoStanze;
        let contenuti = [];
        fetch("utenti").then((value) => value.json()).then((json) => {
            infoStanze = json;
            // console.log(infoStanze);

            let div = document.createElement("div");

            for (let a in json) {

                let infoUtente = json[a];
                let ruolo = infoUtente["ruolo"];
                let percorso = "";
                switch (ruolo) {
                    case "tecnico":
                    case "collaboratore":
                        percorso = "https://static-00.iconduck.com/assets.00/technician-icon-432x512-deg17okw.png";
                        break;
                    case "admin":
                        percorso = "https://cdn-icons-png.flaticon.com/512/78/78948.png";
                        break;
                    default:
                        percorso = "https://cdn-icons-png.freepik.com/256/1077/1077114.png?semt=ais_hybrid";
                        break;
                }

                let button = "<button>Visualizza</button>";

                let template =
                    `
                <article class="round">
                    <div class="row">
                        <img class="circle large" src="${percorso}">
                            <div class="max">
                                <h5>${infoUtente["nome"]} ${infoUtente["cognome"]} </h5>
                                <p> </p>
                                <nav>
                            ${button}
                        </nav>
                            </div>
                    </div>

                </article>`;


                div.innerHTML = template;
                schema.appendChild(div);
                contenuti.push([div, infoUtente["ruolo"]]);

                let btn = div.querySelector("button");

                btn.addEventListener("click", () => {
                    let id = (infoUtente["email"]).substring(0, (infoUtente["email"]).indexOf("@"));
                    window.location.href = "gestione-utenti?id=" + id;

                });
                div = document.createElement("div");

            };


            //Funzioni di filtro
            let filtro_btn = document.querySelectorAll("input[type='checkbox']");
            let opt_visible = [];
            console.log(filtro_btn)

            //array da 3 elementi booleani
            //ogni valore booleano equivale a filtro vero o falso se è applicato
            //[input, vero]
            opt_visible = {
                "utente": true,
                "tecnico": true,
                "collaboratore": true,
                "admin": true
            }
            for (let input of filtro_btn) {


                if (input.id == "seleziona-tutti") {
                    input.addEventListener("change", () => {
                        if (!input.checked) {
                            for (const [key, value] of Object.entries(opt_visible)) {
                                opt_visible[key] = false;
                            }

                            for (let spunta of filtro_btn) {
                                spunta.checked = false;
                            }


                            for (let i in contenuti) {
                                let c = contenuti[i][0];

                                c.style["display"] = "none";
                            }
                        }
                        else {
                            for (const [key, value] of Object.entries(opt_visible)) {
                                opt_visible[key] = true;
                            }

                            for (let spunta of filtro_btn) {
                                spunta.checked = true;
                            }

                            for (let i in contenuti) {
                                let c = contenuti[i][0];
                                c.style["display"] = "block";
                            }
                        }
                    });

                }
                else {
                    input.addEventListener("change", () => {

                        if (input.checked) {
                            opt_visible[input.id] = true;
                            console.log(opt_visible);

                            for (let i in contenuti) {
                                let c = contenuti[i][0];
                                if (contenuti[i][1] == input.id) {
                                    c.style["display"] = "block";
                                }
                            }
                        }
                        else {
                            opt_visible[input.id] = false;
                            console.log(opt_visible);
                            for (let i in contenuti) {
                                let c = contenuti[i][0];
                                if (contenuti[i][1] == input.id) {
                                    c.style["display"] = "none";
                                }
                            }
                        }

                    });
                }



            }

            //barra di ricerca
            //"input[type='checkbox']"
            let barra = (document.querySelector("#search")).querySelector("input");
            barra.addEventListener("input", () => {
                for (let i in contenuti) {

                    //Se la stanza è nascosta dal filtro allora non si deve eseguire l'operazione del filtro
                    let nomeStanza = ((contenuti[i][0].querySelector("h5")).innerText).toLowerCase();
                    if (opt_visible[contenuti[i][1]]) {
                        if (nomeStanza.includes(barra.value.toLowerCase())) {
                            let c = contenuti[i][0];
                            c.style["display"] = "block";
                        }
                        else {
                            let c = contenuti[i][0];
                            c.style["display"] = "none";
                        }
                    }


                }
            });

        });
    </script>
    <!-- //BARRA LATERALE -->
    <script src="F_js/barralaterale.js"></script>
</body>

</html>