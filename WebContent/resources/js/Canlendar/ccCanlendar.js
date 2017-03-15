//依赖widget.factory.js提供的全局变量WidgetFactory
(function ($) {
    var W = WidgetFactory;
    var format = 'yyyy-mm-dd hh:ii';//将日期格式定位常量
    var holiday = {
    };
    var defaults = {
        iniValue: true, //是否自动生成初始日期
        hasDatePanel: true, //是否显示日期
        hasHourPanel: true, //是否显示时间
        hasMinitePanel: true, //是否显示分钟
        autoSetMinLimit: true, //是否自动设置最小可选界限
        autoSetMaxLimit: false, //是否自动设置最大可选界限
        minLimit: false, //设置最小可选界限 和inputFormar格式相同的字符串
        maxLimit: false, //设置最大可选界限 和inputFormar格式相同的字符串
        showNextMonth: true, //同时显示下一个月
        startYear: 2015, //设置可选年份范围 开始
        endYear: 2050, //设置可选年份范围 结束
        onSelectDate: function () {
            //选择日期 触发
        },
        onSelectHour: function () {
            //选择时间 触发
        },
        onSelectMinite: function () {
            //选择分钟 触发
        },
        onShow: function () {
            //显示控件 触发
        },
        onClose: function () {
            //关闭控件 触发
        }
    };
    $.fn.ccCanlendar = function (options, args) {
        //静态配置
        return this.each(function () {
            var _self = $(this), widget;
            var commandExecutor = {
                getParam: function(paramname,obj){
                    obj[paramname] = widget.paramGroup[paramname];
                },
                setOption: function (newopts) {
                    widget.opts = $.extend({}, widget.opts, newopts);
                },
                destroy: function () {
                    _self.removeAttr(W.uidName);
                    widget.destroy();
                },
                minLimitChanged: function () {
                    widget.dom.container.show();
                    _ini();
                    _fixOverLimit();
                    _checkLimit();
                },
                show:function(){
                    _self.click();
                }
            };

            if (_beforeIni()) {
                _ini();
            }

            function _beforeIni() {
                if (typeof options != 'string') {
                    if (_self.attr(W.uidName)) {
                        return false;
                    } else {
                        //新建控件
                        var name, opts, paramGroup, dom, model;
                        name = 'ccCanlendar';
                        opts = $.extend({}, defaults, options);
                        paramGroup = {
                            currentDateTime: '',
                            clientToday: '',
                            showingMonth: {},
                            yearWidth:59,
                            monthWidth:34,
                            cur:{},
                            min:{},
                            max:{},
                            today:{}
                        };
                        dom = {
                            container: $('<div id="' + _self.attr('id') + '-ccCanlendar" class="ccCanlendar-container"></div>'),
                            datePanel: $('<div class="ccCanlendar-datePanel"></div>'),
                            datePanel_hd: $('<div class="ccCanlendar-datePanel-hd"></div>'),
                            datePanel_bd: $('<div class="ccCanlendar-datePanel-bd"></div>'),
                            datePanel_next: $('<div class="ccCanlendar-datePanel-next"></div>'),
                            datePanel_next_hd: $('<div class="ccCanlendar-datePanel-next-hd"></div>'),
                            datePanel_next_bd: $('<div class="ccCanlendar-datePanel-next-bd"></div>'),
                            hourPanel: $('<div class="ccCanlendar-hourPanel"></div>'),
                            hourPanel_hd: $('<div class="ccCanlendar-hourPanel-hd">小时</div>'),
                            hourPanel_bd: $('<div class="ccCanlendar-hourPanel-bd"></div>'),
                            minitePanel: $('<div class="ccCanlendar-minitePanel"></div>'),
                            minitePanel_hd: $('<div class="ccCanlendar-minitePanel-hd">分钟</div>'),
                            minitePanel_bd: $('<div class="ccCanlendar-minitePanel-bd"></div>'),
                            icon: _self.siblings('.ccCanlendar-inputIcon')
                        };
                        model = {
                            temp: '<span>123</span>'
                        };
                        widget = W.create(name, opts, paramGroup, dom, model);
                        _self.attr(W.uidName, widget.uid);
                        return widget.uid;
                    }
                } else {
                    var command = options;
                    if (_self.attr(W.uidName)) {
                        //装载控件
                        var uid = _self.attr(W.uidName);
                        widget = W.get(uid);
                        //字符串命令的处理接口，args可以是数组参数，也可以是单个参数
                        if (commandExecutor[command]) {
                            if(args) {
                                commandExecutor[command].apply(this, args);
                            }else{
                                commandExecutor[command].apply(this);
                            }
                        }
                    } else {
                    }
                    return false;
                }
            }

            //初始化
            function _ini() {
                widget.dom.datePanel.append(widget.dom.datePanel_hd);
                widget.dom.datePanel.append(widget.dom.datePanel_bd);
                widget.dom.datePanel_next.append(widget.dom.datePanel_next_hd);
                widget.dom.datePanel_next.append(widget.dom.datePanel_next_bd);
                widget.dom.hourPanel.append(widget.dom.hourPanel_hd);
                widget.dom.hourPanel.append(widget.dom.hourPanel_bd);
                widget.dom.minitePanel.append(widget.dom.minitePanel_hd);
                widget.dom.minitePanel.append(widget.dom.minitePanel_bd);

                /*修复IE8中框体选中的出现蓝色背景*/
                widget.dom.container.attr('unselectable', 'on');
                widget.dom.container.attr('onselectstart', 'javascript:return false;');

                if (widget.opts.hasDatePanel) {
                    widget.dom.container.append(widget.dom.datePanel);
                    if (widget.opts.showNextMonth) {
                        widget.dom.container.append(widget.dom.datePanel_next);
                    }
                }
                if (widget.opts.hasHourPanel) {
                    widget.dom.container.append(widget.dom.hourPanel);
                }
                if (widget.opts.hasMinitePanel) {
                    widget.dom.container.append(widget.dom.minitePanel);
                }

                $('body').append(widget.dom.container);

                _self.click(function (e) {
                    _show(e);
                });

                widget.dom.icon.click(function (e) {
                    _show(e);
                });

                widget.dom.container.click(function (e) {
                    e.stopPropagation();
                    $(this).find('.ccCanlendar-dropdown-menu-box').hide();
                });

                $(window).resize(function () {
                    widget.dom.container.css({
                        top: _self.offset().top + _self.get(0).offsetHeight,
                        left: _self.offset().left
                    });
                });

                $(document).click(function (e) {
                    if(_getYear(widget.paramGroup.currentDateTime)!=widget.paramGroup.showingMonth.y||_getMonth(widget.paramGroup.currentDateTime)!=widget.paramGroup.showingMonth.m) {
                        _CreateUI();
                    }else{
                        widget.dom.container.hide();
                    }
                });

                //获取客户端的当前时间
                var newDate = new Date();

                if (widget.opts.hasDatePanel && widget.opts.hasHourPanel && widget.opts.hasMinitePanel) {
                    widget.paramGroup.clientToday = _formatDateTime(newDate.getFullYear(), newDate.getMonth() + 1, newDate.getDate(), newDate.getHours(), newDate.getMinutes());
                } else if (widget.opts.hasDatePanel && widget.opts.hasHourPanel) {
                    widget.paramGroup.clientToday = _formatDateTime(newDate.getFullYear(), newDate.getMonth() + 1, newDate.getDate(), newDate.getHours(), -1);
                } else {
                    widget.paramGroup.clientToday = _formatDateTime(newDate.getFullYear(), newDate.getMonth() + 1, newDate.getDate(), -1, -1);
                }

                if (_self.val() == '') {
                    widget.paramGroup.currentDateTime = widget.paramGroup.clientToday;
                } else {
                    widget.paramGroup.currentDateTime = _self.val();
                }

                //是否自动设置最小可选时间点
                if (widget.opts.autoSetMinLimit) {
                    if (!widget.opts.minLimit) {
                        widget.opts.minLimit = widget.paramGroup.currentDateTime;
                    }
                }

                if (widget.opts.autoSetMaxLimit) {
                    if (!widget.opts.maxLimit) {
                        widget.opts.maxLimit = widget.paramGroup.currentDateTime;
                    }
                }

                if (widget.opts.minLimit) {
                    if (_compare(widget.opts.minLimit, widget.paramGroup.currentDateTime) == 1) {
                        widget.paramGroup.currentDateTime = widget.opts.minLimit;
                    }
                }
                if (widget.opts.maxLimit) {
                    if (_compare(widget.opts.maxLimit, widget.paramGroup.currentDateTime) == -1) {
                        widget.paramGroup.currentDateTime = widget.opts.maxLimit;
                    }
                }

                widget.paramGroup.showingMonth.y = _getYear(widget.paramGroup.currentDateTime);

                widget.paramGroup.showingMonth.m = _getMonth(widget.paramGroup.currentDateTime);

                //是否需要显示一个初始值在input中，如果是有服务器回调赋值，那么请将iniValue该为false
                if(widget.opts.iniValue){
                    _self.val(widget.paramGroup.currentDateTime);
                }
                _CreateUI();
            }
            function _show(e) {
                W.clickBody(widget.uid);
                e.stopPropagation();
                widget.dom.container.css({
                    top: _self.offset().top + _self.get(0).offsetHeight,
                    left: _self.offset().left
                });
                widget.dom.container.show();
                widget.dom.container.focus();
                _self.blur();
                //当日历控件被打开的时候重置时间和分钟的滚动条
                if (widget.opts.hasHourPanel) {
                    _resetScroll(widget.dom.hourPanel);
                }
                if (widget.opts.hasMinitePanel) {
                    _resetScroll(widget.dom.minitePanel);
                }
                _checkLimit();
                widget.opts.onShow.apply(this);
            }
            //开始构建
            function _CreateUI() {
                if (widget.opts.hasDatePanel) {
                    widget.paramGroup.showingMonth = {
                        y: _getYear(widget.paramGroup.currentDateTime),
                        m: _getMonth(widget.paramGroup.currentDateTime)
                    }
                    widget.paramGroup.cur.year = _getYear(widget.paramGroup.currentDateTime);
                    widget.paramGroup.cur.month = _getMonth(widget.paramGroup.currentDateTime);
                    widget.paramGroup.cur.day = _getDay(widget.paramGroup.currentDateTime);
                    widget.paramGroup.today.year = _getYear(widget.paramGroup.clientToday);
                    widget.paramGroup.today.month = _getMonth(widget.paramGroup.clientToday);
                    widget.paramGroup.today.day = _getDay(widget.paramGroup.clientToday);
                    if(widget.opts.minLimit){
                        widget.paramGroup.min.year = _getYear(widget.opts.minLimit);
                        widget.paramGroup.min.month = _getMonth(widget.opts.minLimit);
                        widget.paramGroup.min.day = _getDay(widget.opts.minLimit);
                    }
                    if(widget.opts.maxLimit){
                        widget.paramGroup.max.year = _getYear(widget.opts.maxLimit);
                        widget.paramGroup.max.month = _getMonth(widget.opts.maxLimit);
                        widget.paramGroup.max.day = _getDay(widget.opts.maxLimit);
                    }
                    _CreateUI_DatePanel(widget.paramGroup.cur.year, widget.paramGroup.cur.month);
                }
                if (widget.opts.hasHourPanel) {
                    widget.paramGroup.cur.hour = _getHour(widget.paramGroup.currentDateTime);
                    if(widget.opts.minLimit){widget.paramGroup.min.hour = _getHour(widget.opts.minLimit);}
                    if(widget.opts.maxLimit){widget.paramGroup.max.hour = _getHour(widget.opts.maxLimit);}
                    _CreateUI_HourPanel(widget.paramGroup.cur.hour);
                }
                if (widget.opts.hasMinitePanel) {
                    widget.paramGroup.cur.minite = _getMinite(widget.paramGroup.currentDateTime);
                    if(widget.opts.minLimit){widget.paramGroup.min.minite = _getMinite(widget.opts.minLimit);}
                    if(widget.opts.maxLimit){widget.paramGroup.max.minite = _getMinite(widget.opts.maxLimit);}
                    _CreateUI_MinitePanel(widget.paramGroup.cur.minite);
                }
                //初始化构建完毕，隐藏日历
                widget.dom.container.hide();
            }
            function _fixOverLimit(){
                if (widget.opts.minLimit) {
                    if (_compare(widget.paramGroup.currentDateTime, widget.opts.minLimit) >= 0) {
                        _self.val(widget.paramGroup.currentDateTime);
                    } else {
                        widget.paramGroup.currentDateTime = widget.opts.minLimit;
                        _self.val(widget.opts.minLimit);
                    }
                } else {
                    _self.val(widget.paramGroup.currentDateTime);
                }
                if (widget.opts.maxLimit) {
                    if (_compare(widget.paramGroup.currentDateTime, widget.opts.maxLimit) <= 0) {
                        _self.val(widget.paramGroup.currentDateTime);
                    } else {
                        widget.paramGroup.currentDateTime = widget.opts.maxLimit;
                        _self.val(widget.opts.maxLimit);
                    }
                } else {
                    _self.val(widget.paramGroup.currentDateTime);
                }
            }
            function _checkLimit() {
                var opts = widget.opts;
                var y = widget.paramGroup.showingMonth.y;
                var m = widget.paramGroup.showingMonth.m;
                if (opts.minLimit) {
                    if (y <= widget.paramGroup.min.year && m <= widget.paramGroup.min.month) {
                        widget.dom.datePanel_hd.find('.ccCanlendar-arrow-left').hide();
                    } else {
                        widget.dom.datePanel_hd.find('.ccCanlendar-arrow-left').show();
                    }
                } else {
                    if (y == widget.opts.startYear && m == 1) {
                        widget.dom.datePanel_hd.find('.ccCanlendar-arrow-left').hide();
                    } else {
                        widget.dom.datePanel_hd.find('.ccCanlendar-arrow-left').show();
                    }
                }
                if (opts.showNextMonth) {
                    if (opts.maxLimit) {
                        var maxYear = widget.paramGroup.max.year;
                        var maxMonth = widget.paramGroup.max.month;
                        if (maxMonth == 1) {
                            maxYear--;
                            maxMonth = 12;
                        } else {
                            maxMonth--;
                        }
                        if (y >= maxYear && m >= maxMonth) {
                            widget.dom.datePanel_next_hd.find('.ccCanlendar-arrow-right').hide();
                        } else {
                            widget.dom.datePanel_next_hd.find('.ccCanlendar-arrow-right').show();
                        }
                    } else {
                        if (y == widget.opts.endYear && m == 11) {
                            widget.dom.datePanel_next_hd.find('.ccCanlendar-arrow-right').hide();
                        } else {
                            widget.dom.datePanel_next_hd.find('.ccCanlendar-arrow-right').show();
                        }
                    }
                } else {
                    if (opts.maxLimit) {
                        if (y == widget.paramGroup.max.year && m == widget.paramGroup.max.month) {
                            widget.dom.datePanel_hd.find('.ccCanlendar-arrow-right').hide();
                        } else {
                            widget.dom.datePanel_hd.find('.ccCanlendar-arrow-right').show();
                        }
                    } else {
                        if (y == widget.opts.endYear && m == 12) {
                            widget.dom.datePanel_hd.find('.ccCanlendar-arrow-right').hide();
                        } else {
                            widget.dom.datePanel_hd.find('.ccCanlendar-arrow-right').show();
                        }
                    }
                }
            }
            //构建日期
            function _CreateUI_DatePanel(y, m) {
                var hd = widget.dom.datePanel_hd;
                var bd = widget.dom.datePanel_bd;
                var n_hd = widget.dom.datePanel_next_hd;
                var n_bd = widget.dom.datePanel_next_bd;
                _CreateDateTable(hd, bd, y, m);
                if (widget.opts.showNextMonth) {
                    var nextMonth = _getNextMonth(y, m);
                    _CreateDateTable(n_hd, n_bd, nextMonth.year, nextMonth.month);
                }
                _iniDateControl(widget.dom.datePanel, widget.dom.datePanel_next);
                _checkLimit();
            }
            //构建日期中的年份选择
            function _iniYearMenu(hd) {
                var yearMenu = hd.find('.ccCanlendar-dropdown-menu').eq(0);
                var yearCurrent = parseInt(yearMenu.find('i').text());
                var monthCurrent = parseInt(yearMenu.next('.ccCanlendar-dropdown-menu').find('i').text());
                if (widget.opts.endYear - widget.opts.startYear > 0) {
                    yearMenu.append('<div class="ccCanlendar-dropdown-menu-box"><div class="ccCanlendar-viewport">' + '<div class="ccCanlendar-scrollpane"></div>' + '<div class="ccCanlendar-scrollbar">' + '<div class="ccCanlendar-scrollthumb"></div>' + '</div>' + '</div></div>');
                    var scrollpane = yearMenu.find('.ccCanlendar-scrollpane');
                    for (var i = widget.opts.startYear; i <= widget.opts.endYear; i++) {
                        var option = $('<div class="ccCanlendar-option">' + i + '</div>');
                        scrollpane.append(option);
                        option.css({
                            width:widget.paramGroup.yearWidth
                        });
                        _addHoverEvent(option);
                        if (yearCurrent == i) {
                            option.addClass('ccCanlendar-select');
                        }
                        option.click(function () {
                            var t = $(this);
                            if (!t.hasClass('ccCanlendar-select')) {
                                t.siblings().removeClass('ccCanlendar-select');
                                t.addClass('ccCanlendar-select');
                                var year = parseInt(t.text());
                                var month = monthCurrent;
                                if (widget.opts.showNextMonth) {
                                    if (year == widget.opts.endYear && month == 12) {
                                        month--;
                                    }
                                }
                                _changeMonth({ y: year, m: month });
                            }
                        });
                    }
                    _iniScroll(yearMenu);
                    _resetScroll(yearMenu);
                    yearMenu.find('.ccCanlendar-dropdown-menu-box').hide();
                    yearMenu.click(function (e) {
                        e.stopPropagation();
                    });
                    yearMenu.find('i').click(function () {
                        yearMenu.find('.ccCanlendar-dropdown-menu-box').show();
                    });
                }
            }
            //构建日期中的月份选择
            function _iniMonthMenu(hd) {
                var monthMenu = hd.find('.ccCanlendar-dropdown-menu').eq(1);
                monthMenu.append('<div class="ccCanlendar-dropdown-menu-box"><div class="ccCanlendar-viewport">' + '<div class="ccCanlendar-scrollpane"></div>' + '<div class="ccCanlendar-scrollbar">' + '<div class="ccCanlendar-scrollthumb"></div>' + '</div>' + '</div></div>');
                var scrollpane = monthMenu.find('.ccCanlendar-scrollpane');
                var yearCurrent = parseInt(monthMenu.prev('.ccCanlendar-dropdown-menu').find('i').text());
                var monthCurrent = parseInt(monthMenu.find('i').text());
                for (var i = 1; i <= 12; i++) {
                    var option = $('<div class="ccCanlendar-option">' + i + '</div>');
                    scrollpane.append(option);
                    option.css({
                        width:widget.paramGroup.monthWidth
                    });
                    _addHoverEvent(option);
                    if (monthCurrent == i) {
                        option.addClass('ccCanlendar-select');
                    }
                    option.click(function () {
                        var t = $(this);
                        if (!t.hasClass('ccCanlendar-select')) {
                            t.siblings().removeClass('ccCanlendar-select');
                            t.addClass('ccCanlendar-select');
                            var year = yearCurrent;
                            var month = parseInt(t.text());
                            if (widget.opts.showNextMonth) {
                                if (year == widget.opts.endYear && month == 12) {
                                    month--;
                                }
                            }
                            _changeMonth({ y: year, m: month});
                        }
                    });
                }
                _iniScroll(monthMenu);
                _resetScroll(monthMenu);
                monthMenu.find('.ccCanlendar-dropdown-menu-box').hide();
                monthMenu.click(function (e) {
                    e.stopPropagation();
                });
                monthMenu.find('i').click(function () {
                    monthMenu.find('.ccCanlendar-dropdown-menu-box').show();
                });
            }
            //渲染日期中的table
            function _CreateDateTable(hd, bd, y, m) {
                if (widget.opts.showNextMonth) {
                    if (hd.hasClass('ccCanlendar-datePanel-hd')) {
                        hd.html('<span class="ccCanlendar-arrow-left"><i></i></span><span class="ccCanlendar-dropdown-menu"><i>' + y + '</i>年</span><span class="ccCanlendar-dropdown-menu"><i>' + m + '</i>月</span>');
                    } else {
                        hd.html('<span class="ccCanlendar-dropdown-menu"><i>' + y + '</i>年</span><span class="ccCanlendar-dropdown-menu"><i>' + m + '</i>月</span><span class="ccCanlendar-arrow-right"><i></i></span>');
                    }
                } else {
                    hd.html('<span class="ccCanlendar-arrow-left"><i></i></span><span class="ccCanlendar-dropdown-menu"><i>' + y + '</i>年</span><span class="ccCanlendar-dropdown-menu"><i>' + m + '</i>月</span><span class="ccCanlendar-arrow-right"><i></i></span>');
                }

                _iniYearMenu(hd);
                _iniMonthMenu(hd);

                bd.html('<table class="ccCanlendar-date-table" cellpadding="0" cellspacing="0">' + '<tr>' + '<td class="ccCanlendar-date-td-weekname">日</td>' + '<td class="ccCanlendar-date-td-weekname">一</td>' + '<td class="ccCanlendar-date-td-weekname">二</td>' + '<td class="ccCanlendar-date-td-weekname">三</td>' + '<td class="ccCanlendar-date-td-weekname">四</td>' + '<td class="ccCanlendar-date-td-weekname">五</td>' + '<td class="ccCanlendar-date-td-weekname">六</td>' + '</tr>' + '</table>');
                var dateTable = bd.find('.ccCanlendar-date-table');
                var dateTdModel = $('<td class="ccCanlendar-date"></td>');
                var data = _getDateTableDatas(y, m);
                var tr = $('<tr></tr>');
                dateTable.append(tr);
                var temp_j = 0;
                for (var i = 0; i < data.length; i++) {
                    if (tr.children().size() == 7) {
                        temp_j = 0;
                        tr = $('<tr></tr>');
                        dateTable.append(tr);
                    }
                    for (var j = temp_j; j < 7; j++) {
                        var date = dateTdModel.clone();
                        if (data[i].weeknumber == j) {
                            date.text(data[i].day);
                            date.attr('data-year', data[i].year);
                            date.attr('data-month', data[i].month);
                            date.attr('data-day', data[i].day);
                            if (data[i].year == widget.paramGroup.today.year && data[i].month == widget.paramGroup.today.month && data[i].day == widget.paramGroup.today.day) {
                                date.addClass('ccCanlendar-today');
                                date.text('今天');
                                date.css({
                                    width: 31 + 'px',
                                    padding: 0,
                                    textAlign: 'center'
                                });
                            }
                            if (holiday[data[i].month + '-' + data[i].day]) {
                                date.addClass('ccCanlendar-holiday');
                                date.text(holiday[data[i].month + '-' + data[i].day]);
                                date.css({
                                    width: 31 + 'px',
                                    padding: 0,
                                    textAlign: 'center'
                                });
                            }
                            if (data[i].year == widget.paramGroup.cur.year  && data[i].month == widget.paramGroup.cur.month  && data[i].day == widget.paramGroup.cur.day) {
                                date.addClass('ccCanlendar-select');
                            }
                            if (data[i].status == 0) {
                                date.addClass('ccCanlendar-date-false');
                            } else if (data[i].status == 1) {
                                date.addClass('ccCanlendar-date-hasTip');
                                _addHoverEvent(date);
                                date.click(function () {
                                    _selectDate($(this));
                                });
                            } else if (data[i].status == 2) {
                                date.addClass('ccCanlendar-date-false');
                            } else {
                                _addHoverEvent(date);
                                date.click(function () {
                                    _selectDate($(this));
                                });
                            }
                            tr.append(date);
                            if (i != data.length - 1) {
                                temp_j = j;
                                break;
                            }
                        } else if (data[i].weeknumber > j) {
                            if (i == 0) {
                                tr.append(date);
                            }
                        } else if (data[i].weeknumber < j) {
                            if (i == data.length - 1) {
                                tr.append(date);
                            }
                        }
                    }
                }
            }
            //返回构建日期中的table的数据
            function _getDateTableDatas(y, m) {
                var re = new Array();
                var dayCount = _getMonthDayCount(y, m);

                var min = {
                    year: _getYear(widget.opts.minLimit),
                    month: _getMonth(widget.opts.minLimit),
                    day: _getDay(widget.opts.minLimit)
                };
                var max = {
                    year: _getYear(widget.opts.maxLimit),
                    month: _getMonth(widget.opts.maxLimit),
                    day: _getDay(widget.opts.maxLimit)
                };

                for (var d = 0; d < dayCount; d++) {
                    re[d] = new Object();
                    re[d].year = y;
                    re[d].month = m;
                    re[d].day = d + 1;
                    re[d].weeknumber = _getWeekNumber(y, m, d + 1);
                    if (widget.opts.minLimit) {
                        if (re[d].year < widget.paramGroup.min.year) {
                            re[d].status = 0;
                        } else if (re[d].year > widget.paramGroup.min.year) {
                            re[d].status = -1;
                        } else {
                            if (re[d].month < widget.paramGroup.min.month) {
                                re[d].status = 0;
                            } else if (re[d].month > widget.paramGroup.min.month) {
                                re[d].status = -1;
                            } else {
                                if (re[d].day < widget.paramGroup.min.day) {
                                    re[d].status = 0;
                                } else {
                                    re[d].status = -1;
                                }
                            }
                        }
                    }
                    if (widget.opts.maxLimit) {
                        if (re[d].year > widget.paramGroup.max.year) {
                            re[d].status = 0;
                        } else if (re[d].year < widget.paramGroup.max.year) {
                            re[d].status = -1;
                        } else {
                            if (re[d].month > widget.paramGroup.max.month) {
                                re[d].status = 0;
                            } else if (re[d].month < widget.paramGroup.max.month) {
                                re[d].status = -1;
                            } else {
                                if (re[d].day > widget.paramGroup.max.day) {
                                    re[d].status = 0;
                                } else {
                                    if (re[d].status != 0 && re[d].status != 2) {
                                        re[d].status = -1;
                                    }
                                }
                            }
                        }
                    }
                    re[d].shortPrice = 0;
                    re[d].longPrice = 0;
                }
                return re;
            }
            //构建时间
            function _CreateUI_HourPanel(h) {
                var bd = widget.dom.hourPanel_bd;
                bd.html('<div class="ccCanlendar-arrow-up"><i></i></div>' + '<div class="ccCanlendar-viewport">' + '<div class="ccCanlendar-scrollpane"></div>' + '<div class="ccCanlendar-scrollbar">' + '<div class="ccCanlendar-scrollthumb"></div>' + '</div>' + '</div>' + '<div class="ccCanlendar-arrow-down"><i></i></div>');
                var scrollpane = bd.find('.ccCanlendar-scrollpane');
                var hourModel = $('<div class="ccCanlendar-hour"></div>');

                for (var i = 0; i < 24; i++) {
                    var flag = true;
                    var hour = hourModel.clone();
                    var str = '';
                    i < 10 ? str = '0' + i : str = i;
                    hour.attr('data-hour', str);
                    if (widget.opts.hasMinitePanel) {
                        hour.text(str);
                    } else {
                        hour.text(str + ':00');
                    }
                    scrollpane.append(hour);
                    if (widget.paramGroup.min.year == widget.paramGroup.cur.year
                        && widget.paramGroup.min.month == widget.paramGroup.cur.month
                        && widget.paramGroup.min.day == widget.paramGroup.cur.day) {
                        if (i < widget.paramGroup.min.hour) {
                            hour.addClass('ccCanlendar-hour-false');
                            flag = false;
                        } else {
                            hour.removeClass('ccCanlendar-hour-false');
                            flag = true;
                        }
                    }
                    if (widget.paramGroup.max.year == widget.paramGroup.cur.year
                        && widget.paramGroup.max.month == widget.paramGroup.cur.month
                        && widget.paramGroup.max.day == widget.paramGroup.cur.day) {
                        if (i > widget.paramGroup.max.hour) {
                            hour.addClass('ccCanlendar-hour-false');
                            flag = false;
                        } else {
                        	if(i > widget.paramGroup.min.hour){
	                            hour.removeClass('ccCanlendar-hour-false');
	                            flag = true;
                        	}
                        }
                    }
                    if (flag) {
                        _addHoverEvent(hour);
                        hour.click(function () {
                            _selectHour($(this));
                        });
                    }
                    if (i == h) {
                        hour.addClass('ccCanlendar-select');
                    }
                }
                _iniScroll(widget.dom.hourPanel);
            }
            //构建分钟
            function _CreateUI_MinitePanel(m) {
                var bd = widget.dom.minitePanel_bd;
                bd.html('<div class="ccCanlendar-arrow-up"><i></i></div>' + '<div class="ccCanlendar-viewport">' + '<div class="ccCanlendar-scrollpane"></div>' + '<div class="ccCanlendar-scrollbar">' + '<div class="ccCanlendar-scrollthumb"></div>' + '</div>' + '</div>' + '<div class="ccCanlendar-arrow-down"><i></i></div>');
                var scrollpane = bd.find('.ccCanlendar-scrollpane');
                var miniteModel = $('<div class="ccCanlendar-minite"></div>');
                for (var i = 0; i < 60; i++) {
                    var flag = true;
                    var minite = miniteModel.clone();
                    var str = '';
                    i < 10 ? str = '0' + i : str = i;
                    minite.attr('data-minite', str);
                    minite.text(str);
                    scrollpane.append(minite);
                    if (widget.paramGroup.min.year == widget.paramGroup.cur.year
                        && widget.paramGroup.min.month == widget.paramGroup.cur.month
                        && widget.paramGroup.min.day == widget.paramGroup.cur.day
                        && widget.paramGroup.min.hour == widget.paramGroup.cur.hour) {
                        if (i < widget.paramGroup.min.minite) {
                            minite.addClass('ccCanlendar-minite-false');
                            flag = false;
                        } else {
                            minite.removeClass('ccCanlendar-minite-false');
                            flag = true;
                        }
                    }
                    if (widget.paramGroup.max.year == widget.paramGroup.cur.year
                        && widget.paramGroup.max.month == widget.paramGroup.cur.month
                        && widget.paramGroup.max.day == widget.paramGroup.cur.day
                        && widget.paramGroup.max.hour == widget.paramGroup.cur.hour) {
                        if (i > widget.paramGroup.max.minite) {
                            minite.addClass('ccCanlendar-minite-false');
                            flag = false;
                        } else {
                        	if(i > widget.paramGroup.min.minite){
                        		minite.removeClass('ccCanlendar-minite-false');
                                flag = true;
                        	}
                        }
                    }
                    if (flag) {
                        _addHoverEvent(minite);
                        minite.click(function () {
                            _selectMinite($(this));
                        });
                    }
                    if (i == m) {
                        minite.addClass('ccCanlendar-select');
                    }
                }
                _iniScroll(widget.dom.minitePanel);
            }
            //选择日期
            function _selectDate(date) {
                if (!date.hasClass('ccCanlendar-select')) {
                    widget.dom.container.find('.ccCanlendar-date').removeClass('ccCanlendar-select');
                    date.addClass('ccCanlendar-select');
                    widget.paramGroup.currentDateTime = _formatDateTime(_parseInt(date.attr('data-year')), _parseInt(date.attr('data-month')), _parseInt(date.attr('data-day')), _getHour(widget.paramGroup.currentDateTime), _getMinite(widget.paramGroup.currentDateTime));
                    widget.paramGroup.cur.year = _getYear(widget.paramGroup.currentDateTime);
                    widget.paramGroup.cur.month = _getMonth(widget.paramGroup.currentDateTime);
                    widget.paramGroup.cur.day = _getDay(widget.paramGroup.currentDateTime);
                    _fixOverLimit();
                    if (widget.opts.hasHourPanel) {
                        widget.paramGroup.cur.hour = _getHour(widget.paramGroup.currentDateTime);
                        _CreateUI_HourPanel(widget.paramGroup.cur.hour);
                        _resetScroll(widget.dom.hourPanel);
                    }
                    if (widget.opts.hasMinitePanel) {
                        widget.paramGroup.cur.minite = _getMinite(widget.paramGroup.currentDateTime);
                        _CreateUI_MinitePanel(widget.paramGroup.cur.minite);
                        _resetScroll(widget.dom.minitePanel);
                    }
                } else {
                    if (_self.val() == '') {
                        _self.val(widget.paramGroup.currentDateTime);
                    }
                }
                if (!widget.opts.hasHourPanel && !widget.opts.hasMinitePanel) {
                    widget.dom.container.hide();
                }
                widget.opts.onSelectDate.apply(this);
            }
            //选择时间
            function _selectHour(h) {
                if (!h.hasClass('ccCanlendar-select')) {
                    widget.dom.container.find('.ccCanlendar-hour').removeClass('ccCanlendar-select');
                    h.addClass('ccCanlendar-select');
                    widget.paramGroup.currentDateTime = _formatDateTime(_getYear(widget.paramGroup.currentDateTime), _getMonth(widget.paramGroup.currentDateTime), _getDay(widget.paramGroup.currentDateTime), _parseInt(h.attr('data-hour')), _parseInt(_getMinite(widget.paramGroup.currentDateTime)));
                    widget.paramGroup.cur.hour = _getHour(widget.paramGroup.currentDateTime);
                    _fixOverLimit();
                    if (widget.opts.hasMinitePanel) {
                        widget.paramGroup.cur.minite = _getMinite(widget.paramGroup.currentDateTime);
                        _CreateUI_MinitePanel(widget.paramGroup.cur.minite);
                        _resetScroll(widget.dom.minitePanel);
                    }
                } else {
                    if (_self.val() == '') {
                        _self.val(widget.paramGroup.currentDateTime);
                    }
                }
                if (!widget.opts.hasMinitePanel) {
                    widget.dom.container.hide();
                }
                widget.opts.onSelectHour.apply(this);
            }
            //选择分钟
            function _selectMinite(m) {
                if (!m.hasClass('ccCanlendar-select')) {
                    widget.dom.container.find('.ccCanlendar-minite').removeClass('ccCanlendar-select');
                    m.addClass('ccCanlendar-select');
                    widget.paramGroup.currentDateTime = _formatDateTime(_getYear(widget.paramGroup.currentDateTime), _getMonth(widget.paramGroup.currentDateTime), _getDay(widget.paramGroup.currentDateTime), _parseInt(_getHour(widget.paramGroup.currentDateTime)), _parseInt(m.attr('data-minite')));
                    widget.paramGroup.cur.minite = _getMinite(widget.paramGroup.currentDateTime);
                    _self.val(widget.paramGroup.currentDateTime);
                } else {
                    if (_self.val() == '') {
                        _self.val(widget.paramGroup.currentDateTime);
                    }
                }
                widget.dom.container.hide();
                widget.opts.onSelectMinite.apply(this);
            }
            //初始化滚动条控件
            function _iniScroll(panel) {
                var scrollpane = panel.find('.ccCanlendar-scrollpane');
                var scrollbar = panel.find('.ccCanlendar-scrollbar');
                var scrollthumb = panel.find('.ccCanlendar-scrollthumb');
                var up = panel.find('.ccCanlendar-arrow-up');
                var down = panel.find('.ccCanlendar-arrow-down');
                var delay = 50;
                var timer;
                scrollthumb.css({
                    height: scrollbar.height() / scrollpane.height() * scrollbar.height() + "px"
                });
                _addHoverEvent(scrollthumb);
                _addHoverEvent(up);
                _addHoverEvent(down);
                up.mousedown(function () {
                    timer = window.setTimeout(btn_scrollup, delay);
                });
                up.mouseup(function () {
                    window.clearTimeout(timer);
                });
                down.mousedown(function () {
                    timer = window.setTimeout(btn_scrolldown, delay);
                });
                down.mouseup(function () {
                    window.clearTimeout(timer);
                });
                scrollpane.mousewheel(function (event) {
                    event.preventDefault();
                    var y = event.deltaY;
                    if (y > 0) {
                        wheel_scrollup();
                    } else {
                        wheel_scrolldown();
                    }
                });
                panel.mouseenter(function () {
                    scrollbar.fadeIn(100);
                });
                panel.mouseleave(function () {
                    scrollbar.fadeOut(100);
                });
                scrollthumb.mousedown(function (e) {
                    var startY = e.clientY;
                    scrollbar.bind('mousemove', function (ev) {
                        var h1 = scrollpane.children().eq(0).get(0).offsetHeight / scrollpane.height();
                        var h2 = (ev.clientY - startY) / scrollbar.height();
                        if (h2 < 0) {
                            if (h2 <= -h1) {
                                wheel_scrollup();
                                startY = ev.clientY;
                            }
                        } else {
                            if (h2 >= h1) {
                                wheel_scrolldown();
                                startY = ev.clientY;
                            }
                        }
                    });
                });
                scrollbar.mouseup(function (e){
                    scrollbar.unbind('mousemove');
                });
                scrollthumb.mouseleave(function (e) {
                    scrollbar.unbind('mousemove');
                });
                scrollbar.hide();
                function btn_scrollup() {
                    var mt = _parseInt(scrollpane.css('margin-top'));
                    var h = scrollpane.children().eq(0).get(0).offsetHeight;
                    if (mt + h <= 0) {
                        scrollpane.css({
                            marginTop: mt + h + 'px'
                        });
                        scrollthumb.css({
                            marginTop: -(mt + h) * scrollbar.height() / scrollpane.height() + 'px'
                        });
                        timer = window.setTimeout(btn_scrollup, delay);
                    }
                }

                function btn_scrolldown() {
                    var mt = _parseInt(scrollpane.css('margin-top'));
                    var h = scrollpane.children().eq(0).get(0).offsetHeight;
                    if (mt - h >= -(scrollpane.height() - scrollbar.height())) {
                        scrollpane.css({
                            marginTop: mt - h + 'px'
                        });
                        scrollthumb.css({
                            marginTop: -(mt - h) * scrollbar.height() / scrollpane.height() + 'px'
                        });
                        timer = window.setTimeout(btn_scrolldown, delay);
                    }
                }

                function wheel_scrollup() {
                    var mt = _parseInt(scrollpane.css('margin-top'));
                    var h = scrollpane.children().eq(0).get(0).offsetHeight;
                    if (mt + h <= 0) {
                        scrollpane.css({
                            marginTop: mt + h + 'px'
                        });
                        scrollthumb.css({
                            marginTop: -(mt + h) * scrollbar.height() / scrollpane.height() + 'px'
                        });
                    }
                }

                function wheel_scrolldown() {
                    var mt = _parseInt(scrollpane.css('margin-top'));
                    var h = scrollpane.children().eq(0).get(0).offsetHeight;
                    if (mt - h >= -(scrollpane.height() - scrollbar.height())) {
                        scrollpane.css({
                            marginTop: mt - h + 'px'
                        });
                        scrollthumb.css({
                            marginTop: -(mt - h) * scrollbar.height() / scrollpane.height() + 'px'
                        });
                    }
                }
            }
            //在控件显示时重新计算下滚动条的位置
            function _resetScroll(panel) {
                var vnumber = 6;
                var scrollpane = panel.find('.ccCanlendar-scrollpane');
                var scrollbar = panel.find('.ccCanlendar-scrollbar');
                var scrollthumb = panel.find('.ccCanlendar-scrollthumb');
                var children = scrollpane.children();
                var sel = scrollpane.find('.ccCanlendar-select');
                var idx = children.index(sel);
                if (children.size() - idx >= vnumber) {
                    scrollthumb.css({
                        marginTop: idx * sel.get(0).offsetHeight * (scrollbar.height() / scrollpane.height()) + "px"
                    });
                    scrollpane.css({
                        marginTop: -idx * sel.get(0).offsetHeight + "px"
                    });
                } else {
                    var t = idx - (vnumber - (children.size() - idx));
                    scrollthumb.css({
                        marginTop: t * sel.get(0).offsetHeight * (scrollbar.height() / scrollpane.height()) + "px"
                    });
                    scrollpane.css({
                        marginTop: -t * sel.get(0).offsetHeight + "px"
                    });
                }
            }
            //月份的左右小按钮的事件绑定
            function _iniDateControl(p, pn) {
                if (!widget.opts.showNextMonth) {
                    var al = p.find('.ccCanlendar-arrow-left');
                    var ar = p.find('.ccCanlendar-arrow-right');
                    al.click(function () {
                        _changeMonth(-1);
                    });
                    ar.click(function () {
                        _changeMonth(1);
                    });
                } else {
                    var al = p.find('.ccCanlendar-arrow-left');
                    var ar = pn.find('.ccCanlendar-arrow-right');
                    al.click(function () {
                        _changeMonth(-1);
                    });
                    ar.click(function () {
                        _changeMonth(1);
                    });
                }
                p.find('span.ccCanlendar-dropdown-menu');
            }
            //改变月份后，生成的临时用来显示的日历，如果用户没有选择那么在关闭控件后，控件会重新进行UI构建
            function _renderTempMonth() {
                if (widget.opts.hasDatePanel) {
                    _CreateUI_DatePanel(widget.paramGroup.showingMonth.y, widget.paramGroup.showingMonth.m);
                }
                if (widget.opts.hasHourPanel) {
                    _CreateUI_HourPanel(_getHour(widget.paramGroup.currentDateTime));
                    _resetScroll(widget.dom.hourPanel);
                }
                if (widget.opts.hasMinitePanel) {
                    _CreateUI_MinitePanel(_getMinite(widget.paramGroup.currentDateTime));
                    _resetScroll(widget.dom.minitePanel);
                }
            }
            //改变月份
            function _changeMonth(cd) {
                if (cd == -1) {
                    if (widget.paramGroup.showingMonth.m == 1) {
                        widget.paramGroup.showingMonth.y = widget.paramGroup.showingMonth.y - 1;
                        widget.paramGroup.showingMonth.m = 12;
                    } else {
                        widget.paramGroup.showingMonth.m = widget.paramGroup.showingMonth.m - 1;
                    }
                    _renderTempMonth();
                } else if (cd == 1) {
                    if (widget.paramGroup.showingMonth.m == 12) {
                        widget.paramGroup.showingMonth.y = widget.paramGroup.showingMonth.y + 1;
                        widget.paramGroup.showingMonth.m = 1;
                    } else {
                        widget.paramGroup.showingMonth.m = widget.paramGroup.showingMonth.m + 1;
                    }
                    _renderTempMonth();
                } else {
                    widget.paramGroup.showingMonth.y = cd.y;
                    widget.paramGroup.showingMonth.m = cd.m;
                    _renderTempMonth();
                }
            }
            //fix IE8 不是a标签的情况下 对Hover类的不支持
            function _addHoverEvent(t) {
                t.mouseenter(function () {
                    $(this).addClass('ccCanlendar-hover');
                });
                t.mouseleave(function () {
                    $(this).removeClass('ccCanlendar-hover');
                });
            }
        });
    }

    /*以下全是一些基础的数据处理方法*/
    function _formatDateTime(y, m, d, h, i) {
        var _y = y;
        var _m = m <= 9 ? '0' + m : m;
        var _d = d <= 9 ? '0' + d : d;
        var _h = h <= 9 ? '0' + h : h;
        var _i = i <= 9 ? '0' + i : i;
        if (h != -1 && i != -1) {
            return _y + '-' + _m + '-' + _d + ' ' + _h + ':' + _i;
        } else if (h != -1) {
            return _y + '-' + _m + '-' + _d + ' ' + _h + ':00';
        } else {
            return _y + '-' + _m + '-' + _d;
        }
    }
    function _getYear(value) {
        var str = '';
        for (var i = 0; i < value.length; i++) {
            if (format.charAt(i) == 'y') {
                str += value.charAt(i);
            }
        }
        return _parseInt(str);
    }
    function _getMonth(value) {
        var str = '';
        for (var i = 0; i < value.length; i++) {
            if (format.charAt(i) == 'm') {
                str += value.charAt(i);
            }
        }
        return _parseInt(str);
    }
    function _getDay(value) {
        var str = '';
        for (var i = 0; i < value.length; i++) {
            if (format.charAt(i) == 'd') {
                str += value.charAt(i);
            }
        }
        return _parseInt(str);
    }
    function _getHour(value) {
        var str = '';
        for (var i = 0; i < value.length; i++) {
            if (format.charAt(i) == 'h') {
                str += value.charAt(i);
            }
        }
        return _parseInt(str);
    }
    function _getMinite(value) {
        var str = '';
        for (var i = 0; i < value.length; i++) {
            if (format.charAt(i) == 'i') {
                str += value.charAt(i);
            }
        }
        return _parseInt(str);
    }
    function _getWeekNumber(y, m, d) {
        var tempDate = new Date();
        tempDate.setFullYear(y,parseInt(m)-1,d);
        return tempDate.getDay();
    }
    function _getMonthDayCount(y, m) {
        if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) return 31;
        if (m == 4 || m == 6 || m == 9 || m == 11) return 30;
        if (m == 2) return y % 4 == 0 ? 29 : 28;
    }
    function _getNextMonth(y, m) {
        var o = new Object();
        if (m == 12) {
            o.year = y + 1;
            o.month = 1;
        } else {
            o.year = y;
            o.month = m + 1;
        }
        return o;
    }
    function _compare(a, b) {
        if (_number(a) > _number(b)) {
            return 1;
        } else if (_number(a) == _number(b)) {
            return 0;
        } else {
            return -1;
        }
    }
    function _number(str) {
        if (str == '') {
            return -1;
        }
        str = str + '';
        var _str = '';
        for (var i = 0; i < str.length; i++) {
            var temp = str.charAt(i);
            if (!isNaN(parseInt(temp))) {
                _str += temp;
            }
        }
        return parseInt(_str);
    }
    function _parseInt(str) {
        if (str == '' && str != '0') {
            return -1;
        }
        str = str + '';
        var _str = '';
        for (var i = 0; i < str.length; i++) {
            var temp = str.charAt(i);
            if (!isNaN(parseInt(temp))) {
                _str += temp;
            }
            if (i == 0 && temp == '-') {
                _str += temp;
            }
        }
        return parseInt(_str);
    }
    function _computeFuture(date, d, h, i) {
        var year = _getYear(date);
        var month = _getMonth(date);
        var day = _getDay(date);
        var hour = _getHour(date);
        var minite = _getMinite(date);

        while (i > 0) {
            if (minite + i > 59) {
                i = i - (59 - minite + 1);
                minite = 0;
                hour++;
            } else {
                minite = minite + i;
                i = 0;
            }
        }
        while (h > 0) {
            if (hour + h > 23) {
                h = h - (23 - hour + 1);
                hour = 0;
                day++;
                if(day > _getMonthDayCount(year, month)){
                    month++;
                    day=1;
                    if(month>12){
                        year++;
                        month=1;
                    }
                }
            } else {
                hour = hour + h;
                h = 0;
            }
        }
        while (d > 0) {
            var cd = _getMonthDayCount(year, month);
            if (day + d > cd) {
                d = d - (cd - day + 1);
                day = 1;
                month++;
                if (month > 12) {
                    year++;
                    month = 1;
                }
            } else {
                day = day + d;
                d = 0;
            }
        }

        if (this.hasDatePanel && this.hasHourPanel && this.hasMinitePanel) {
            return _formatDateTime(year, month, day, hour, minite);
        } else if (this.hasDatePanel && this.hasHourPanel) {
            return _formatDateTime(year, month, day, hour, -1);
        } else {
            return _formatDateTime(year, month, day, -1, -1);
        }
    }

    //关系逻辑：开始日期与结束日期
    W.StartDateAndEndDate = function (a,b,day,hour,minite,opts) {
        //a,b都是ccCanlendar对象
        if (a.attr(W.uidName) || b.attr(W.uidName)) {
            return;
        }
        //c,d,e分别是开始时间与结束时间的间隔 （1,2,15 代表间隔1天2个小时15分钟）,默认间隔1小时
        var _day = day;
        var _hour = hour;
        var _minite = minite;
        var startOpts = $.extend({},defaults,opts), endOpts = $.extend({},defaults,opts);
        var paramGroup = new Object();

        a.ccCanlendar(startOpts);

        if (a.val() == '') {
            a.ccCanlendar('getParam', ['clientToday', paramGroup]);
            endOpts.minLimit = _computeFuture.apply(endOpts,[paramGroup.clientToday, _day, _hour, _minite]);
        } else {
            endOpts.minLimit = _computeFuture.apply(endOpts,[a.val(), _day, _hour, _minite]);
        }

        b.ccCanlendar(endOpts);

        var startDateOnSelect = function () {
            b.ccCanlendar('setOption', [{
                minLimit: _computeFuture.apply(endOpts,[a.val(), _day, _hour, _minite])
            }]);
            b.ccCanlendar('minLimitChanged');
        }
        var startDateOnSelectOver = function(){
            b.ccCanlendar('setOption', [{
                minLimit: _computeFuture.apply(endOpts,[a.val(), _day, _hour, _minite])
            }]);
            b.ccCanlendar('minLimitChanged');
            b.ccCanlendar('show');
        }
        if(typeof opts.hasMinitePanel == 'undefined') {
            a.ccCanlendar('setOption', [
                { onSelectDate: startDateOnSelect, onSelectHour: startDateOnSelect, onSelectMinite: startDateOnSelectOver }
            ]);
        }else if(typeof opts.hasHourPanel == 'undefined'){
            a.ccCanlendar('setOption', [
                { onSelectDate: startDateOnSelect, onSelectHour: startDateOnSelectOver}
            ]);
        }else{
            a.ccCanlendar('setOption', [
                { onSelectDate: startDateOnSelectOver}
            ]);
        }
    }

    //关系逻辑：动态加载后台数据对日期进行再渲染
})(jQuery);
