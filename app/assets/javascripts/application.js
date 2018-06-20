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
//= require jquery.cookie.min
//= require jquery-ui.min
//= require jquery.tzSelect

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

    $('.data-submit-group').on('click', function(){
        // var $form = $(this).parent('.modal-body').children('.data-from');
        var $form = $(this).parents('.data-form-group');
        var query = $form.serialize();
        // console.log(query);
        // return false;
        console.log(query);
        $.ajax({
            url: 'group_users/' + $('.data_selected_group_user').val(),
            type: 'GET',
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

    $('.data-submit-group-delete').on('click', function(){
        // var $form = $(this).parent('.modal-body').children('.data-from');
        var $form = $(this).parents('.data-form-group');
        var query = $form.serialize();
        // console.log(query);
        // return false;
        console.log($('.data_selected_group_user_delete').val());
        $.ajax({
            url: 'group_users/' + $('.data_selected_group_user_delete').val(),
            type: 'DELETE',
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
   });
    $("#status_to_do").click(function () {
            $("#new_task_status").val('to_do');
        }
    );
    $("#status_donig").click(function () {
            $("#new_task_status").val('doing');
        }
    );
    $("#status_done").click(function () {
            $("#new_task_status").val('done');
        }
    );

    function taskDataIds(tableId){
        taskIds = [];
        items = $(tableId).children();
        for (var i = 1; i < items.length; ++i) {
            taskIds.push(items.eq(i).attr('data-task-id').toString());
        }
        return taskIds
    }

    function showSelectUserIcon(form) {
        var user;
        var users = [];
        var usersTable = $(".group_users").children();
        for (var i = 0; i < usersTable.length - 1; ++i){
            user = {id: usersTable.eq(i).attr('data-user-id') , imageName: usersTable.eq(i).attr('data-user-imageName')};
            users.push(user);
        }
        for (var i = 0; i < users.length; i++){
            // console.log("/assets/images/users/" + users[i].id + '/' + users[i].imageName);
            if ($(".user_select").val() == users[i].id) {
                if (users[i].imageName == "default_user.png"){
                    $(form).attr("src" , "/assets/images/users/" + users[i].imageName);
                } else{
                    $(form).attr("src" , "/assets/images/users/" + users[i].id + '/' + users[i].imageName);
                }
            }
        }
    }
    function showSelectUserIcon2(form, taskId) {
        var user;
        var users = [];
        var usersTable = $(".group_users").children();
        for (var i = 0; i < usersTable.length - 1; ++i){
            user = {id: usersTable.eq(i).attr('data-user-id') , imageName: usersTable.eq(i).attr('data-user-imageName')};
            users.push(user);
        }
        for (var i = 0; i < users.length; i++){
            console.log(".user_select_edit_" + taskId);
            if ($(".user_select_edit_" + taskId).val() == users[i].id) {
                if (users[i].imageName == "default_user.png"){
                    $(form).attr("src" , "/assets/images/users/" + users[i].imageName);
                } else{
                    console.log("/assets/images/users/" + users[i].id + '/' + users[i].imageName);
                    $(form).attr("src" , "/assets/images/users/" + users[i].id + '/' + users[i].imageName);
                }
            }
        }
    }
    $(".user_select").ready(function(){
        showSelectUserIcon("img.modal_user_icon");
    });
    $(".user_select").change(function(){
        showSelectUserIcon("img.modal_user_icon");
    });

    var taskIds = taskDataIds('#jquery_ui_to_do').concat(taskDataIds('#jquery_ui_doing')).concat(taskDataIds('#jquery_ui_done'));
    function initShowSelectUserIcon(tmp){
        for (var i = 0; i < tmp.length; i++){
            var tmpString = tmp[i].toString();
            if (tmpString.match("user_select_edit_")){
                var taskIdForm = tmpString.split('_')[3];
                showSelectUserIcon2("img.modal_user_icon_edit", taskIdForm);
            }
        }
    }
    for (var i = 0; i < taskIds.length; i++){
        var taskId = taskIds[i];
        $(".user_select_edit_" + taskId).ready(function(){
            // initShowSelectUserIcon($("#task_charge_user_id").attr('class').split(" "));
            // console.log($("#task_charge_user_id"))
        });
        $(".user_select_edit_" + taskId).change(function(){
            initShowSelectUserIcon($(this).attr('class').split(" "));
        });
    }
});

$(document).on('turbolinks:load', function(){
    $('.jquery-ui-draggable').draggable({
        connectToSortable: '.jquery-ui-sortable',
        // revert: 'invalid',
        stop: function(e, ui){
        }
    });
    $('.ayame').draggable({
        stop: function(e, ui){
            $.cookie('ayame_position_top', $('#ayame').offset().top);
            $.cookie('ayame_position_left', $('#ayame').offset().left);
        }
    });
});
$(document).on('turbolinks:load', function(){
    $('#jquery-ui-draggable-connectToSortable').disableSelection();
});

$(document).on('turbolinks:load', function(){
    // var timer;
    $('.notice_text').css('display', 'none');

    var img = new Array();
    img[0] = new Image();
    img[0].src = "/assets/images/system/sd_ayame_nomal.png";
    img[1] = new Image();
    img[1].src = "/assets/images/system/sd_ayame_smile.png";
    img[2] = new Image();
    img[2].src = "/assets/images/system/sd_ayame_zito.png";

    var $ayameAnim = $.Deferred( function( ayameAnim ){
        ayameAnim.then(anim_01)
            .then(anim_02)
            .then(anim_03)
    });

    function face_update (image_num, text){
        document.getElementById("ayame_image").src = img[image_num].src;
        $.cookie('ayame_face', 'nomal');
        $('.arrow_box').removeClass('arrow_box_temp');
        $('.notice_text').css('display', 'block');
        // $('.notice_text').removeClass('hukidashi_hidden');
        $('.form-serch-task').css('display', 'none');
        $('#notice_text_label').text(text);
        setTimeout(function(){
            $('.arrow_box').addClass('arrow_box_temp');
            $('.notice_text').css('display', 'none');
            // $('.notice_text').addClass('hukidashi_hidden');
            $('.form-serch-task').css('display', 'block');
            $('#ayame_image_temp').addClass('ayame_image_animation');
            // $ayameAnim.resolve();
            document.getElementById("ayame_image").src = img[0].src;
        }, 5000);
    }

    if ($.cookie('ayame_face') == 'smile') {
        var text = "おお！タスクを完了したのか！エライぞ！";
        face_update(1, text);
    } else if ($.cookie('ayame_face') == 'zito') {
        var text = "……なんだか完了からタスクが移動したような気がするのじゃが……気のせいか？";
        face_update(2, text);
    }

    function anim_01 (){
        return $("#ayame_img").delay(100).animate({
            top: "+=100px"
        },100);
    }
    function anim_02 (){
        return $("#ayame_img").animate({
            top: "0px"
        },100);
    }
    function anim_03 (){
        document.getElementById("ayame_image").src = img[0].src;
    }

    $('#ayame').offset({ top: $.cookie('ayame_position_top'), left: $.cookie('ayame_position_left')});

    $.cookie('done_counter', $('#jquery_ui_done').children().length - 1);

    $('.jquery-ui-sortable').sortable({
        revert: true,
        receive: function(event,ui){
            var form = $(this).parent('.jquery_ui_status');
            var tasks = [];
            var items = $(this).children();
            for (var i = 0; i < items.length; ++i) {
                task = {id: items.eq(i).attr('data-task-id'), status: items.eq(i).attr('data-task-status')};
                tasks.push(task);
            }
            var arrObj = {};
            for (var i = 0; i < tasks.length; i++) {
                arrObj[tasks[i]['status']] = tasks[i];
            }
            for (var key in arrObj) {
                if (arrObj[key].id != null) task_id = arrObj[key].id;
            }
            try {
                if (task_id != null){

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
                        });
                    $.cookie('done_counter_after', $('#jquery_ui_done').children().length - 1);
                    if ($.cookie('done_counter') < $.cookie('done_counter_after')){
                        $.cookie('ayame_face', 'smile');
                    }
                    if ($.cookie('done_counter') > $.cookie('done_counter_after')){
                        $.cookie('ayame_face', 'zito');
                    }
                }
            } catch (e){

            }
        }
    });

    function taskData(tableId){
        tasks = [];
        items = $(tableId).children();
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
        $('.arrow_box').removeClass('arrow_box_temp');
    });
    $('.arrow_box').dblclick(function(){
        // $('.arrow_box').css('display', 'none')
        $('.arrow_box').addClass('arrow_box_temp');
    });

});

