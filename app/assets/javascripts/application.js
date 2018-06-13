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
        // update: function(ev, ui) {
        //   var updateArray = $(".jquery-ui-sortable").sortable("toArray").join(",");
        //   $.cookie(".jquery-ui-sortable", updateArray, {expires: 30});
        //   console.log(updateArray);
        // },
        start: function(event,ui){
            // $('#jquery_ui_to_do tbody > tr:last').after('<tr><td></td><td> + タスクを追加</td></tr>');
            // $('#jquery_ui_doing tbody > tr:last').after('<tr><td></td><td> + タスクを追加</td></tr>');
            // $('#jquery_ui_done tbody > tr:last').after('<tr><td></td><td> + タスクを追加</td></tr>');
        },
        stop: function(event, ui) {
            // console.log("remove");
            // $('#jquery_ui_to_do tbody > tr:last').remove();
        },
        receive: function(event,ui){
            // $('#jquery_ui_to_do tbody > tr:last').after('<tr><td></td><td>タスクを追加</td></tr>');


            var form = $(this).parent('.jquery_ui_status');
            tasks = [];
            items = $(this).children();
            // console.log(items.eq(0).attr('data-task-id'));
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
            // console.log(task_id);
            // console.log(form.attr('data-status'));

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
    // if($.cookie('.jquery-ui-sortable')){
    //     var cokieValue = $.cookie(".jquery-ui-sortable").split(",").reverse();
    //     $.each(
    //         cokieValue,
    //         function(index, value) {$('#'+value).prependTo(".jquery-ui-sortable");},
    //         console.log(cokieValue)
    //     );
    // }
});

$(document).on('turbolinks:load', function(){
    $('.jquery-ui-draggable').draggable({
        connectToSortable: '.jquery-ui-sortable',
        // revert: 'invalid',
        stop: function(e, ui){
        }
    });
    $('.ayame').draggable();
});
$(document).on('turbolinks:load', function(){
    $('#jquery-ui-draggable-connectToSortable').disableSelection();
});

$(document).on('turbolinks:load', function(){
    // var timer;



    function taskData(tableId){
        // var form = $(this).parent('.jquery_ui_status');
        tasks = [];
        items = $(tableId).children();
        // console.log(items.eq(0).attr('data-task-id'));
        for (var i = 1; i < items.length; ++i) {
            task = {
                id: '#' + items.eq(i).attr('data-task-id').toString(),
                caption: items.eq(i).attr('data-task-caption'),
                user: items.eq(i).attr('data-task-user'),
                chargeUser: items.eq(i).attr('data-task-charge-user'),
                label: items.eq(i).attr('data-task-label')};
            tasks.push(task);
        }
        return tasks
        // var arrObj = {};
        // for (var i = 0; i < tasks.length; i++) {
        //     arrObj[tasks[i]['status']] = tasks[i];
        // }
        // for (var key in arrObj) {
        //     task_id = arrObj[key].id;
        // }
    }
    function searchTasks(tasks, searchText, searchResult, radioSelected){
        for (var i = 0; i < tasks.length; i++) {
            switch (radioSelected) {
                case 'caption':
                    if (tasks[i].caption.indexOf(searchText) != -1) {
                        searchResult.push(tasks[i].caption);
                        $(tasks[i].id).removeClass('hidden');
                    } else {
                        $(tasks[i].id).addClass('hidden');
                    }
                    break;
                case 'chargeUser':
                    if (tasks[i].chargeUser.indexOf(searchText) != -1) {
                        searchResult.push(tasks[i].caption);
                        $(tasks[i].id).removeClass('hidden');
                    } else {
                        $(tasks[i].id).addClass('hidden');
                    }
                    break;
                case 'user':
                    if (tasks[i].user.indexOf(searchText) != -1) {
                        searchResult.push(tasks[i].caption);
                        $(tasks[i].id).removeClass('hidden');
                    } else {
                        $(tasks[i].id).addClass('hidden');
                    }
                    break;
                case 'label':
                    if (tasks[i].label.indexOf(searchText) != -1) {
                        searchResult.push(tasks[i].caption);
                        $(tasks[i].id).removeClass('hidden');
                    } else {
                        $(tasks[i].id).addClass('hidden');
                    }
                    break;
            }

        }
        return searchResult;
    }


    searchWord = function(){
        var taskToDo = taskData('#jquery_ui_to_do');
        var taskDoing = taskData('#jquery_ui_doing');
        var taskDone = taskData('#jquery_ui_done');

        var searchResult,
            searchText = $(this).val(),
            hitNum;

        searchResult = [];

        $('.search-result__list').empty();
        $('.search-result__hit-num').empty();

        if (searchText != '') {
            radioSelected = $('input[name=searchTasks]:checked').val();

            searchResult = searchTasks(taskToDo, searchText, searchResult, radioSelected);
            searchResult = searchTasks(taskDoing, searchText, searchResult, radioSelected);
            searchResult = searchTasks(taskDone, searchText, searchResult, radioSelected);

            for (var i = 0; i < searchResult.length; i ++) {
                $('<div>').text(searchResult[i]).appendTo('.search-result__list');
            }

            hitNum = '<span>検索結果</span>：' + searchResult.length + '件あったぞ！';
            $('.search-result__hit-num').append(hitNum);
        } else {
            $('#jquery_ui_to_do tr').removeClass('hidden');
            $('#jquery_ui_doing tr').removeClass('hidden');
            $('#jquery_ui_done tr').removeClass('hidden');
        }
    };
    $('#search-text').on('input', searchWord);

    $('.ayame_image').dblclick(function(){
        $('.arrow_box').css('display', 'block');
        // $('p').html("何か用か？");

        // var form = $(this).parent('.jquery_ui_status');
        // tasks = [];
        // items = $(this).children();
        // // console.log(items.eq(0).attr('data-task-id'));
        // for (var i = 0; i < items.length; ++i) {
        //     task = {id: items.eq(i).attr('data-task-id'), status: items.eq(i).attr('data-task-status')};
        //     tasks.push(task);
        // }
        // var arrObj = {};
        // for (var i = 0; i < tasks.length; i++) {
        //     arrObj[tasks[i]['status']] = tasks[i];
        // }
        // for (var key in arrObj) {
        //     task_id = arrObj[key].id;
        // }

        // $('li').append("<a class='btn glyphicon glyphicon-search data-toggle=\"modal\" data-target=\"#serch_task\"'></a>");

        // document.addEventListener("DOMContentLoaded", load, false);
        // function countDown() {
        //     $('.arrow_box').css('display', 'none');
        //     return true;
        // }
        // function restartTimer() {
        //     clearTimeout(timer);
        //     timer = setTimeout('countDown()', 10000);
        //     return true;
        // }
        // function load() {
        //     timer=setTimeout('countDown()',10000);
        //     document.body.addEventListener("mousedown", restartTimer, false);
        //     document.body.addEventListener("keypress", restartTimer, false);
        // }
    });
    $('.arrow_box').dblclick(function(){
        $('.arrow_box').css('display', 'none')
    });




});