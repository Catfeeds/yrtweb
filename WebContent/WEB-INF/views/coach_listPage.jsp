<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>教练员列表</title>
</head>
<body>
	    <div class="warp">
	        <!--头部-->
	    	<%@ include file="common/header.jsp" %>    
	    </div>
        <!--导航 start-->
        <%@ include file="common/naver.jsp" %>    
        <!--导航 end-->

        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="player clearfix">
                    <div class="player_se">
	                        <ul class="filter">
	                            <li class=" mt5">
	                                <div class="f_title">
	                                    <span>&emsp;&emsp;所属城市：</span>
	                                </div>
	                                <div class="filters ml10">
	                                     <select id="s_province" name="province"></select>&nbsp;&nbsp;
                                         <select id="s_city" name="city"></select>&nbsp;&nbsp;
                                         <select id="s_county" name="county" style="display: none;"></select>&nbsp;&nbsp;
	                                </div>
	                                <div class="clearit"></div>
	                            </li>
	                            <li class=" mt5">
	                                <div class="f_title">
	                                    <span>&emsp;&emsp;&emsp;&emsp;名称：</span>
	                                </div>
	                                <div class="filters ml10">
	                                    <input type="text" id="usernick" name="usernick" value="${usernick}" style="background:transparent;color: #fff;" />
	                                </div>
	                                <div class="clearit"></div>
	                            </li>
	                            <li class=" mt5">
	                                <div class="f_title">
	                                    <span>&emsp;所属俱乐部：</span>
	                                </div>
	                                <div class="filters ml10">
	                                    <input type="text" id="in_team" name="in_team" value="" style="background:transparent;color: #fff;" />
	                               		<input type="button" class="ms f14 tools_btn" style="padding:3px 13px;" value="搜索" onclick="searchForm()"/>
	                                </div>
	                                <div class="clearit"></div>
	                            </li>
	                        </ul>
                    </div>
                    <div class="clearit"></div>
                    <div style="width: 1000px;margin:20px auto 0;text-align: center">
                        <span class="f20 ms">教练列表</span>
                    </div>
                    <div id="tableDatas">
                    
                    </div>
                    <div class="clearit"></div>
                </div>
            </div>
        </div>

        <!--页脚-->
        <%@include file="common/footer.jsp" %>
    <script type="text/javascript" src="${ctx}/resources/js/area.js"></script>
    <script type="text/javascript">
    	$(function(){

	        new PCAS("province","city","county");
	        searchForm(1);
       	});

    	//搜索列表
       	function searchForm(currentPage){
          	$.ajax({
					type:"POST",
					url:base+"/coach/listdata?random="+Math.random(),
					data:{"province":$("#s_province").val(),"city":$("#s_city").val(),"usernick":$("#usernick").val(),"inteam":$("#in_team").val(),"currentPage":currentPage},
					dataType:"HTML",
					beforeSend:function(data){
						$("#tableDatas").append("<div style='width:500px;text-align:center;margin:35px auto -20px;'>loading...</div>");
					},
					success:function(data){
						$("#tableDatas").empty();
						$("#tableDatas").append(data);
					}
             	});
        }
    </script>
</body>
</html>
