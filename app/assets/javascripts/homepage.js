var ready = function(){
  console.log('how many times do i fire?');
  var trails = [];
  $(document).on("click", ".sign-in-button", function(e) {
    e.preventDefault();
    var className = document.getElementById("sign-in-form").classList;
    var hideSignUpForm = document.getElementById("sign-up-form").classList;
    if(className.value === 'hide-form'){
      if(hideSignUpForm.value === 'show-form'){
        console.log('hide sign up form');
        document.getElementById("sign-up-form").classList.remove('show-form');
        document.getElementById("sign-up-form").classList.add('hide-form');
      }
      console.log('show sign in form');
      document.getElementById("sign-in-form").classList.remove('hide-form');
      document.getElementById("sign-in-form").classList.add('show-form');
    } else {
      console.log('HIDE sign in form');
      document.getElementById("sign-in-form").classList.remove('show-form');
      document.getElementById("sign-in-form").classList.add('hide-form');
    }
  });

  $(document).on("click", ".display-more-trails", function(e){
    e.preventDefault();
    trails.map((trail, index)=>{
      users.map(user=>{
        if((index + 1) <= 6){
          if(user.id === trail.user_id){
            console.log(trail);
            url = '/trails/'+trail.id+'';
            $('.display-trails').append('<div class="col-md-6 image"><img src='+trail.trail_photo.url+'>' + user.first_name + user.last_name +' <a href="' + url + '">' + trail.name + '</a>'+'</div>');
            trails.shift();
          }
        }
      });
    });
  });

  $(document).on("click", ".sign-up-button", function(e){
    e.preventDefault();
    var className = document.getElementById("sign-up-form").classList;
    var hideSignInForm = document.getElementById("sign-in-form").classList;
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
  });

  function loadTrails() {
    console.log('inside of load trails');
    trails = [];
    users = [];
    if(trails.length <= 0){
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
  }

  function displayTrails(trails, users){
    console.log('inside of display trails');
    var url = '';
    var userProfileURL = '';
    trails.map((trail, index) => {
      users.map(user=>{
        if((index + 1) <= 6){
          if(user.id === trail.user_id){
            url = '/trails/'+trail.id+'';
            userProfileURL = '/profiles/'+user.id+'';
            $('.display-trails').append('<div class="col-md-6 image"><img src='+trail.trail_photo.url+'>' + ' <a href="' + userProfileURL + '">' +`${user.first_name} ` + `${user.last_name}` +'</a>' +' <a href="' + url + '">' + trail.name + '</a>'+'</div>');
            trails.shift();
          }
        }
      });
    });
  }

  loadTrails();
};
$(document).ready(ready);
