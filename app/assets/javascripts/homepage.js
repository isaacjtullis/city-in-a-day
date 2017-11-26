window.onload = function() {
  function printSignInForm() {
    console.log('Inside of here!');
    // if(){
    //   // add logic to either remove or add a class
    // }
    var className = document.getElementById("sign-in-form").classList;
    console.log(className.value);
    if(className.value === 'hide-form'){
      document.getElementById("sign-in-form").classList.remove('hide-form');
      document.getElementById("sign-in-form").classList.add('show-form');
    } else {
      document.getElementById("sign-in-form").classList.remove('show-form');
      document.getElementById("sign-in-form").classList.add('hide-form');
    }
    // document.getElementById("sign-in-form").classList.remove('hide-form');
  }

  var el = document.getElementsByClassName('sign-in-button')
  el[0].addEventListener("click", printSignInForm, false);
  // signInButton.addEventListener('click', printResults);
}
