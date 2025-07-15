// menu manipultation

//add toggle clicking listener
document.addEventListener("turbo:load", function(){
    let account = document.querySelector("#account");
    account.addEventListener("click", function(event){
        event.preventDefault();
        event.stopPropagation();
        let menu = document.querySelector("#dropdown-menu");
        menu.classList.toggle("active");

    })
})