// import axios from 'axios';

$(document).on('turbolinks:load', function(){
    var img = new Array();
    img[0] = new Image();
    img[0].src = "/assets/images/system/sd_ayame_nomal.png";
    img[1] = new Image();
    img[1].src = "/assets/images/system/sd_ayame_smile.png";
    img[2] = new Image();
    img[2].src = "/assets/images/system/sd_ayame_zito.png";
    img[3] = new Image();
    img[3].src = "/assets/images/system/sd_ayame_oko.png";
    function face_update (image_num, text){
        document.getElementById("ayame_image").src = img[image_num].src;
        $.cookie('ayame_face', 'nomal');
        $('#ayame_image_temp').addClass('ayame_image_animation');
        $('.arrow_box').removeClass('arrow_box_temp');
        $('.notice_text').css('display', 'block');
        $('.form-calendar').css('display', 'none');
        $('#notice_text_label').text(text);
        setTimeout(function(){
            $('#ayame_image_temp').removeClass('ayame_image_animation');
        }, 2000);
        setTimeout(function(){
            $('.arrow_box').addClass('arrow_box_temp');
            $('.notice_text').css('display', 'none');
            $('.form-calendar').css('display', 'block');
            $('#ayame_image_temp').addClass('ayame_image_animation');
            document.getElementById("ayame_image").src = img[0].src;
        }, 5000);
        setTimeout(function(){
            $('#ayame_image_temp').removeClass('ayame_image_animation');
        }, 5100);
    }
    new Vue({
        el: '#app',
        data: {
            weekDays: ['日', '月', '火', '水', '木', '金', '土'],
            calData: {year: 0, month: 0},
            deadlineTasksDays: [],
            dayCounts: [],
            tasks: [],
            taskDates: [],
            dateDay: 0
        },
        created: function (){
            var date = new Date();
            this.calData.year = date.getFullYear();
            this.calData.month = date.getMonth() + 1;
        },
        methods: {
            getMonthName: function(month) {
                var monthName = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'];
                return monthName[month - 1];
            },
            moveLastMonth: function() {
                if (this.calData.month == 1) {
                    this.calData.year--;
                    this.calData.month = 12;
                }
                else {
                    this.calData.month--;
                }
            },
            moveNextMonth: function() {
                if (this.calData.month == 12) {
                    this.calData.year++;
                    this.calData.month = 1;
                }
                else {
                    this.calData.month++;
                }
            },
            showTask: function(day) {
                this.dateDay = day;
                this.taskDates = [];

                // console.log(new Date().getDate());
                for (var i = 0; i < this.tasks.length; i++) {
                    if (this.tasks[i]['day'] == day) {
                        var today = new Date();
                        var redTask = false;
                        var taskDeadline = new Date(this.calData.year, this.calData.month - 1, day);
                        // console.log(today.setDate(today.getDate() + 3));
                        // day = new Date($.format.date(day, "yyyy/M/d"));
                        today = today.setDate(today.getDate());
                        today = new Date( today  );
                        // console.log(today);
                        if (taskDeadline <= today) {
                            redTask = true;
                        }else{
                            redTask = false;
                        }
                        this.taskDates.push({
                            taskId: this.tasks[i].taskId,
                            caption: this.tasks[i]['caption'],
                            group: this.tasks[i]['group'],
                            chargeUserId: this.tasks[i].chargeUserId,
                            chargeUser: this.tasks[i]['chargeUser'],
                            userImage: this.tasks[i]['userImage'],
                            redTask: redTask });
                    }
                }
            },
            mailNotification: function(chargeUserId, taskId) {
                $.ajax({
                    url: '/api/tasks/mail',
                    type: 'GET',
                    data: {
                        mail: { user_id: chargeUserId, task_id: taskId }
                    },
                    dataType: 'json',
                    headers: {
                        'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
                    },
                    success: function( data ) {
                    }
                }).done(function(dataResult, textStatus, jqXHR) {
                });
                var text = "こやつを叱るのか？任せとけ！奴のことはキッチリと絞ってやるからの！";
                face_update(1, text);
            }
        },
        // methods の中でも良い？
        computed: {
            calendar: function () {
                var firstDay = new Date(this.calData.year, this.calData.month - 1, 1).getDay();
                var lastDate = new Date(this.calData.year, this.calData.month, 0).getDate();
                var dayIdx = 1;
                var responceData;

                function thisMonth () {
                    var calendar = [];
                    for (var w = 0; w < 6; w++) {
                        var week = [];

                        if (lastDate < dayIdx) {break;}
                        for (var d = 0; d < 7; d++) {
                            if (w == 0 && d < firstDay) {
                                week[d] = {day: ''};
                            } else if (w == 6 && lastDate < dayIdx) {
                                week[d] = {day: ''};
                                dayIdx++;
                            } else if (lastDate < dayIdx) {
                                week[d] = {day: ''};
                                dayIdx++;
                            } else {
                                week[d] = {day: dayIdx};
                                dayIdx++;
                            }
                        }
                        calendar.push(week);
                    }
                    return calendar;
                }

                $.ajax({
                    url: '/api/tasks/calendar.json',
                    type: 'GET',
                    data: {
                        calendar: { year: this.calData.year, month: this.calData.month }
                    },
                    dataType: 'json',
                    cache: false,
                    async: false,
                    success: function( data ) {
                        responceData = data;
                    }
                }).done(function(dataResult, textStatus, jqXHR) {
                    responceData = dataResult;
                });
                setTimeout(function(){
                    if(responceData != null){
                        /* whatever you want to do using the results */
                    }
                    else{
                        setTimeout(arguments.callee, 100);
                    }
                });

                var tasks = [];
                for (var i = 0; i < responceData.length; i++) {
                    var task = {
                        day: new Date(responceData[i].deadline).getDate(),
                        group: responceData[i].group,
                        caption: responceData[i].caption,
                        chargeUser: responceData[i].chargeUser,
                        userImage: responceData[i].userImage,
                        chargeUserId: responceData[i].chargeUserId,
                        taskId: responceData[i].taskId
                    };
                    tasks.push(task);
                }
                this.tasks = JSON.parse(JSON.stringify(tasks));
                var haveTaskDays = [];
                var counts = {};
                for (var i = 0; i < tasks.length; i++) {
                    haveTaskDays.push(tasks[i]['day']);
                }
                this.deadlineTasksDays = JSON.parse(JSON.stringify(haveTaskDays));
                for (var i = 0; i < haveTaskDays.length; i++) {
                    var key = haveTaskDays[i];
                    counts[key] = (counts[key])? counts[key] + 1 : 1;
                }
                this.dayCounts = JSON.parse(JSON.stringify(counts));
                return thisMonth();
            }
        }
    });
});