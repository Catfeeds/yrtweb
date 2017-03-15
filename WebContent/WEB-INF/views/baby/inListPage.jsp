<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>邀请入驻列表</title>
</head>
<body>
	<div>
		<table>
			<tr>
				<th>入驻俱乐部</th>
				<th>入驻天数</th>
				<th>联系人</th>
				<th>联系电话</th>
				<th>邀请时间</th>
				<th>备注</th>
				<th>操作</th>
			</tr>
			<tbody id="dataArea">
			
			</tbody>
		</table>
	</div>
 	<%@ include file="../common/footer.jsp" %>
 	<script type="text/javascript">
		$(function(){
			loadListPage(1);
		});
 	
		function loadListPage(currentPage){
			$.ajax({
				type:"POST",
				url:base+"/babyIn/listDatas?random="+Math.random(),
				data:{"currentPage":currentPage},
				dataType:"HTML",
				success:function(data){
					$("#dataArea").empty();
					$("#dataArea").html(data);
				}
			});
		}
 	</script>
</body>
</html>