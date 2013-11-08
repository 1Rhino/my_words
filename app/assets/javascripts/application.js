// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){

  // all_words in database. Will use in other function when create, update data
  var all_words = [];

  $.post('/get_words', function(data){
    all_words = data;
    $('#autocomplete').autocomplete({
      lookup: all_words,
      onHint: function (hint) {
          $('#autocomplete-x').val(hint);
      },
    });
  });

  $("#autocomplete").focus();


  $("#word_search").submit(function(){
    if($("#word_search .word").val() == ""){
      return false
    }
    $.post("/get_detail", $(this).serialize(), function(data){
      if(data != " "){
        $(".word-detail").css("display", "inline-block");
        $(".form-add").hide();
        $("#alert_box").hide();

        $(".word-detail .word").html(data.value);
        var like = data.like ? "Unlike" : "Like";
        $(".word-detail .like-word").attr("value", data.id);
        $(".word-detail .like-word").html(like);

        $(".word-detail .translation").html(data.data);
        $(".form-update .update-word").val(data.value);
        $(".form-update .update-translation").val(data.data);
        $(".form-update .update-id").val(data.id);
        get_popular_words();
      }else{
        var word_search = $("#word_search .word").val();
        $(".word-detail").hide();
        $("#alert_box").hide();
        $(".form-add").css("display", "inline-block");
        $(".form-add .add-word").val(word_search);
        $(".form-add .add-translation").val("").focus();
      };
    });
    return false;
  })

  $("#word_add").submit(function(){
    $.post("/add", $(this).serialize(), function(data){
      if( data != null){
        $("#alert_box").removeClass().addClass("alert alert-success").html("Added successful!").css("display", "inline-block");
        $(".form-add").hide();
        $(".form-search .word").focus();
        // after insert new data to database.
        // Add data to json for  autocomplete search
        all_words.push(data);

        get_new_word();
      }else{
        $("#alert_box").removeClass().addClass("alert alert-danger").html("Added failed!").css("display", "inline-block");
      }
    });
    return false;
  })

  $("#word_update").submit(function(){
    $.post("/update", $(this).serialize(), function(data){
      if( data == "true"){
        $(".form-update").hide();
        $("#word_search").submit();
        get_new_word();
        get_popular_words();
      }else{
        $("#alert_box").removeClass().addClass("alert alert-danger").html("Updated failed!").css("display", "inline-block");
      }
    });
    return false;
  })

  $(".edit-word").click(function(){
    $(".form-update").toggle();
    $(".form-update .update-translation").focus();
    return false;
  })

  // use delegate: hanlder element for now and future (added, created..)
  $(document).delegate('.like-word', 'click', function() {
    var id = $(this).attr("value");
    // Don't use $(this) because we need select all words have the same value with this word
    var like_word = $(".like-word[value='" + id + "']");
    $.post("/toogle_like", {id: id}, function(data){
      if(data == "true"){
        data = like_word.html() == "Like" ? "Unlike" : "Like"
        like_word.html(data);
      }else{
        alert("Sorry. Wrong now!");
      }
    })
    return false;
  })

  $('.carousel').carousel();

})

function get_new_word(){
  $.post("new_words", function(data){
    $(".new_words").html(data);
  })
}

function get_popular_words(){
  $.post("popular_words", function(data){
    $(".popular_words").html(data);
  })
}

