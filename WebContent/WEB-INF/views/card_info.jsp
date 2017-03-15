<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/common.jsp" %>
<style>
.function_areas {
    width: 97%;
    margin: 0px auto;
    text-align: right;
}
  .fun_a {
    border: 1px solid #898989;
    border-radius: 4px;
    color: #fff;
    font: 12px/20px "SimSun","宋体","Arial Narrow",HELVETICA;
    padding: 2px 5px;
    vertical-align: middle;
}
.comat ul {
    width: 256px;
    
}
.comat li {
    text-align: center;
    display: inline-block;
    color: rgb(205, 201, 87);
    font: 12px/20px SimSun, 宋体, 'Arial Narrow', HELVETICA;
}

.boy {
    width: 16px;
    height: 16px;
    display: inline-block;
    background: url(${ctx}/resources/images/boygirl.png) -1px 1px;
}

.girl {
    width: 18px;
    height: 20px;
    display: inline-block;
    background: url(${ctx}/resources/images/boygirl.png) -1px -20px;
}
</style>
<!-- 用户名片信息 -->
      <!--功能-->
      <div class="function_areas">
      	<c:if test="${isMe eq false }">
      	  <c:choose>
	      		<c:when test="${reMap.guanzhu eq '0'}">
			    	<a href="javascript:void(0);" class="fun_a" onclick="focus_user(this,'${reMap.user_id}')">关注</a>
	      		</c:when>
	      		<c:otherwise>
			        <a href="javascript:void(0);" class="fun_a" onclick="focus_user(this,'${reMap.user_id}','true')">已关注</a>
	      		</c:otherwise>
      	  </c:choose>	
          <a href="javascript:void(0);" class="fun_a" onclick="openMsg('${reMap.user_id}','${reMap.usernick}');">私信</a>
          <a href="javascript:void(0);" class="fun_a" onclick="invite_user(this,'${reMap.user_id}');">邀请</a>
      	</c:if>
      </div>
      <!--信息-->
      <div class="card_info">
          <img src="${el:headPath()}${reMap.head_icon}" alt="" class="card_head" onclick="window.location='${ctx}/center/${reMap.user_id}'" style="cursor:pointer;"/>
          <ol class="card_details">
              <li><span class="card_name" onclick="window.location='${ctx}/center/${reMap.user_id}'" style="cursor:pointer;">${reMap.usernick}</span></li>
              <li>
              	  <c:choose>
              	  	<c:when test="${reMap.sex eq 1}">
	                  <span class="boy"></span>
              	  	</c:when>
              	  	<c:otherwise>
              	  	  <span class="girl"></span>
              	  	</c:otherwise>
              	  </c:choose>
                  <span class="">|</span>
                  <span class="text-gray-s_999 ml5 f12">
                  		<c:choose>
                   			<c:when test="${!empty reMap.position}">
                     				<yt:dict2Name nodeKey="p_position" key="${reMap.position}"></yt:dict2Name>
                   			</c:when>
                   			<c:otherwise>
                   			暂无位置	
                   			</c:otherwise>
                   		</c:choose>
                  </span>
                  <span class="">|</span>
                  <span class="text-gray-s_999 ml5 f12">
                  	<c:choose>
                  		<c:when test="${!empty reMap.player_num}">
		                  	${reMap.player_num}号
                  		</c:when>
                  		<c:otherwise>
                  			暂无号码
                  		</c:otherwise>
                  	</c:choose>
                  </span>
              </li>
              <li><span class="f12 text-gray-s_999 f12">
              			<c:choose>
              				<c:when test="${!empty reMap.team_name}">
              					${reMap.team_name}
              				</c:when>
              				<c:otherwise>
              					暂无球队
              				</c:otherwise>
              			</c:choose>
              	  </span>
              </li>
          </ol>
          <div class="clearit"></div>
      </div>
      <!--战斗力-->
      <div class="comat ml10">
          <ul>
              <li><span class="f12">身价&emsp;${reMap.current_price}<span class="ml5 text-gray-s_333">|</span></span> </li>
              <li><span class="f12">能力&emsp;${reMap.score}&emsp;认可&emsp;${reMap.accept}%</span></li>
          </ul>
      </div>
<script src="${ctx}/resources/js/own/msg.js"></script>
<script type="text/javascript">
function focus_user(dom, uid, type) {
	$.ajaxSec({
		type : 'POST',
		url : base + "/ifLogin",
		dataType : "JSON",
		success : function(data) {
			if (data.state == 'error') {
				layer.msg(data.message.error[0]);
			} else {
				var url = base + '/user/focus';
				if (type) {
					url = base + '/user/cancel';
				}
				var flag = $(dom).attr("flag");
				if (!flag) {
					$(dom).attr("flag", "1");
					$.ajaxSec({
						type : 'POST',
						url : url,
						data : {
							f_user_id : uid,
							f_type : 0
						},
						cache : false,
						dataType : 'json',
						success : function(result) {
							if (result.state == 'success') {
								if (type) {
									$(dom).text("关注");
									$(dom).attr(
											"onclick",
											"focus_user(this,'"
													+ uid + "')");
								} else {
									$(dom).text("已关注");
									$(dom).attr(
											"onclick",
											"focus_user(this,'"
													+ uid
													+ "',true)");
								}
								layer.msg(
										result.message.success[0],
										{
											icon : 1
										});
							} else {
								layer.msg('操作失败', {
									icon : 2
								});
							}
							$(dom).removeAttr("flag");
						},
						error : $.ajaxError
					});
				}
			}
		}
	});
}	
$(".card_details li").css({"margin-top":"0"});
</script>