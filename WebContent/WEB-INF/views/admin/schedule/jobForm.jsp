<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>系统管理</a></li>
		<li><a>任务管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="jobForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${scheduleJob.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">任务标志</span>
					<c:choose>
						<c:when test="${empty scheduleJob.job_name}">
							<input type="text" name="job_name" value="${scheduleJob.job_name}" valid="require len(1,50)" class="form-control">
						</c:when>
						<c:otherwise>
							<input type="text" name="job_name" value="${scheduleJob.job_name}" valid="require len(1,50)" class="form-control" readonly="readonly">
						</c:otherwise>
					</c:choose>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">任务分组</span>
					<yt:dictSelect name="job_group" nodeKey="job_group" value="${scheduleJob.job_group}" clazz="form-control" required="require"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">任务运行时间表达式 (秒 分 时 天 周 年)</span>
					<input type="text" placeholder="* * * * * ?" name="cron_expression" value="${scheduleJob.cron_expression}" valid="require len(1,60)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">任务描述</span>
					<input type="text" name="remark" value="${scheduleJob.remark}" valid="require len(1,200)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">实现类</span>
					<yt:dictSelect name="class_name" nodeKey="class_name" value="${scheduleJob.class_name}" clazz="form-control" required="require"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">任务状态</span>
					<yt:dictSelect name="job_status" nodeKey="job_status" value="${scheduleJob.job_status}" clazz="form-control" required="require"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">备注</span>
						CronTrigger配置格式:
						格式: [秒] [分] [小时] [日] [月] [周] [年]	
						通配符说明: <br/>
						* ：表示所有值. 例如:在分的字段上设置 "*",表示每一分钟都会触发。 <br/>
						? ：表示不指定值。使用的场景为不需要关心当前设置这个字段的值。例如:要在每月的10号触发一个操作，但不关心是周几，所以需要周位置的那个字段设置为"?" 具体设置为 0 0 0 10 * ? <br/>
						- ：表示区间。例如 在小时上设置 "10-12",表示 10,11,12点都会触发。 <br/>
						, ：表示指定多个值，例如在周字段上设置 "MON,WED,FRI" 表示周一，周三和周五触发 <br/>
						/ ：用于递增触发。如在秒上面设置"5/15" 表示从5秒开始，每增15秒触发(5,20,35,50)。 在月字段上设置'1/3'所示每月1号开始，每隔三天触发一次。 <br/>
						L ：表示最后的意思。在日字段设置上，表示当月的最后一天(依据当前月份，如果是二月还会依据是否是润年[leap]), 在周字段上表示星期六，相当于"7"或"SAT"。如果在"L"前加上数字，则表示该数据的最后一个。 <br/>
						
						例如在周字段上设置"6L"这样的格式,则表示“本月最后一个星期五" <br/>
						
						W ：表示离指定日期的最近那个工作日(周一至周五). 例如在日字段上设置"15W"，表示离每月15号最近的那个工作日触发。如果15号正好是周六，则找最近的周五(14号)触发, 如果15号是周未，则找最近的下周一(16号)触发.如果15号正好在工作日(周一至周五)，则就在该天触发。如果指定格式为 "1W",它则表示每月1号往后最近的工作日触发。如果1号正是周六，则将在3号下周一触发。(注，"W"前只能设置具体的数字,不允许区间"-"). <br/>
						
						'L'和 'W'可以一组合使用。如果在日字段上设置"LW",则表示在本月的最后一个工作日触发 <br/>
						
						 
						
						# ：序号(表示每月的第几周星期几)，例如在周字段上设置"6#3"表示在每月的第三个周星期六.注意如果指定"6#5",正好第五周没有星期六，则不会触发该配置(用在母亲节和父亲节再合适不过了) <br/>
						
						周字段的设置，若使用英文字母是不区分大小写的 MON 与mon相同. <br/>
						
						常用示例: <br/>
						
						格式: [秒] [分] [小时] [日] [月] [周] [年] <br/>
						
						0 0 12 * * ?           每天12点触发
						0 15 10 ? * *          每天10点15分触发
						0 15 10 * * ?          每天10点15分触发 
						0 15 10 * * ? *        每天10点15分触发 
						0 15 10 * * ? 2005     2005年每天10点15分触发
						0 * 14 * * ?           每天下午的 2点到2点59分每分触发
						0 0/5 14 * * ?         每天下午的 2点到2点59分(整点开始，每隔5分触发) 
						0 0/5 14,18 * * ?        每天下午的 18点到18点59分(整点开始，每隔5分触发)
						
						0 0-5 14 * * ?            每天下午的 2点到2点05分每分触发
						0 10,44 14 ? 3 WED        3月分每周三下午的 2点10分和2点44分触发
						0 15 10 ? * MON-FRI       从周一到周五每天上午的10点15分触发
						0 15 10 15 * ?            每月15号上午10点15分触发
						0 15 10 L * ?             每月最后一天的10点15分触发
						0 15 10 ? * 6L            每月最后一周的星期五的10点15分触发
						0 15 10 ? * 6L 2002-2005  从2002年到2005年每月最后一周的星期五的10点15分触发
						
						0 15 10 ? * 6#3           每月的第三周的星期五开始触发
						0 0 12 1/5 * ?            每月的第一个中午开始每隔5天触发一次
						0 11 11 11 11 ?           每年的11月11号 11点11分触发(光棍节)
				</div>	
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->

<script type="text/javascript">
</script>