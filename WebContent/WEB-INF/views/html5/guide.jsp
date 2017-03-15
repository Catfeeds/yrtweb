<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${adminSignCfg.title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <link href="${ctx}/resources/css/swiper.min.css" rel="stylesheet" />
    <style>
        html, body {
            position: relative;
            height: 100%;
        }

        body {
            background: #eee;
            font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
            font-size: 14px;
            color: #000;
            margin: 0;
            padding: 0;
        }

        .swiper-container {
            width: 100%;
            height: 100%;
        }

        .swiper-slide {
            text-align: center;
            font-size: 18px;
            background: #fff;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }
        .swiper-slide img {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <div class="swiper-container">
        <div class="swiper-wrapper">
			<c:forEach items="${fn:split(adminSignCfg.images,',')}" var="img" varStatus="i">	
	            <div class="swiper-slide">
	                <img src="${filePath}/${img}" <c:if test="${i.last}">onclick="window.location='${ctx}/html5/guide/${adminSignCfg.keyword}'"</c:if>/>	
	            </div>
			</c:forEach>
        </div>
        <div class="swiper-pagination"></div>
    </div>
    <script src="${ctx}/resources/js/swiper.min.js"></script>
    <script>
        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            onTouchEnd: function (swiper) {
                if (swiper.isEnd) {
                	window.location='${ctx}/html5/guide/${adminSignCfg.keyword}';
                }
            }
        });
    </script>
</body>
</html>