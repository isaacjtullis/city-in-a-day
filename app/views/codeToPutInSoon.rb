<div class="authentication">
  <div class="row justify-content-center">
    <div class="col-sm-3 align-self-center">
      <button class="sign-in-button ciad-button">Login</button>
    </div>
    <div class="col-sm-3 align-self-center">
      <button class="sign-up-button ciad-button">Sign Up</button>
    </div>
  </div>
  <div class="row justify-content-center">
    <div class="col">
      <div id="sign-up-form" class="hide-form">
         <%= render 'devise/registrations/new.html.erb' %>
      </div>
      <div id='sign-in-form' class='hide-form'>
        <%= render "devise/sessions/new.html.erb" %>
      </div>
    </div>
  </div>
</div>

<div class="row home-text align-self-center">
  <div class="col-md-4 offset-md-4">
    From Breakfast until the <br />
    "I want this night to last <br />
    forever" hangout spot<br />
    we ate, we  drank, we danced, <br />
    we took pictures, we avoided traffic, <br />
    and we made epic memories. <br />
    We've gone ahead of you <br />
    and blazed a trail<br />
  </div>
</div>


<button class='ciad-button'><%=  link_to 'Make new trail', new_trail_path  %></button>
