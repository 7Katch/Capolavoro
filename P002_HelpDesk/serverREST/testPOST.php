<body>

    <h1>TEST POST</h1>
    <p></p>

    <script>
        let p = document.createElement('p');

        let form = {"tipo":"dispositivo","dispositivo":"WS01","descrizione":"TEST POST","stanza":"3AA","id_utente":"davide.yeh@itiszuccante.edu.it"};
        fetch(
            "formDaMobile", {
            headers: { 'Content-Type': 'application/json' },
            method: "POST",
            body: JSON.stringify(form),
        }
        ).then((response) => response.json()).then((value) => {
            p.innerText = value["messaggio"];
        });

    </script>
</body>