<?php

session_start();
if (!($_SESSION["google_id"])) {
    header("Location: auth");
}

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="google" content="notranslate">
    <title>Alert - Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://www.itiszuccante.edu.it/wp-content/uploads/2024/03/ZuccanteSquared.png">


    <style>
        #filtro {
            margin-top: 20px;
            margin-left: 30px;
            padding: 5px;
            display: flex;
            flex-direction: row;
            height: 10vh;


        }

        #filtro_btn {
            width: 100px;
            z-index: 99;
        }

        menu {
            width: fit-content;
        }

        #content {
            margin: 0 100px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly;
            min-height: 100vh;
        }


        .schema {
            width: auto;
            min-height: fit-content;
            margin: 20px;
            display: block;

        }

        .schema:hover {
            transition-duration: 0.5s;
        }


        #alert {
            /* background-color: orange; */
            cursor: pointer;
            position: absolute;
            z-index: 1;
            right: 10px;

        }


        .alert-aggiunto {
            background-color: orange;
        }

        #search {
            width: 500px;

        }


        #footer {
            display: none;
        }
    </style>
</head>

<body>
    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h5 class="max center-align">I tuoi alert</h5>
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


    <nav id="filtro">
        <div class="field large prefix round fill" id="search">
            <i class="front">search</i>
            <input placeholder="Es: 5IA">
        </div>



        <button id="filtro_btn">
            <i>Tune</i>
            <span>Filtro</span>
            <menu class="scroll">
                <div class="field middle-align filtro-stanza">
                    <nav>
                        <div class="max">
                            <h6>Aule</h6>
                        </div>
                        <label class="switch">
                            <input id="aula" type="checkbox" checked>
                            <span></span>
                        </label>
                    </nav>
                </div>
                <div class="field middle-align filtro-stanza">
                    <nav>
                        <div class="max">
                            <h6>Laboratori</h6>
                        </div>
                        <label class="switch">
                            <input id="laboratorio" type="checkbox" checked>
                            <span></span>
                        </label>
                    </nav>
                </div>
                <div class="field middle-align filtro-stanza">
                    <nav>
                        <div class="max">
                            <h6>Uffici</h6>
                        </div>
                        <label class="switch">
                            <input id="ufficio" type="checkbox" checked>
                            <span></span>
                        </label>
                    </nav>
                </div>
                <div class="field middle-align filtro-stanza">
                    <nav>
                        <div class="max">
                            <h6>Bagni</h6>
                        </div>
                        <label class="switch">
                            <input id="bagno" type="checkbox" checked>
                            <span></span>
                        </label>
                    </nav>
                </div>
                <div class="field middle-align filtro-stanza">
                    <nav>
                        <div class="max">
                            <h6>Bar</h6>
                        </div>
                        <label class="switch">
                            <input id="bar" type="checkbox" checked>
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
        let info_stanze;
        let info_alerts;
        let info_disp;
        let contenuti = [];


        fetch("alerts").then((response) => response.json()).then((json) => {
            //otteniamo i dati degli alerts
            info_alerts = json;

            fetch("dispositivi").then((response) => response.json()).then((json) => {
                info_disp = json;
                fetch("stanze").then((value) => value.json()).then((json) => {
                    info_stanze = json;


                    // console.log(info_stanze);
                    // console.log(info_alerts);
                    // console.log(info_disp);


                    let div = document.createElement("div");

                    for (const row of info_alerts) {
                        if (row["dispositivo"] == null) {

                            let infoStanza = info_stanze[row["stanza"] - 1];
                            let tipoStanza = infoStanza["tipo"];
                            let percorso = "";
                            switch (tipoStanza) {
                                case "aula":
                                    percorso = "https://static.vecteezy.com/ti/vettori-gratis/p3/7560526-icona-aula-online-vettoriale.jpg";
                                    break;
                                case "laboratorio":
                                    percorso = "https://us.123rf.com/450wm/andreanprabowo/andreanprabowo2107/andreanprabowo210700063/172246206-icona-del-laboratorio-in-stile-piatto-per-qualsiasi-progetto-da-utilizzare-per-la-presentazione.jpg?ver=6";
                                    break;
                                case "bagno":
                                    percorso = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Italian_traffic_signs_-_icona_wc.svg/1200px-Italian_traffic_signs_-_icona_wc.svg.png";
                                    break;
                                case "ufficio":
                                    percorso = "https://us.123rf.com/450wm/hironicons/hironicons2208/hironicons220800092/190527681-affari-ufficio-icona-della-finanza-%C3%A8-isolato-su-sfondo-bianco-utilizzo-per-grafica-e-web-design-o.jpg";
                                    break;
                                default:
                                    percorso = "https://img.freepik.com/premium-vector/coffee-cup-icon_24381-2216.jpg";
                                    break;
                            }

                            let button = "<button>Visualizza</button>";

                            let template = `
                                <div class="schema">
                                    <article class="no-padding round">
                                        <img class="responsive small top-round" src="${percorso}">
                                        <div class="padding">
                                        
                                        <i id='alert' class='alert-aggiunto'>Notifications</i>
                                        <h5>${infoStanza["nome"]}</h5>
                                        <nav>
                                            ${button}
                                            <button class="bottone-segnala" style='visibility : hidden'>Segnala</button>
                                        </nav>
                                        </div>
                                    </article>
                                </div>
                                `;


                            div.innerHTML = template;
                            schema.appendChild(div);
                            contenuti.push({
                                "div": div,
                                "dati": infoStanza
                            });



                            let btn = div.querySelector("button");

                            let alert = div.querySelector("#alert");
                            alert.addEventListener("click", () => {
                                if (alert.classList.contains("alert-aggiunto")) {

                                    let dati = {
                                        "id_stanza": infoStanza["codice"],
                                        "id_dispositivo": null
                                    };


                                    fetch("eliminaAlert", {
                                        method: "POST",
                                        headers: {
                                            "Content-Type": "application/json"
                                        },
                                        body: JSON.stringify(dati)
                                    }).then((response) => response.json()).then((json) => {


                                        console.log("RIMOSSO l'allert");
                                        alert.classList.remove("alert-aggiunto");

                                    });

                                }
                                else {
                                    alert.classList.add("alert-aggiunto");
                                    console.log("aggiunto l'allert");

                                    let dati = {
                                        "id_stanza": infoStanza["codice"],
                                        "id_dispositivo": null
                                    };

                                    fetch("aggiungiAlert", {
                                        method: "POST",
                                        headers: {
                                            "Content-Type": "application/json"
                                        },
                                        body: JSON.stringify(dati)
                                    }).then((response) => response.json()).then((json) => {
                                    }
                                    );
                                }
                            }
                            );

                            btn.addEventListener("click", () => {

                                window.location.href = "stanza?s=" + infoStanza["nome"];

                            });

                            let btn_segnala = div.querySelector(".bottone-segnala");
                            btn_segnala.addEventListener("click", () => {
                                window.open("segnala?s=" + infoStanza["nome"]);
                            });

                            div = document.createElement("div");
                        }
                        else {
                            let infoDisp = info_disp[row["dispositivo"] - 1];
                            let visualizza = "<button id='visualizza'>Visualizza</button>";
                            let template_dispositivo =
                                `<div class="schema">
                            <article class="no-padding round">
                                <img class="responsive small top-round" src="https://static.vecteezy.com/system/resources/previews/021/190/154/original/desktop-computer-pc-outline-icon-in-transparent-background-basic-app-and-web-ui-bold-line-icon-eps10-free-vector.jpg">
                                <div class="padding">
                                
                                <i id='alert' class='alert-aggiunto'>Notifications</i>
                                <h5>${infoDisp["nome"]}</h5>
                                <nav>
                                    ${visualizza}
                                    <button class="bottone-segnala">Segnala</button>
                                </nav>
                                </div>
                            </article>
                        </div>`;
                            div.innerHTML = template_dispositivo;

                            let btn_segnala = div.querySelector(".bottone-segnala");

                            btn_segnala.addEventListener("click", () => {
                                window.open("segnala?s=" + nomeStanza + "&d=" + infoDisp["nome"]);
                            });

                            let visualizza_btn = div.querySelector("#visualizza");
                            visualizza_btn.addEventListener("click", () => {
                                // window.location.href = "segnalazioni?d=" + infoDisp["id"];
                                window.location.href = "history?d=" + infoDisp["id"] + "&n=" + infoDisp["nome"];
                            });


                            let alert = div.querySelector("#alert");
                            alert.addEventListener("click", () => {
                                if (alert.classList.contains("alert-aggiunto")) {

                                    let dati = {
                                        "id_stanza": null,
                                        "id_dispositivo": infoDisp["id"]
                                    };


                                    fetch("eliminaAlert", {
                                        method: "POST",
                                        headers: {
                                            "Content-Type": "application/json"
                                        },
                                        body: JSON.stringify(dati)
                                    }).then((response) => response.json()).then((json) => {


                                        console.log("RIMOSSO l'allert");
                                        alert.classList.remove("alert-aggiunto");

                                    });

                                }
                                else {
                                    alert.classList.add("alert-aggiunto");
                                    console.log("aggiunto l'allert");


                                    let dati = {
                                        "id_stanza": null,
                                        "id_dispositivo": infoDisp["id"]
                                    };

                                    fetch("aggiungiAlert", {
                                        method: "POST",
                                        headers: {
                                            "Content-Type": "application/json"
                                        },
                                        body: JSON.stringify(dati)
                                    }).then((response) => response.json()).then((json) => {
                                    }
                                    );
                                }
                            }
                            );


                            schema.appendChild(div);
                            div = document.createElement("div");
                        }
                    }





                    //Funzioni di filtro
                    let filtro_btn = document.querySelectorAll("input[type='checkbox']");

                    //array da 3 elementi booleani
                    //ogni valore booleano equivale a filtro vero o falso se è applicato
                    //[input, vero]
                    let opt_visible = {
                        "aula": true,
                        "laboratorio": true,
                        "ufficio": true,
                        "bagno": true,
                        "bar": true,
                        "seleziona-tutti": true
                    };


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
                                        let c = contenuti[i]["div"];

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
                                        let c = contenuti[i]["div"];
                                        c.style["display"] = "block";
                                    }
                                }
                            });

                        }
                        else {
                            input.addEventListener("change", () => {

                                if (input.checked) {
                                    opt_visible[input.id] = true;
                                    // console.log(opt_visible);

                                    for (let i in contenuti) {
                                        let c = contenuti[i]["div"];
                                        if (contenuti[i]["dati"]["tipo"] == input.id) {
                                            c.style["display"] = "block";
                                        }
                                    }
                                }
                                else {
                                    opt_visible[input.id] = false;
                                    // console.log(opt_visible);
                                    for (let i in contenuti) {
                                        let c = contenuti[i]["div"];
                                        if (contenuti[i]["dati"]["tipo"] == input.id) {
                                            c.style["display"] = "none";
                                        }
                                    }
                                }

                            });
                        }
                    }

                    let barra = (document.querySelector("#search")).querySelector("input");
                    barra.addEventListener("input", () => {
                        for (let i in contenuti) {

                            //Se la stanza è nascosta dal filtro allora non si deve eseguire l'operazione del filtro
                            let nomeStanza = ((contenuti[i]["div"].querySelector("h5")).innerText).toLowerCase();
                            if (opt_visible[contenuti[i]["dati"]["tipo"]]) {
                                if (nomeStanza.includes(barra.value.toLowerCase())) {
                                    let c = contenuti[i]["div"];
                                    c.style["display"] = "block";
                                }
                                else {
                                    let c = contenuti[i]["div"];
                                    c.style["display"] = "none";
                                }
                            }


                        }
                    });
                });

            });
        });


    </script>
    <!-- //BARRA LATERALE -->
    <script src="F_js/barralaterale.js"></script>
</body>

</html>