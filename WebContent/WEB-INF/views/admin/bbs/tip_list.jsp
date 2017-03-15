<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">论坛管理</a></li>
		<li><a href="">论坛举报管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-content">
				<div class="row">
					 <div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>类型:  
								   <yt:dictSelect style="width:180px;height:25px;" clazz="ml10" name="type" nodeKey="t_tip_type" value="${params.type}"></yt:dictSelect>
								</label>
								<label>处理状态: 
									<select id="status" name="status">
										<option value="">全部</option>	
										<option value="2">未处理</option>
										<option value="1">已处理</option>
									</select>
									<script type="text/javascript">$("#status").val('${params.status}');</script>
							    </label>
								<a onclick="ListPage.search()" class="btn btn-success">
									<i class="fa">查询</i>                                     
								</a>
								<a onclick="ListPage.resetSearch()" class="btn">
									<i class="fa">重置</i>                                        
								</a>
							</div>
						</form>
					</div> 
				</div>
				<!-- <hr style="margin:2px;height:1px"> -->
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th style="width: 6%;text-align: center;">编号</th>
							  <th style="width: 8%;text-align: center;">类型</th>
							  <th style="text-align: center;width: 18%;">举报人</th>
							  <th style="text-align: center;width: 18%;">举报日期</th>
							  <th style="text-align: center;width: 6%;">处理状态</th>
							  <th style="text-align: center;width: 6%;">处理时间</th>
							  <th style="text-align: center;width: 23%;">操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  <c:forEach items="${page.items}" var="tip" varStatus="index">
					      <tr>
						  	  <td style="text-align: center;line-height: 38px;">${index.index+1 }</td>
						  	  <td style="text-align: center;line-height: 38px;">
						  	     <yt:dict2Name nodeKey="t_tip_type" key="${tip.type }"></yt:dict2Name>
						  	  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		       <yt:id2NameDB beanId="userService" id="${tip.user_id}" clazz="f12"></yt:id2NameDB>
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		      <fmt:formatDate value="${tip.create_time}" pattern="yyyy-MM-dd"/>
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		      <c:choose>
					  		          <c:when test="${tip.status == 2}">
					  		                                                     未处理
					  		          </c:when>
					  		          <c:otherwise>
					  		                                                    已处理
					  		          </c:otherwise>
					  		      </c:choose>
					  		       
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		      <fmt:formatDate value="${tip.deal_time}" pattern="yyyy-MM-dd"/>
					  		  </td>
					  		  <td style="text-align: center;">
					  		    <input type="button" name="notice" class="btn btn-info" style="margin-top: 4px;" value="查看详情" onclick="ListPage.form('${ctx}/admin/bbs/getBbsTipById','#tipForm','${ctx}/admin/bbs/updateBbsTipStatus','${tip.id}')""/>
					  		  </td>
					  	  </tr>
					  </c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<div class="feedback" style="display: none;">
    <div class="fe_title">
        <div class="closeBtn_1"></div>
        <span class="f20 ms text-white">意见反馈</span>
    </div>
    <div class="fromlist">
    	<form id="feedBackForm">
        <table>
            <tr>
                <td class="l"><span class="f14">姓&emsp;&emsp;名</span></td>
                <td class="r"><input type="text" name="name" value="" valid="require" class="w300 ml10" /></td>
            </tr>
            <tr>
                <td class="l"><span class="f14">联系电话</span></td>
                <td class="r"><input type="text" name="phone" value="" valid="require mobile" class="w300 ml10" /></td>
            </tr>
            <tr>
                <td class="l"><span class="f14">邮箱地址</span></td>
                <td class="r"><input type="text" name="email" value="" class="w300 ml10" /></td>
            </tr>
            <tr>
                <td class="l" valign="top"><span class="f14">反馈意见</span></td>
                <td class="r">
                    <textarea name="content" valid="require"></textarea>
                </td>
            </tr>
            <tr>
                <td class="l"><span class="f14">上传图片</span></td>
                <td class="r">
                    <div id="feedBackphoto" valid="requireUpload" class="ml10"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="button" name="name" value="提交" onclick="submitFeedback()"  class="submit mt35 ms" />
                </td>
            </tr>
        </table>
        </form>
    </div>
</div>
<script type="text/javascript">
var iframeTeamInfo;
function showTipDetails(id){
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/interface/dialog?dom_id='+dom_id+'&dom_name='+dom_name+'&league_id='+league_id+"&group_id="+group_id //iframe的url
	}); 
}


function select_team_info(dom_id,dom_name){
	var league_id = $("#league_id").val();
	var group_id = $("#group_sel").val();
	
}
</script>
