<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/4969/4969093.png">
    <!-- <link rel="stylesheet" href="F_css/style.css"> -->
    <style>
        :root {
            --d_b: 30%;
            /*distanza_bordo*/
        }

        body{
            display: flex;
            flex-direction: column;
        }


        h6 {
            font-size: 16px;
            font-weight: bold;
        }

        main {
            /* background-color: orange; */
            width: 100%;
            height: 100vh;
            display: flex;
            flex-direction: row;
            margin-top: 2%;
            padding-left: var(--d_b);
            padding-right: var(--d_b);
        }

        main a {
            text-decoration: underline;
        }

        main #rifiuta {
            background-color: #c7b8f0;
            color: black;
        }

        main ul,
        main li {
            margin-left: 3%;
        }

        main ul {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        main #right-button {
            text-align: right;
        }

        #footer{
            
        }
    </style>

</head>

<body>

    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h4 class="max center-align">Personalizza i Cookies</h4>
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
                    <i>Logout</i>
                    <span>Logout</span>
                </a>
            </nav>
        </dialog>
    </div>

    <main>
        <div class="container">
            <h5>Cookie e scelte pubblicitarie</h5>
            <p>
                Utilizziamo i cookie per gli scopi riportati in seguito.<br>
                Anche terze parti approvate utilizzano i cookie per scopi limitati
                correlati alla pubblicità descritti di seguito. Applicheremo le tue preferenze sui cookie a questo
                servizio Helpdesk dello Zuccante(versione sito web e app) a cui hai effettuato l'accesso. Se non
                effettui l'accesso,
                potrebbe essere necessario richiederti nuovamente le preferenze. Per ulteriori informazioni sui cookie e
                su come li utilizziamo,
                consulta la nostra <a href="cookie-policy-ue">Informativa sui cookie</a>. <br>
                *IMPORTANTE* Il pulsante rifiuta farà sì che tu accetti solo i cookie essenziali, quelli che fanno
                funzionare il sito.

            </p>
            <button id="accetta">
                <i>cookie</i>
                <span>Accetta tutto</span>
            </button>
            <button id="rifiuta">
                <i>close</i>
                <span>Rifiuta tutto</span>
            </button>

            <h6>Cookie operativi</h6>
            <p>
                I cookie operativi non possono essere disabilitati in quanto vengono utilizzati
                per fornirti i nostri servizi. Ad esempio :
            </p>
            <ul>
                <li>Per riconoscerti quando accedi per utilizzare questo servizio</li>
                <li>Per tenere traccia delle tue segnalazioni</li>
                <li>Per migliorare la sicurezza</li>
                <li>Per tenere traccia delle tue preferenze</li>
                <li>Per migliorare il servizio</li>
            </ul>

            <div class="field middle-align filtro-stanza">
                <nav>
                    <div class="max">
                        <h6>Cookie statistici</h6>
                    </div>
                    <label class="switch">
                        <input id="cookie-statistico" type="checkbox" checked>
                        <span></span>
                    </label>
                </nav>
            </div>
            <p>
                Questi tipi di cookie vengono usati per analisi, permettendo al servizio di capire come
                interagisci con esso. Queste informazioni consentono al servizio di migliorare i contenuti e
                di creare funzionalità più utili che migliorano la tua esperienza.
                Queste informazioni non verranno distribuiti a scopo di lucro ad aziende di terze parti.
            </p>

            <div id="right-button">
                <button class>Salva</button>
            </div>

        </div>
    </main>


    <?php
    echo file_get_contents("F_html/footer.html");
    ?>


    <script>

        // let login = document.querySelector("#login");
        // login.addEventListener("click", () => {
        //     window.location.href = "auth";

        //     console.log(window.location.href);
        // });

        setCookie = (name, value, expDays) => {
            let date = new Date();
            //scadenza cookie
            date.setTime(date.getTime() + (expDays * 24 * 60 * 60 * 1000));
            const expires = "expires=" + date.toUTCString();
            document.cookie = name + "=" + value + ";" + expires + "; path/";
        };

        getCookie = (cName) => {
            const name = cName + "=";
            const cDecoded = decodeURIComponent(document.cookie);
            const cArr = cDecoded.split("; ");
            let value;
            cArr.forEach(val => {
                if (val.indexOf(name) === 0) value = val.substring(name.length);
            });
            return value;
        };

        let btn_accetta = document.querySelector("#accetta");
        btn_accetta.addEventListener("click", () => {
            // setCookie("cookie_accept",true,30);
            console.log("Hai accettato di vendere i tuoi dati a noi, grazie");
            //30 sono i giorni
            setCookie("cookie_accept", true, 30);
            window.location.href = "index";

        });


        let btn_rifiuta = document.querySelector("#rifiuta");
        btn_rifiuta.addEventListener("click", () => {
            // setCookie("cookie_accept",true,30);
            console.log("Pensi di aver rifiutato ma grazie per averci ancora dato il consenso");
            window.location.href = "index";
        });



        cookieMessage = () => {
            if (!getCookie("cookie_accept")) {
                console.log("Non ancora accettato i cookie");
            }
        };
        window.addEventListener("load", cookieMessage);



    </script>

    <!-- //BARRA LATERALE -->
    <script src="F_js/barralaterale.js"></script>




</body>

</html>