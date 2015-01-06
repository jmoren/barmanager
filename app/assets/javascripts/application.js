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
//= require semantic
//= require picker
//= require picker.date
//= require picker.time

$(document).ready(function(){
  $('.dropdown').dropdown();
  $('.checkbox').checkbox();
  $('.datepicker').pickadate();

  $('.tooltip').popup({
    position: "top center"
  });

  $("input[name=code_number]").focus();

  $(".close-table").on("click", function(e){
    e.preventDefault();
    id = $(this).data("id");
    $.ajax({
      url: "/tickets/"+id+"/edit",
      type: "GET",
      dataType: "html",
      success: function(data){
        $("#modal-ticket").html(data).modal('setting', {
          onDeny: function(){
            return false;
          },
          onApprove: function() {
            return true;
          }
        }).modal('show')
      }
    })
  });

  $(".change-table").on("click", function(e){
    e.preventDefault();
    id = $(this).data("id");
    $.ajax({
      url: "/tables?ticket_id="+ id,
      type: "GET",
      dataType: "html",
      success: function(data){
        $("#modal-table").html(data).modal().modal('show');
      }
    })
  });

});
