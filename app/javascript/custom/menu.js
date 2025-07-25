// 

document.addEventListener("DOMContentLoaded", () => {
  const dropdowns = document.querySelectorAll(".dropdown-toggle");
  dropdowns.forEach(dropdown => {
    if (dropdown) {
      dropdown.addEventListener("click", (event) => {
        event.preventDefault();
        const menu = dropdown.nextElementSibling;
        if (menu) {
          menu.classList.toggle("show");
        }
      });
    }
  });
});


// menu manipultation

//add toggle clicking listener
document.addEventListener("turbo:load", function(){
    let hamburger = document.querySelector("#hamburger");
    if (hamburger) {
        hamburger.addEventListener("click", function(event){
            event.preventDefault();
            let menu = document.querySelector("#navbar-menu");
            if (menu) {
                menu.classList.toggle("collapsed");
            }
        });
    }
})
