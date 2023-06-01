let tiles = document.querySelectorAll('[aria-label="product"]')

tiles.forEach((element) => {
    element.addEventListener('click', (event) => {
        event.preventDefault();
        if ( element.dataset.id ) {
          window.location.href=`/product/${element.dataset.id}`
        }
    })
})