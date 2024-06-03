//Sezione barra laterale sinistra
let menu_btn = document.querySelector("#menu-tendina");
let close_menu_btn = document.querySelector("#chiusura-menu-tendina-sx");
let barra_laterale_sx = document.querySelector("#barra-laterale-sx");


//Sezione barra laterale destra
let barra_laterale_dx = document.querySelector("#barra-laterale-dx");
let icona = document.querySelector("#icona");



menu_btn.addEventListener("click", (event) => {
    event.stopPropagation();
    barra_laterale_sx.querySelector("dialog").classList.add("active");
    barra_laterale_sx.classList.add("active");

});

close_menu_btn.addEventListener("click", () => {
    barra_laterale_sx.querySelector("dialog").classList.remove("active");
    barra_laterale_sx.classList.remove("active");
});

barra_laterale_sx.addEventListener("click", () => {
    barra_laterale_sx.querySelector("dialog").classList.remove("active");
    barra_laterale_sx.classList.remove("active");
    
});

barra_laterale_sx.querySelector("dialog").addEventListener("click", (event) => {
    event.stopPropagation(); 
});


close_menu_btn = document.querySelector("#chiusura-menu-tendina-dx");

icona.addEventListener("click",()=>{
    // Impedisce la propagazione dell'evento
    event.stopPropagation();
    // Esegui solo la funzione del bottone
    barra_laterale_dx.querySelector("dialog").classList.add("active");
    barra_laterale_dx.classList.add("active");
});


close_menu_btn.addEventListener("click", () => {
    barra_laterale_dx.querySelector("dialog").classList.remove("active");
    barra_laterale_dx.classList.remove("active");
});

barra_laterale_dx.addEventListener("click", () => {
    barra_laterale_dx.querySelector("dialog").classList.remove("active");
    barra_laterale_dx.classList.remove("active");
    
});

barra_laterale_dx.querySelector("dialog").addEventListener("click", (event) => {
    event.stopPropagation(); 
});
