let tiles = document.querySelectorAll( "[aria-label=\"product\"]" );

tiles.forEach( ( element ) => {
  element.addEventListener( "click", ( event ) => {
    event.preventDefault();
    if ( element.dataset.id ) {
      window.location.href = `/product/${element.dataset.id}`;
    }
  } );
} );

const toggel = ( element1, element2 ) => {
  element1.style.display = "flex";
  element2.style.display = "none";
};

document.querySelectorAll( ".quantity" ).forEach( function( spinner ) {
  let input = spinner.querySelector( "input[type=\"number\"]" );
  let btnUp = spinner.querySelector( ".quantity-up" );
  let btnDown = spinner.querySelector( ".quantity-down" );
  let btnDelete = spinner.querySelector( ".quantity-delete" );
  let min = parseFloat( input.getAttribute( "min" ) );
  let max = parseFloat( input.getAttribute( "max" ) );

  [ btnDelete, btnDown ].forEach( ( element ) => {
    element.addEventListener( "click", ( event ) => {
      event.preventDefault();
      let request = new XMLHttpRequest();
      request.open( "POST", "/removeFromCart", true );
      let payLoad = new FormData( document.createElement( "form" ) );

      payLoad.append( "action", "delete" );
      payLoad.append( "product_count", input.value );

      request.onload = () => {
        if ( request.readyState === XMLHttpRequest.DONE ) {
          if ( request.status === 200 ) {
            console.log( request.response );

          }
        }
      };
      request.send( payLoad );
    } );
  } );

  input.addEventListener( "change", ( event ) => {
    event.preventDefault();
    if ( parseInt( input.value ) === 1 ) {
      btnDelete.style.display = "flex";
      btnDown.style.display = "none";
    } else {
      btnDelete.style.display = "none";
      btnDown.style.display = "flex";
    }
  } );

  btnUp.addEventListener( "click", function() {
    let oldValue = parseFloat( input.value );
    let newVal;
    if ( oldValue >= max ) {
      newVal = oldValue;
    } else {
      newVal = oldValue + 1;
    }
    input.value = newVal;
    input.dispatchEvent( new Event( "change" ) );
  } );

  btnDown.addEventListener( "click", function() {
    let oldValue = parseFloat( input.value );
    let newVal;
    if ( oldValue <= min ) {
      newVal = oldValue;
    } else {
      newVal = oldValue - 1;
    }
    input.value = newVal;
    input.dispatchEvent( new Event( "change" ) );
  } );
} );
