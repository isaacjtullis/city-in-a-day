window.onload = function() {
  var trails = [];
  function printSignInForm() {
    console.log('Inside of here!');
    // if(){
    //   // add logic to either remove or add a class
    // }
    var className = document.getElementById("sign-in-form").classList;
    var hideSignUpForm = document.getElementById("sign-up-form").classList;
    console.log(className.value);
    if(className.value === 'hide-form'){
      if(hideSignUpForm.value === 'show-form'){
        document.getElementById("sign-up-form").classList.remove('show-form');
        document.getElementById("sign-up-form").classList.add('hide-form');
      }
      document.getElementById("sign-in-form").classList.remove('hide-form');
      document.getElementById("sign-in-form").classList.add('show-form');
    } else {
      document.getElementById("sign-in-form").classList.remove('show-form');
      document.getElementById("sign-in-form").classList.add('hide-form');
    }
    // document.getElementById("sign-in-form").classList.remove('hide-form');
  }

  function printSignUpForm() {
    console.log('Inside of here!');
    // if(){
    //   // add logic to either remove or add a class
    // }
    var className = document.getElementById("sign-up-form").classList;
    var hideSignInForm = document.getElementById("sign-in-form").classList;
    console.log(className.value);
    if(className.value === 'hide-form'){
      if(hideSignInForm.value === 'show-form'){
        document.getElementById("sign-in-form").classList.remove('show-form');
        document.getElementById("sign-in-form").classList.add('hide-form');
      }
      document.getElementById("sign-up-form").classList.remove('hide-form');
      document.getElementById("sign-up-form").classList.add('show-form');
    } else {
      document.getElementById("sign-up-form").classList.remove('show-form');
      document.getElementById("sign-up-form").classList.add('hide-form');
    }
    // document.getElementById("sign-in-form").classList.remove('hide-form');
  }

  function displayThisTrail(){
    // ajax (get) on click of load more
    console.log('insde of display more trails');
    // console.log(trails);
    trails.map((trail, index)=>{
      users.map(user=>{
        if((index + 1) <= 6){
          if(user.id === trail.user_id){
            console.log(trail);
            url = '/trails/'+trail.id+'';
            $('.display-trails').append('<div class="col-md-5 image"><img src='+trail.trail_photo.url+'>' + user.first_name + user.last_name +' <a href="' + url + '">' + trail.name + '</a>'+'</div>');
            trails.shift();
          }
        }
      });
    });
  }

  function loadTrails() {
    // ajax(get)
    trails = [];
    users = [];
    if(trails.length <=0){
      var request = $.ajax({
        method: "GET",
        url: `/api/v1/trails`
      });
      request.done((data)=>{
        trails = data;
        trails = data[0];
        users = data[1];
        displayTrails(trails,users);
      });
    }
    // console.log(trails);
    // if(trails.length >0){
    //   trails.map((trail, index) => {
    //     users.map(user=>{
    //       if((index + 1) <= 6){
    //         if(user.id === trail.user_id){
    //           console.log(trail);
    //           url = '/trails/'+trail.id+'';
    //           $('.display-trails').append('<div class="col-md-6 image"><img src='+trail.trail_photo.url+'>' + user.first_name + user.last_name +'<a href="' + url + '">' + trail.name + '</a>'+'</div>');
    //           trails.shift();
    //         }
    //       }
    //     });
    //   });
    // }
  }

  function displayTrails(trails, users){
    var url;
    trails.map((trail, index) => {
      users.map(user=>{
        if((index + 1) <= 6){
          if(user.id === trail.user_id){
            url = '/trails/'+trail.id+'';
            $('.display-trails').append('<div class="col-md-5 image"><img src='+trail.trail_photo.url+'>' + `${user.first_name} ` + `${user.last_name}` +' <a href="' + url + '">' + trail.name + '</a>'+'</div>');
            trails.shift();
          }
        }
      });
    });
  }

  // *** Nav bar  code ***
  // function fixNav() {
  //   console.log(topOfNav);
  //   console.log(window.scrollY);
  //   if(window.scrollY >= topOfNav){
  //     document.body.style.paddingTop = nav.offsetHeight + 'px';
  //     document.body.classList.add('fixed-nav');
  //   } else {
  //     document.body.style.paddingTop = 0;
  //
  //     document.body.classList.remove('fixed-nav');
  //   }
  // }
  // $('.locations .col-md-12 .col-xs-12').append('<ul>' + this.name + '</ul>');
  // <div class="col-md-6"><ul>' + trail.name + '</ul></div>
  // <div class="image">
  //   <%= image_tag trail.trail_photo.to_s %>
  //   <div class="trail-user-name">
  //     <%= trail.user.first_name %>
  //     <%= trail.user.last_name %>
  //     <%= link_to trail.name, trail_path(trail.id) %>
  //   </div>
  // </div>

  var signInForm = document.getElementsByClassName('sign-in-button');
  var signUpForm = document.getElementsByClassName('sign-up-button');
  var displayMoreTrails = document.getElementsByClassName('display-more-trails');
  // const nav = document.querySelector('.header.cover-photo');
  // const topOfNav = nav.offsetHeight;
  // window.addEventListener('scroll', fixNav);
  signInForm[0].addEventListener("click", printSignInForm, false);
  signUpForm[0].addEventListener("click", printSignUpForm, false);
  displayMoreTrails[0].addEventListener("click", displayThisTrail, false);
  loadTrails();
  // signInButton.addEventListener('click', printResults);




}
