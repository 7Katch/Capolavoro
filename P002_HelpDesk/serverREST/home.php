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
    <link rel="icon" href="https://www.itiszuccante.edu.it/wp-content/uploads/2024/03/ZuccanteSquared.png">
    <link rel="stylesheet" href="F_css/style.css">

</head>

<body>

    <header class="transparent">

        <div id="immagine">
            <img src="https://www.itiszuccante.edu.it/wp-content/uploads/2024/03/ZuccanteSquared.png" alt="">
            <h3>Helpdesk</h3>
        </div>
        <ul id="barra">
            <li>
                <button>
                    Home
                </button>
            </li>
            <li>
                <button>
                    Github
                </button>
            </li>

            <li>
                <button>
                    Accedi
                </button>
            </li>
        </ul>
    </header>


    <main>
        <h1>Helpdesk</h1>
        <p>Segnala i problemi in maniera veloce</p>
        <button id="stanza">
            Vai alle stanze
        </button>
        <?php
        session_start();
        $loginned = isset($_SESSION["google_id"]);
        $map = [true => "block", false => "none"];

        echo "   
                    <button id='login' style='display:{$map[!$loginned]}'>
                        Accedi con google
                    </button>
                    ";
        ?>

    </main>


    <?php
    echo file_get_contents("F_html/cookie.html");
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


    </script>

    <!-- //BARRA LATERALE -->

</body>

</html>