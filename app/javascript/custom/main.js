// menu manipultation

//add toggle clicking listener
document.addEventListener("turbo:load", function(){
    let account = document.querySelector("#account");
    if (account) {
        account.addEventListener("click", function(event){
            event.preventDefault();
            event.stopPropagation();
            let menu = document.querySelector("#dropdown-menu");
            if (menu) {
                menu.classList.toggle("active");
            }
        });
    }
})