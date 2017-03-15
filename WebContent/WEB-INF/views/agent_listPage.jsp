<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>经纪人列表</title>
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
                            <li class="clearfix">
                                <div class="f_title">
                                    <span>&emsp;&emsp;寻找球员区域：</span>
                                </div>
                                <div class="filters">
                                    <a href="javascript:void(0);" onclick="getArea(this)">不限</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">欧洲</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">美洲</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">华南</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">华北</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">华东</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">华中</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">西南</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">东北</a>
                                    <a href="javascript:void(0);" onclick="getArea(this)">西北</a>
                                    <input type="hidden" id="area" name="area" value=""/>
                                </div>
                            </li>
                            <li class="clearfix mt5">
                                <div class="f_title">
                                    <span>&emsp;&emsp;&emsp;&emsp;常驻城市：</span>
                                </div>
                                <div class="filters ml10">
                                    <select id="s_province" name="province"></select>&nbsp;
                                    <select id="s_city" name="city"></select>&nbsp;
                                    <select id="s_county" name="county" style="display: none;"></select>&nbsp;
                                </div>
                            </li>
                             <li class="clearfix mt5">
                                <div class="f_title">
                                    <span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;名称：</span>
                                </div>
                                <div class="filters ml10">
                                    <input type="text" name="usernick" id="usernick" value="${usernick}" style="background:transparent;color: #fff;" />
                                </div>
                            </li>
                            <li class="clearfix mt5">
                                <div class="f_title">
                                    <span>&emsp;&emsp;&emsp;&emsp;所属公司：</span>
                                </div>
                                <div class="filters ml10">
                                    <input type="text" name="company" id="company" value="" style="background:transparent;color: #fff;" />
                                	<input type="button" class="ms f14 tools_btn" style="padding:3px 13px;" value="搜索" onclick="searchForm()"/>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="clearit"></div>
                    <div style="width: 1000px;margin:20px auto 0;text-align: center">
                        <span class="f20 ms">经纪人列表</span>
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
    	 	//added by bo.xie 先清空所选区域隐藏值
            document.getElementById("area").value="";
            
            
	        new PCAS("province","city","county");
	        searchForm(1);
       	});

    	//搜索列表
       	function searchForm(currentPage){
       		$.ajax({
       			type:"POST",
       			url:base+"/agent/listData?random="+Math.random(),
       			data:{"area":$("#area").val(),"province":$("#s_province").val(),"city":$("#s_city").val(),"usernick":$("#usernick").val(),
           				"company":$("#company").val()},
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

    	//added by bo.xie 选择区域
        function getArea(dom){
            $(dom).attr("style","color:#669966 ").siblings().removeAttr("style");
            var val = $(dom).text();
            if(val=="不限"){
                val = "";
            }
			$("#area").val(val);
        }
    </script>
</body>
</html>