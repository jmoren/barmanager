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
//= require_tree .

$(document).ready(function(){
  $('.combo.dropdown').dropdown();

  $("input[name=code_number]").focus();
  $("input[name=code_number]").on("keyup", function(){
    val = $(this).val();
    $.ajax({
      url: "/items?code=" + val,
      method: "GET",
      success: function(res){
        console.log(res.id);
        if(res.id)
          $(".combo.dropdown").dropdown("set selected", res.id);
          $("#item_ticket_item_id").val(res.id);
      }
    })
  });

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
  })
});
