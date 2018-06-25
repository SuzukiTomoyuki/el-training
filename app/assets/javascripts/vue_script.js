// import axios from 'axios';

$(document).on('turbolinks:load', function(){
    new Vue({
        el: '#app',
        data: {
            weeks: ['日', '月', '火', '水', '木', '金', '土'],
            calData: {year: 0, month: 0},
            query: []
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

            }
        },
        computed: {
            calendar: function () {
                var firstDay = new Date(this.calData.year, this.calData.month - 1, 1).getDay();
                var lastDate = new Date(this.calData.year, this.calData.month, 0).getDate();
                var dayIdx = 1;

                var calendar = [];
                for (var w = 0; w < 6; w++) {
                    var week = [];

                    // 空白行をなくすため
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

                $.ajax({
                    url: 'api/tasks/calendar.json',
                    type: 'GET',
                    data: {
                        calendar: { year: this.calData.year, month: this.calData.month }
                    },
                    dataType: 'json'
                }).done(function(dataResult, textStatus, jqXHR) {
                    console.log(dataResult);
                });

                return calendar;
            }
        }
    });
});