<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy - Helpdesk</title>
    <link href="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.css" rel="stylesheet">
    <script type="module" src="https://cdn.jsdelivr.net/npm/beercss@3.5.1/dist/cdn/beer.min.js"></script>
    <script type="module"
        src="https://cdn.jsdelivr.net/npm/material-dynamic-colors@1.1.0/dist/cdn/material-dynamic-colors.min.js"></script>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/4969/4969093.png">
    <style>
        :root {
            --d_b: 30%;
            /*distanza_bordo*/
        }

        h6 {
            font-size: 16px;
            font-weight: bold;
        }

        main {
            /* background-color: orange; */
            width: 100%;
            display: flex;
            flex-direction: column;
            margin-top: 2%;
            padding-left: var(--d_b);
            padding-right: var(--d_b);
        }

        main h5 {
            font-size: 22px;
            font-weight: bold;
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
    </style>

</head>

<body>

    <header>
        <nav>
            <button class="circle transparent" id="menu-tendina">
                <i>menu</i>
            </button>
            <h4 class="max center-align">Helpdesk dello Zuccante</h4>
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

        <h3><b>Privacy Policy</b></h3>
        <div class="large-divider"></div>



        <div class="container">

            <h5>1. Introduzione</h5>
            <p>
                1. In questa sezione sono contenute le informazioni relative alle modalità di gestione del progetto
                istituzionale, di proprietà di codesto Istituto Scolastico, in riferimento al trattamento dei dati degli
                utenti del sito stesso.
                <br>
                2. La presente informativa ha valore anche ai fini dell’articolo 13 del Regolamento (UE) n. 2016/679,
                relativo alla protezione delle persone fisiche con riguardo al trattamento dei dati personali nonché
                alla libera circolazione di tali dati, per i soggetti che interagiscono con il progetto istituzionale.
                <br>
                3. L’informativa è resa solo per il progetto istituzionale e non anche per altri siti web eventualmente
                consultati dall’utente tramite link in esso contenuti.
                <br>
                4. Scopo del presente documento è fornire indicazioni circa le modalità, i tempi e la natura delle
                informazioni che i titolari del trattamento devono fornire agli utenti al momento della connessione alle
                pagine web del progetto istituzionale, indipendentemente dagli scopi del collegamento stesso, secondo la
                legislazione Italiana ed Europea.
                <br>
                5. L’informativa può subire modifiche a causa dell’introduzione di nuove norme al riguardo, si invita
                pertanto l’utente a controllare periodicamente la presente pagina.
                <br>
                6. Se l’utente ha meno di quattordici anni, ai sensi dell’art.8, c.1 regolamento (UE) 2016/679, e
                dell’Art. 2 – Quinquies del D.Lgs 196/2003, così come modificato dal D.Lgs 181/18, dovrà legittimare il
                suo consenso attraverso l’autorizzazione dei genitori o di chi ne fa le veci.
            </p>

            <h5>2. Titolare del trattamento</h5>
            <p>
                1. Il titolare del trattamento è la persona fisica o giuridica, l’autorità pubblica, il servizio o altro
                organismo che, singolarmente o insieme ad altri, determina le finalità e i mezzi del trattamento di dati
                personali. Si occupa anche dei profili sulla sicurezza.
                <br>
                2. Relativamente al presente sito web il titolare del trattamento è il developer in questione, e per
                ogni chiarimento o esercizio dei diritti dell’utente potrà contattarlo all’indirizzo mail istituzionale.
                <br>
            </p>
            <h5>3. Luogo trattamento dati</h5>
            <p>
                1. Il trattamento dei dati generato dall’utilizzo del servizio Web avviene presso il computer in cui è
                presente il server e il database del developer.
                <br>
                2. In caso di necessità, i dati connessi al servizio newsletter possono essere trattati dal responsabile
                del trattamento o soggetti da esso incaricati a tal fine presso la relativa sede.
            </p>

            <h5>4. Cookie</h5>
            <p>
                1. In questa sezione viene descritto in che modo questo Sito e terze parti utilizzano i cookie e
                tecnologie similari. L’utilizzo dei cookie avviene nel rispetto della relativa normativa europea
                (direttiva 2009/136/CE ha modificato la direttiva 2002/58/CE “E Privacy) e nazionale (Provvedimento
                Garante per la protezione dei dati personali dell’8 maggio 2014 e successivi chiarimenti nonché Linee
                Guida cookie e altri strumenti di tracciamento del 10 giugno 2021 n.231).
                <br>
                2. Per avere informazioni complete riguardo ai cookies visitare la sezione dedicata alla nostra cookie
                policy.
            </p>

        </div>
    </main>


    <?php
    echo file_get_contents("F_html/footer.html");
    ?>


    <script>
        let button = document.querySelector("#stanza");
        button.addEventListener("click", () => {
            console.log(window.location.href);
            window.location.href = "stanza";
        });

        let login = document.querySelector("#login");
        login.addEventListener("click", () => {
            window.location.href = "auth";

            console.log(window.location.href);
        });

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



        let btn_accetta = cookie.querySelector("#accetta");
        btn_accetta.addEventListener("click", () => {
            setCookie("cookie_accept", true, 30);
        });

        cookieMessage = () => {
            if (!getCookie("cookie_accept")) {
                cookie.style["display"] = "block";
            }
        };
        window.addEventListener("load", cookieMessage);



        let preferenze = cookie.querySelector("#preferenze");
        preferenze.addEventListener("click", () => {
            window.location.href = "custom_cookie";
        });



    </script>

    <!-- //BARRA LATERALE -->
    <script src="F_js/barralaterale.js"></script>







</body>

</html>