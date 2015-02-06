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
  $('.dropdown.tables').dropdown({
    onChange: function (val) {
      window.location = '/tables/' + val + '?status=open';
    }
  });
  $('.dropdown.config').dropdown();
  $('.checkbox').checkbox();
  $('.datepicker').pickadate();
  $("#ticket-entry .item").tab();

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
        }).modal('show');
      }
    });
  });

  $("#show-kitchen").on("click", function(e){
    e.preventDefault();
    id = $(this).data("id");
    $.ajax({
      url: "/kitchen/"+id+"/print_table",
      type: "GET",
      dataType: "html",
      success: function(data){
        $("#modal-kitchen").html(data).modal('setting', {
          onApprove: function() {
            $('div.panel').hide();
            window.print();
            return deliverAll(id);
          }
        }).modal('show');
      }
    });
  });

  function deliverAll(ticketId){
    $.ajax({
      url: "/tickets/"+ticketId+"/deliver_all_kitchen",
      type: "patch",
      dataType: "json",
      success: function(data) {
        $('div.panel').show();
        return true;
      },
      error: function(a,b,c){
        $('div.panel').show();
        alert("Hubo un error enviando el ticket a imprimir.");
        return false;
      }
    });
  }

  $(".dropdown .table-option").click(function(a,b,c){
    window.location = '/tables/' + $(a.currentTarget).attr('data-code') + '?status=open';
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
    });
  });

  $menu = $('#toc');
  $menu.sidebar({
    transition       : 'overlay',
    mobileTransition : 'overlay',
    dimPage          : false,
    closable         : false
  });
  $('.launch').on('click', function(event) {
    $menu.sidebar('toggle');
    event.preventDefault();
  });


  $(".expand-item-row").on("click", function(e){
    e.preventDefault();
    ticket_id = $(this).data("ticket-id");
    type = $(this).data("type");
    item_id = type === "promotion" ? $(this).data("promo-id") : $(this).data("item-id");
    $.ajax({
      url: "/kitchen/"+ticket_id+"/show/" + item_id + "/" + type,
      type: "GET",
      dataType: "html",
      success: function(data){
        $("#modal-expand_item").html(data).modal('setting', {
          onApprove: function() {
            return true;
          }
        }).modal('show');
      }
    });
  });
});
