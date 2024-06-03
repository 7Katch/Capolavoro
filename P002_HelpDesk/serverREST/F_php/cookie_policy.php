<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cookie Policy (UE) - Helpdesk</title>
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

        <h3><b>Cookie Policy (UE)</b></h3>
        <div class="large-divider"></div>



        <div class="container">
            <p>
                Questa politica sui cookie è stata aggiornata l’ultima volta il 14 Novembre 2023 e si applica
                ai cittadini e ai residenti permanenti legali dello Spazio Economico Europeo e della Svizzera.

            </p>
            <h5>1. Introduzione</h5>
            <p>
                Il servizio web e utilizzana i cookie e altre tecnologie correlate
                (in seguito tutte le tecnologie per comodità verranno chiamate cookie).
                Successivamente ti informiamo sull'uso dei cookie sul nostro sito web.

            </p>

            <h5>2. Cosa sono i cookie?</h5>
            <p>
                I cookie sono dei semplici file spediti assieme alle pagine di questo sito
                e salvati dal tuo browser sul disco rigido del tuo computer o altri dispositivi.
                Le informazioni raccolte in essi possono venire rispediti ai nostri server oppure
                ai server di terze parti durante la prossima visita.
            </p>



            <p>
            <h5>3. Cosa sono gli script?</h5>
            Uno script è un pezzo di codice usato per far funzionare correttamente ed interattivamente il nostro sito.
            Questo codice viene eseguito sui nostri server o sul tuo dispositivo.
            </p>

            <h5>4. Cosa è un web beacon?</h5>
            <p>
                Un web beacon (o pixel tag) è un piccolo, invisibile pezzo di testo o immagine su un sito
                che viene usato per monitorare il traffico di un sito web. Per fare questo, diversi dati su
                di te vengono conservati utilizzando dei web beacon.
            </p>

            <h5>5. Cookie</h5>
            <p>
            <p><b>1. Cookie tecnici o funzionali</b></p>

            Alcuni cookie assicurano il corretto funzionamento del sito e che le tue preferenze rimangano valide.
            Piazzando cookie funzionali, rendiamo più facile per te usufruire del nostro servizio. In questo modo non
            devi inserire ripetutamente le stesse informazioni quando visiti il nostro sito web, per esempio, la tua
            segnalazione rimane in bozza finché non clicchi il tasto 'invia segnalazione'. Possiamo piazzare questi
            cookie senza il tuo
            consenso.
            </p>
            <p>
            <p><b>2. Cookie statistici</b></p>

            Utilizziamo i cookie statistici per ottimizzare l’esperienza del sito web per i nostri utenti. Con questi
            cookie statistici otteniamo approfondimenti sull’uso del nostro sito web. Chiediamo il tuo permesso per
            piazzare cookie statistici.
            </p>

            <h5>6. Cookie inseriti</h5>
            <ul>
                <li>PHPsession</li>
                <li>Segnalazione</li>
            </ul>
            <p>Il cookie PHPsession è di tipo funzionale e serve ad evitare che l'utente ogni volta faccia il login
                dentro il servizio web</p>
            <p>Il cookie Segnalazione è di tipo statistico e serve a capire quante volte i dispositivi di una scuola
                vengono riportati allo scopo di arrivare risolvere i problemi una volta per tutte.
            </p>

            <h5>7. Consenso</h5>
            <p>
                Quando visiti il sito web per la prima volta, noi mostreremo un popup con una spiegazione dei cookie.
                Appena clicchi su “Salva preferenze”, dai il permesso a noi di usare le categorie di cookie e plugin
                come descritto in questa dichiarazione relativa ai popup e cookie. Puoi disabilitare i cookie attraverso
                il tuo browser, ma prendi in considerazione, che il nostro sito web potrebbe non funzionare più
                correttamente.
            </p>


            <h5>8. Abilitare/disabilitare e cancellazione dei cookie</h5>
            <p>
                Puoi usare il tuo browser per cancellare automaticamente o manualmente i cookie. È anche possibile
                specificare che determinati cookie non possono essere piazzati. Un’altra opzione è quella di modificare
                le impostazioni del tuo browser internet in modo da ricevere un messaggio ogni volta che viene inserito
                un cookie. Per ulteriori informazioni su queste opzioni, consultare le istruzioni nella sezione Guida
                del tuo browser.

                Tieni presente che il nostro sito web potrebbe non funzionare correttamente se tutti i cookie sono
                disabilitati. Se cancelli i cookie nel vostro browser, essi verranno nuovamente inseriti dopo il
                consenso fornito quando visiterete nuovamente il nostro sito web.
            </p>

            <h5>9. I tuoi diritti in relazione ai dati personali</h5>
            <p>
                Hai i seguenti diritti relativi ai tuoi dati personali:
            </p>
            <ul>
                <li>Hai il diritto di sapere quando i tuoi dati personali sono necessari, cosa succede ad essi, quanto a
                    lungo verranno mantenuti.
                </li>
                <li>
                    Diritto di accesso: hai il diritto ad accedere ai tuoi dati personali dei quali siamo a conoscenza.
                </li>

                <li>
                    Diritto di rettifica: hai il diritto di completare, correggere, cancellare o bloccare i tuoi dati
                    personali quando lo desideri.
                </li>
                <li>
                    Se ci darai il consenso per elaborare i tuoi dati, hai il diritto di revocare questo consenso e di
                    eliminare i tuoi dati personali.
                </li>
                <li>
                    Diritto di trasferire i tuoi dati: hai il diritto di richiedere tutti i tuoi dati dal controllore e
                    trasferirli tutti quanti ad un altro controllore.
                </li>
                <li>
                    Diritto di opposizione: hai il diritto di opporti al trattamento dei tuoi dati. Noi rispetteremo
                    questa scelta, a meno che non ci siano delle basi valide per trattarli.
                </li>
            </ul>
            <p>
                Per esercitare questi diritti, non esitate a contattarci. Si prega di fare riferimento ai dettagli di
                contatto in fondo a questa Cookie Policy. Se hai un reclamo su come gestiamo i tuoi dati, vorremmo
                sentirti, ma hai anche il diritto di presentare un reclamo all’autorità di vigilanza (l’Autorità per la
                Protezione dei Dati).
            </p>


            <h5>10. Dettagli di contatto</h5>
            <p>Per domande e/o commenti riguardo la Cookie Policy e questa dichiarazione, per favore contattaci usando i seguenti dati di contatto:</p>
            <p><span class="cmplz-contact-organisation">Istituto Tecnico Industriale Statale Carlo Zuccante</span><br>
                      Via Baglioni, 22 – 30173 Mestre (VE)<br>
                      Italia<br>
                    Sito web: <a href="https://www.itiszuccante.edu.it" role="link" data-focus-mouse="false">https://www.itiszuccante.edu.it</a><br>
                    Email: <span class="cmplz-contact-email">vetf04000t@istruzione.it</span><br>
                    <span class="cmplz-contact-telephone">Numero di telefono: 0415341046</span></p>

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