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
//= require_tree .
// Bootstrap Sass
//= require bootstrap-sprockets
//= require toastr
// = require data-confirm-modal
//= require turbolinks

$(document).on('turbolinks:load', function(){
    $('.data-submit').on('click', function(){
        // var $form = $(this).parent('.modal-body').children('.data-from');
        var $form = $(this).parents('.data-form');
        var query = $form.serialize();
        console.log(query);
        // return false;

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

$(document).on('turbolinks:load', function(){
    $('.jquery-ui-sortable').sortable({
        revert: true,
        start: function(event,ui){
        },
        receive: function(event,ui){

            var form = $(this).parent('.jquery_ui_status');
            tasks = [];
            items = $(this).children();
            console.log(items.eq(0).attr('data-task-id'));
            for (var i = 0; i < items.length; ++i) {
                task = {id: items.eq(i).attr('data-task-id'), status: items.eq(i).attr('data-task-status')};
                tasks.push(task);
            }
            var arrObj = {};
            for (var i = 0; i < tasks.length; i++) {
                arrObj[tasks[i]['status']] = tasks[i];
            }
            for (var key in arrObj) {
             task_id = arrObj[key].id;
            }
            console.log(task_id);
            console.log(form.attr('data-status'));

            $.ajax({
                url: '/api/tasks/' + task_id,
                type: 'PATCH',
                data: {
                   task: { id: task_id, status: form.attr('data-status') }
                },
                dateType: 'json'
            })
            .done( function(response) {
                if (task_id != null || form.attr('data-status') != null) {
                    location.reload();
                }
            })
        }
    });
});

$(document).on('turbolinks:load', function(){
    $('.jquery-ui-draggable').draggable({
        connectToSortable: '.jquery-ui-sortable',
        // revert: 'invalid',
        stop: function(e, ui){
        }
    });
});
$(document).on('turbolinks:load', function(){
    $('#jquery-ui-draggable-connectToSortable').disableSelection();
});
