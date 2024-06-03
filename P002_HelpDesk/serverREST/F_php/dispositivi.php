<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="google" content="notranslate">
    <title>Dispositivi - Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
        <link rel="icon" href="https://www.itiszuccante.edu.it/wp-content/uploads/2024/03/ZuccanteSquared.png">
</head>


<style>
    #container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-evenly;
    }

    .schema {
        width: fit-content;
        margin: 20px;

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

</style>

<body>
    <?php
    session_start();
    ?>
    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h5 class="max center-align">Helpdesk dello Zuccante</h5>
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
                <a href="/P002_Helpdesk/ServerREST/logout">
                    <i>output</i>
                    <span>Logout</span>
                </a>
            </nav>
        </dialog>
    </div>




    <button id="history-btn">Vai alla history della stanza </button>
    <div id="container"></div>

    <script src="F_js/barralaterale.js"></script>
    <script>
        let schema = document.querySelector("#container");
        const urlParams = new URLSearchParams(window.location.search);
        let nomeStanza = urlParams.get("s");
        //Nome alla sezione
        let header = document.querySelector("header");
        let title = header.querySelector("h5");
        title.innerText = nomeStanza;



        let btn_history = document.querySelector("#history-btn");
        btn_history.addEventListener("click", ()=>{
            
            window.location.href = "history?s="+ nomeStanza;
        });


        fetch("dispositivi?stanza=" + nomeStanza).then((value) => value.json()).then((infoSchema) => {

            

            let div = document.createElement("div");
            for (let a in infoSchema) {
                let infoDisp = infoSchema[a];
                let visualizza = "<button id='visualizza'>Visualizza</button>";
                let template_dispositivo =
                    `<div class="schema">
                            <article class="no-padding round">
                                <img class="responsive small top-round" src="https://static.vecteezy.com/system/resources/previews/021/190/154/original/desktop-computer-pc-outline-icon-in-transparent-background-basic-app-and-web-ui-bold-line-icon-eps10-free-vector.jpg">
                                <div class="padding">
                                <i id='alert'>Notifications</i>
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

                btn_segnala.addEventListener("click",()=>{
                    window.open("segnala?s="+nomeStanza + "&d=" + infoDisp["nome"]);
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
                                console.log(json);

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
                                console.log(json);





                            });
                        }
                    });



                let visualizza_btn = div.querySelector("#visualizza");
                visualizza_btn.addEventListener("click",()=>{
                    // window.location.href = "segnalazioni?d=" + infoDisp["id"];
                    window.location.href = "history?d=" +infoDisp["id"] + "&n="+ infoDisp["nome"];
                });





                schema.appendChild(div);
                div = document.createElement("div");


            };
        });

    </script>
</body>

</html>