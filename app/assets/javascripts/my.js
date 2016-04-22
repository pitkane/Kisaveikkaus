


(function($){
  alert_me = function (caption, text, dismiss, success) {
    $('#guess-flash').hide();
    $('#guess-flash').html("");
    $("#guess-flash").removeClass();
    $("#guess-flash").addClass("alert");
    if(success) {
        $("#guess-flash").addClass("alert-success");
    }
    else {
        $("#guess-flash").addClass("alert-error");
    }
    if(dismiss) {
        $('#guess-flash').append("<a class='close' data-dismiss='alert'>&times</a>");
    }
    if(caption !== "") {
        $('#guess-flash').append("<strong>"+caption+"</strong>");
    }
    $('#guess-flash').append(" " + text);

    $('#guess-flash').show().center();
    $('#guess-flash').delay(1000).fadeOut(500);

    //return this;
  }

  add_update_guess = function () {
    
    //return this;
  }

})(jQuery);


jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", (($(window).height() - this.outerHeight()) / 2) +
        $(window).scrollTop() + "px");
    this.css("left", (($(window).width() - this.outerWidth()) / 2) +
        $(window).scrollLeft() + "px");
    return this;
}

$(document).ready(function () {

  $('.result_select_sport').click(function(){

  var col_name = "#collapse" + $(this).attr('sport_id');
  var sportti_id = $(this).attr('sport_id');

  $.ajax({
    url: "/results/sport_results",
    type: "GET",
    data: {sport_id: $(this).attr('sport_id')},
    complete: function() {
      // called when complete
    },
    success: function(data) {
      // called when succesful
      $(col_name).html("");
      $(col_name).append(data);

      $.ajax({
        url: "/results/get_sport_results",
        data: { sport_id: sportti_id },
        type: "GET",
        dataType: "json",
        
        complete: function() {
          // called when complete
        },
        success: function(data) {
          // called when succesful
          $.each(data, function() {

            var input_name = "#input_"+this['event_id']+"_"+this['rank']
            var status_name = "#status_"+this['event_id']+"_"+this['rank']
            var flag_holder = "#flag_"+this['event_id']+"_"+this['rank']

            $(input_name).val( countries_array[this['country_id']-1] );
            $(status_name).addClass("success");
            $(flag_holder).html("<img alt='" + data + "' height='20' src='/assets/countries/" + (this['country_id']) + ".png' width='34'>")

          });
          var settings_scroll = {
            duration: 800,
            offset: {left: 0, top: -110}
          }
          $.scrollTo(col_name, settings_scroll);
        },
        error: function(xhr,status,error) {
          // called when error
        }
      });


    },
    error: function(xhr,status,error) {
      // called when error
    }
  });



  });

  $('.guesses_click_sport').click(function(){
    //alert( $(this).attr('sport_id') );
    var col_name = "#collapse" + $(this).attr('sport_id')
    $.ajax({
      url: "/guesses/sport_guesses",
      type: "GET",
      data: {sport_id: $(this).attr('sport_id')},
      complete: function() {
        // called when complete
      },
      success: function(data) {
        // called when succesful
        $(col_name).html("");
        $(col_name).append(data);


        // var user = #{ current_user.id };

        $.ajax({
          url: "/guesses/get_user_guesses",
          type: "GET",
          dataType: "json",
          // data: {user_id: user},
          complete: function() {
            // called when complete
          },
          success: function(data) {
            // called when succesful
            $.each(data, function() {

              var input_name = "#input_"+this['event_id']+"_"+this['rank']
              var status_name = "#status_"+this['event_id']+"_"+this['rank']
              var flag_holder = "#flag_"+this['event_id']+"_"+this['rank']

              $(input_name).val( countries_array[this['country_id']-1] );
              $(status_name).addClass("success");
              $(flag_holder).html("<img alt='" + data + "' height='20' src='/assets/countries/" + (this['country_id']) + ".png' width='34'>")

            });
            var settings_scroll = {
              duration: 800,
              offset: {left: 0, top: -110}
            }
            $.scrollTo(col_name, settings_scroll);
          },
          error: function(xhr,status,error) {
            // called when error
          }
        });


      },
      error: function(xhr,status,error) {
        // called when error
      }
    });



  });

  change_guess_count = function(num) {
      var current = $('.guess-count').html();
      $('.guess-count').html(parseInt(current)+num);
  };

  check_time = function() {
    var t1 = new Date();
    var t2 = new Date(2012, 07, 27, 18, 0, 0, 0)
    var diff = t2.getTime() - t1.getTime()
    if (diff < 0 ) {
      return false;
    }
  }

  var countries_array = ["Afganistan", "Albania", "Algeria", "Amerikan Samoa", "Andorra", "Angola", "Antigua ja Barbuda", "Argentiina", "Armenia", "Australia", "Itävalta", "Azerbaidzan", "Bahama", "Bahrain", "Barbados", "Valko-Venäjä", "Belgia", "Bermuda", "Bolivia", "Bosnia ja Hertsegovina", "Botswana", "Brasilia", "Brittiläiset Neitsytsaaret", "Bulgaria", "Burundi", "Kamerun", "Kanada", "Caymansaaret", "Keski-Afrikan tasavalta", "Chile", "Kiina", "Kolumbia", "Kongo", "Cookinsaaret", "Costa Rica", "Norsunluurannikko", "Kroatia", "Kuuba", "Kypros", "Tsekki", "Tanska", "Djibouti", "Dominica", "Dominikaaninen tasavalta", "Ecuador", "Egypti", "El Salvador", "Eritrea", "Viro", "Etiopia", "Fidzi", "Suomi", "Ranska", "Gabon", "Georgia", "Saksa", "Ghana", "Iso-Britannia", "Kreikka", "Grenada", "Guatemala", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hongkong", "Unkari", "Islanti", "Intia", "Indonesia", "Iran", "Irlanti", "Israel", "Italia", "Jamaika", "Japani", "Jordania", "Kazakstan", "Kenia", "Pohjois-Korea", "Etelä-Korea", "Kuwait", "Kirgisia", "Latvia", "Libanon", "Liberia", "Libya", "Liettua", "Luxemburg", "Madagaskar", "Malesia", "Malta", "Meksiko", "Moldova", "Mongolia", "Montenegro", "Marokko", "Mosambik", "Namibia", "Hollanti", "Uusi-Seelanti", "Nigeria", "Norja", "Oman", "Pakistan", "Panama", "Papua-Uusi-Guinea", "Paraguay", "Peru", "Filippiinit", "Puola", "Portugali", "Puerto Rico", "Qatar", "Romania", "Venäjä", "Ruanda", "Saint Kitts ja Nevis", "Saint Lucia", "Samoa", "San Marino", "Saudi-Arabia", "Senegal", "Serbia", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Etelä-Afrikka", "Espanja", "Sudan", "Ruotsi", "Sveitsi", "Syyria", "Kiinan Taipei", "Tadzikistan", "Tansania", "Thaimaa", "Trinidad ja Tobago", "Tunisia", "Turkki", "Turkmenistan", "Uganda", "Ukraina", "Yhdistyneet arabiemiirikunnat", "Yhdysvallat", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam", "Neitsytsaaret", "Sambia", "Zimbabwe"]

  $(document).on("click", ".remove-guess", function(){

    // if ( check_time() == false) {
    alert_me("","Soosoo, kisat on jo alkanu!",true, false);
    return false;
    //}

    var event_id = $(this).attr('event_id');
    var rank = $(this).attr('rank');
    var input_name = "#input_"+event_id+"_"+rank
    var status_color = "#status_"+event_id+"_"+rank
    var flag_holder = "#flag_"+event_id+"_"+rank

    $.ajax({
      type: "DELETE",
      url: "/guesses/1",
      data: { 'guess[event]': event_id, 'guess[rank]': rank},
      statusCode: {
        404: function() {
          alert_me("Virhe!","Veikkauksen poistossa tapahtui virhe, luultavasti kyseistä veikkausta ei ole tietokannassa...",true, false);
          $(status_color).attr('class', 'control-group error');
        },
        200: function() {
          $(input_name).val("");
          $(status_color).attr('class', '');
          alert_me("","Veikkauksesi on poistettu tietokannasta.",true, false);
          $(flag_holder).html("");
          change_guess_count(-1);
        }
      }
    });


  });

  $(document).on("click", ".remove-result", function(){

    var event_id = $(this).attr('event_id');
    var rank = $(this).attr('rank');
    var input_name = "#input_"+event_id+"_"+rank
    var status_color = "#status_"+event_id+"_"+rank
    var flag_holder = "#flag_"+event_id+"_"+rank

    $.ajax({
      type: "DELETE",
      url: "/results/1",
      data: { 'result[event]': event_id, 'result[rank]': rank},
      statusCode: {
        404: function() {
          alert_me("Virhe!","Tuloksen poistossa tapahtui virhe, luultavasti kyseistä veikkausta ei ole tietokannassa...",true, false);
          $(status_color).attr('class', 'control-group error');
        },
        200: function() {
          $(input_name).val("");
          $(status_color).attr('class', '');
          alert_me("","Tulos on poistettu tietokannasta.",true, false);
          $(flag_holder).html("");
          change_guess_count(-1);
        }
      }
    });


  });

/*
  $(document).on("click", ".add-guess", function(){

    var event_id = $(this).attr('event_id');
    var rank = $(this).attr('rank');
    var input_name = "#input_"+event_id+"_"+rank
    var country = $(input_name).val();

    var status_color = "#status_"+event_id+"_"+rank
    var flag_holder = "#flag_"+event_id+"_"+rank
    var country_code = ""
    var asdf = ""
    $.ajax({
      type: "POST",
      url: "/guesses",
      data: { 'guess[event]': event_id, 'guess[country]': country, 'guess[rank]': rank},
      statusCode: {
        404: function() {
          $(status_color).attr('class', 'control-group error');
          alert_me("Virhe!","Veikkauksen lisäyksessä tapahtui virhe, tarkista oikeinkirjoitus, tai yritä myöhemmin uudelleen...",true, false);
        },
        204: function() {

          $(flag_holder).html("<img height='20' src='/assets/countries/" + (jQuery.inArray(country, countries_array)+1) + ".png' width='34'>")
          alert_me("Hienoa!","Veikkauksesi lisättiin onnistuneesti.",true, true);
          $(status_color).attr('class', 'control-group success');
          change_guess_count(1);
        },
        200: function() {

          $(flag_holder).html("<img height='20' src='/assets/countries/" + (jQuery.inArray(country, countries_array)+1) + ".png' width='34'>")
          alert_me("Hienoa!","Veikkauksesi päivitettiin onnistuneesti!.",true, true);
          $(status_color).attr('class', 'control-group success');

        }
      }
    });
  });
*/


});