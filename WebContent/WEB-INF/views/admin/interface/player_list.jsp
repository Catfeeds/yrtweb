<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<!-- <span onclick="select_eventrecord()" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 确认选择</span> -->
				</h2>
			</div>
			<div class="box-content">
				<table id="eventrecord_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>球衣号码</th>
							  <th>姓名</th>
							  <th>所在俱乐部</th>
							  <th>对阵俱乐部</th>
							  <th>场上位置</th>
							  <th>参赛时长</th>
							  <th>进球</th>
							  <th>射门</th>
							  <th>射正</th>
							  <th>射偏</th>
							  <th>助攻</th>
							  <th>抢断</th>
							  <th>解围</th>
							  <th>补救</th>
							  <th>犯规</th>
							  <th>红牌</th>
							  <th>黄牌</th>
							  <th>住/客</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${list}" var="data">
						<tr>
							<td>${data.number}</td>
							<td>${data.name}</td>
							<td>${data.tmname}</td>
							<td>${data.tgname}</td>
							<td><yt:dict2Name nodeKey="p_position" key="${data.position}"></yt:dict2Name></td>
							<td>${data.durtime}</td>
							<td>${data.jinqiu_num}</td>
							<td>${data.shemen_num}</td>
							<td>${data.shezheng_num}</td>
							<td>${data.shepian_num}</td>
							<td>${data.zhugong_num}</td>
							<td>${data.qiangduan_num}</td>
							<td>${data.jiewei_num}</td>
							<td>${data.pujiu_num}</td>
							<td>${data.fangui_num}</td>
							<td>${data.hongpai_num}</td>
							<td>${data.huangpai_num}</td>
							<td>
							<c:if test="${data.team_status eq '1'}">主队</c:if>
							<c:if test="${data.team_status eq '2'}">客队</c:if>
							</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
