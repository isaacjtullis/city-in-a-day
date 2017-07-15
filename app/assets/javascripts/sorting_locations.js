$(function () {
  $( "#location-information" ).sortable({
    revert: true
  });
});

/*
$(document).ready(function(){
  $(function() {
    $('#location-information').sortable({
      update: function(event, ui) {
        var productOrder = $(this).sortable('toArray').toString();
        $("#location-information-1").text (productOrder);
      }
    })
  });
})
*/
/*
$(function () {
$( "#location-information" ).sortable({
revert: true
});
});
});
  $("#location-information").sortable({
    update: function (event, ui) {
      var order = $(this).sortable('serialize');

      $(document).on("click", "button", function () { //that doesn't work
        $.ajax({
            data: order,
            type: 'POST',
            url: 'saverank.php'
        });
      });
    }

    }).disableSelection();
    $('button').on('click', function () {
        var r = $("#sortable").sortable("toArray");
        var a = $("#sortable").sortable("serialize", {
            attribute: "id"
        });
        console.log(r, a);
    });
});
*/
