## Sito Web Helpdesk

La funzione di questo sito è di creare un applicativo web per la scuola in grado di riportare i guasti presenti all'interno dell'istituto

Le varie funzioni del sito sono le seguenti : 
- Una homepage
- Una pagina login con OAuth Google (deve esistere l'account Google del dominio @itiszuccante.edu.it)
- Una pagina in cui son presenti tutte le stanze della scuola Carlo Zuccante (Le altre scuole saranno implementate in futuro...)
- Una pagina di segnalazione dei guasti ai dispositivi


## Steps per il setup
1. Scaricare XAMPP
2. Attivare i servizi "**MySql**" e "**Apache**".
3. All'interno del servizio di MariaDB creare un database denominato "**helpdesk**".

#### Di seguito son stati portati da riga di comando i comandi per eseguire il codice per la creazione di un nuovo database. 
```
# mysql -u root
MariaDB [(none)]> CREATE DATABASE helpdesk;
```

4. Nel database "**helpdesk**" all'interno del servizio web **myPhpAdmin** importare i file contenuti all'interno della sottocartella sql **create.sql** e **insert.sql**.
#### Il servizio si può raggiungere attraverso il seguente URL se il server è sul computer locale.
```
http://localhost/phpmyadmin/
```

5. La cartella P002_Helpdesk deve essere spostata all'interno della cartelle **htdocs** di XAMPP.

6. nel file .htaccess all'interno della cartella **serverREST** copiare il seguente codice :
```
RewriteEngine On

RewriteBase /P002_helpdesk/serverREST/

RewriteRule ^(app|dict|ns|tmp)\/|\.ini$ - [R=404]

RewriteCond %{REQUEST_FILENAME} !-l
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d

RewriteRule .* index.php [L,QSA]

RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
```  

7. Si può accedere al sito web tramite il seguente URL :
```
http://localhost/P002_selpdesk/serverREST/
```
