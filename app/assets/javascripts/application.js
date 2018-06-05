// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require rails-ujs
//= require select2
//= require turbolinks
//= require_tree .
// Bootstrap Sass
//= require bootstrap-sprockets
//= require toastr
// = require data-confirm-modal


$(function(){
    // tasks create
    $('.data-submit').on('click', function(){
        // var $form = $(this).parent('.modal-body').children('.data-from');
        var $form = $(this).parents('.data-form');
        var query = $form.serialize();
        console.log($form.attr('action'));

        $.ajax({
            url: $form.attr('action'),
            type: $form.attr('method'),
            data: query,
            headers: {
                'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
            },
        })
        .done((data) => {
            location.reload();
        })
        .fail((data) => {
            console.log(data);
            var messages = data.responseJSON.messages;
            for(var i=0; i < messages.length; i++) {
                toastr.error(messages[i]);
            }
        })
    })
});

$('.js-searchable').select2({
    width: 200,
    allowClear: true
});

$(document).on('turbolinks:load', function(){
    var flg = "close";
   $("#member_label").click(function () {
       if (flg == "close"){
           $("#member_label_text").text("メンバーを非表示 △");
           flg = "open";
       }else {
           $("#member_label_text").text("メンバーを表示 ▽");
           flg = "close"
       }

   })
});