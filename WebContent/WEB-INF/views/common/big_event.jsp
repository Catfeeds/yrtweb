<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>宇任拓大事记</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/jquery.fullPage.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/fstyle.css">
</head>
<body>
    <div id="dowebok">
        <div class="section header fp-auto-height">
        </div>
        <div class="section banner active">
            <div class="center-wrap">
                <div class="desc banner-desc">

                    <img src="${ctx}/resources/images/d01-1.jpg" />
                </div>
            </div>
        </div>

        <div class="section thin">
            <div class="center-wrap">
                <div class="desc thin-desc">
                    <img src="${ctx}/resources/images/d02-1.jpg" />
                </div>
               
            </div>
        </div>

        <div class="section cnc">
            <div class="center-wrap">
                <div class="desc cnc-desc">
                    <img src="${ctx}/resources/images/d03-1.jpg" />
                </div>
            </div>
        </div>

        <div class="section screen">
            <div class="center-wrap">
                <div class="desc screen-desc">
                    <img src="${ctx}/resources/images/d04-1.jpg" />
                </div>
            </div>
        </div>

        <div class="section cpu">
            <div class="center-wrap">
                <div class="desc cpu-desc">
                    <img src="${ctx}/resources/images/d05-1.jpg" />
                </div>
               
            </div>
        </div>

        <div class="section footer fp-auto-height">

        </div>
    </div>
    <script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script>
    <script src="${ctx}/resources/js/jquery.fullPage.min.js"></script>

    <script>
        $(function () {
            var $mlNav = $('.ml-nav');
            $('#dowebok').fullpage({
                verticalCentered: !1,
                navigation: !0,
                onLeave: function (index, nextIndex, direction) {
                    if (index == 2 && direction == 'up') {
                        $mlNav.animate({
                            top: 80
                        }, 680);
                    } else if (index == 1 && direction == 'down') {
                        $mlNav.animate({
                            top: 0
                        }, 400);
                    } else if (index == 3 && direction == 'up') {
                        $mlNav.animate({
                            top: 0
                        }, 500);
                    } else {
                        $mlNav.animate({
                            top: -66
                        }, 400);
                    }
                }
            });
        });
    </script>

</body>
</html>