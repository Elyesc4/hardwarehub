let tiles = document.querySelectorAll('.tile')

tiles.forEach((element) => {
    element.addEventListener('click', (event) => {
        event.preventDefault();
        window.location.href=`/product/${element.dataset.id}`
    })
})