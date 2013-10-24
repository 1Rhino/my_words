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

  $('#autocomplete').autocomplete({
    lookup: [],
    onHint: function (hint) {
        $('#autocomplete-x').val(hint);
    },
  });

  $("#word_search").submit(function(){
    $.post("/get_detail", $(this).serialize(), function(data){
      if(data != " "){
        $(".word-detail").css("display", "inline-block");
        $(".form-add").hide();
        $("#alert_box").hide();

        $(".word-detail .word").html(data.value);
        $(".word-detail .translation").html(data.data);

        $(".form-update .update-word").val(data.value);
        $(".form-update .update-translation").val(data.data);
        $(".form-update .update-id").val(data.id);
      }else{
        var word_search = $("#word_search .word").val();
        $(".word-detail").hide();
        $(".form-add").show();
        $("#alert_box").removeClass().addClass("alert alert-warning").html("Not found in diction. Please add!").css("display", "inline-block");
        $(".form-add .add-word").val(word_search);
        $(".form-add .add-translation").val("").focus();
      };
    });
    return false;
  })

  $("#word_add").submit(function(){
    $.post("/add", $(this).serialize(), function(data){
      if( data == "true"){
        $("#alert_box").removeClass().addClass("alert alert-success").html("Added successful!").css("display", "inline-block");
        $(".form-add").hide();
        $(".form-search .word").focus();
      }else{
        $("#alert_box").removeClass().addClass("alert alert-danger").html("Added failed!").show();
      }
    });
    return false;
  })

  $("#word_update").submit(function(){
    $.post("/update", $(this).serialize(), function(data){
      if( data == "true"){
        $(".form-update").hide();
        $("#word_search").submit();
      }else{
        $("#alert_box").removeClass().addClass("alert alert-danger").html("Updated failed!").show();
      }
    });
    return false;
  })

  $(".edit-word").click(function(){
    $(".form-update").toggle();
    $(".form-update .update-translation").focus();
    return false;
  })
})
