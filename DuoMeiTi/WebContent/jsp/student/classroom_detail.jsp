<%@ include file="/jsp/base/taglib.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<layout:override name="main_content">
	<link href="/css/admin/classroom_detail.css" rel="stylesheet" />
	<script type='text/javascript' src="/js/student/classroom_detail.js"></script>
	<script type="text/javascript">
	window.onload = function () {
	    $('.form_date').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
	}
	</script>
	<div class="mycontent">
		<div class="row">
			<div class="col-lg-6 col-lg-offset-3 classbuilding">
				<span><s:property value="build_name"/>&nbsp;&nbsp;<s:property value="classroom.classroom_num"/></span>&nbsp;&nbsp;&nbsp;&nbsp;
				<span>负责人:</span>
				<span id="classroomid" style="visibility:hidden"><s:property value="classroom.id"/></span>
				<span class="director-span"><s:property value="repertory[0].classroom.principal.user.fullName"/></span>
			</div>
			</div>
		<hr>
		
		
		<div class="modal fade" id="check-record-modal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">填写周检查记录</h4>
					</div>
					<div class="modal-body">
						<textarea class="form-control" rows="3" id="checkdetail"></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="checkrecord_submit()">提交</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="repair-record-modal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">填写维修记录</h4>
					</div>
					<div class="modal-body">
						<div>设备：<span class="control-label" id="selectType"></span>&nbsp;&nbsp;&nbsp;&nbsp;资产编号：<span class="control-label" id="selectNum"></span></div>
						<textarea class="form-control" rows="3" id="repairdetail"></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="repairrecord_submit()">提交</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row col-lg-12">
				<div class="col-lg-7">
				<!-- <form action="#" method="post" id="addclassroomdevice"> -->
					<div class="form-group">
						<label for="zichanhao" style="float:left;vertical-align:middle;">添加设备:</label>						
						<input type="text" class="form-control" id="zichanhao" style="width:30%;float:left;margin-left:5%;" placeholder="请输入资产编号"></input>
						<!-- <button type="submit" class="btn btn-info btn-sm" style="margin-left:5%">查询</button> -->
						<button type="button" class="btn btn-primary btn-sm" style="margin-left:5%" onclick="add_classroomrt(<s:property value="#session.ret"/>)">添加</button>
						<button id="alterSearch" class="btn btn-primary btn-sm" style="margin-left:5%" onclick="alter_device()">备用设备</button>
					</div>
				<!-- </form> -->
				<script>
					function add_classroomrt() {
						var classroomid = <s:property value="classroom_id" />;
						var bh = $("#zichanhao").val();
						var href="<%=path%>/student/classroomDevice/add_action";
						$.ajax({
							url : href,
							type : 'post',
							dataType : 'json',
							data : {
								"id" : classroomid,
								"bh" : bh
							}, 
							success : addcallback
						});
					}
					
					function addcallback(data) {
						if (parseInt(data.ret))
							alert("Ok，添加成功");
						else
							alert("Sorry，添加失败");
					}
					function alter_device() {
						var classroomid = <s:property value="classroom_id" />;
						var href="<%=path%>/admin/classroomDevice/alter_action?classroomid="+classroomid;
						//document.getElementById("alterSearch").href=href;
						window.open(href,'myFrame1');
					}
					function closeWindow() {
						window.opener=null;
						window.open('','_self');
						window.close();
					}
				</script>
				</div>
<!-- 				<div class="col-lg-2">
					<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#schedule-modal">查看课表</button>
					<a type="button" data-toggle="modal" data-target="#schedule-modal" class="btn btn-primary btn-sm">查看课表</a>
					</div> -->
				<div class="col-lg-2" style="float:right;">
					<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#check-record-modal">填写周检查记录</button>
				</div>
			</div>
		</div>
		<div class="detail-div">
			<div class="device">
				<ul>
					<s:iterator value="repertory" var="device" status="i">
						<li id="device-<s:property value="#i.index"/>" />
							<div style="margin-bottom:5px">
								<label class="control-label device-type-label"><s:property value="#device.rtType"/>&nbsp;</label>
								<span>
									<button type="button" class="btn btn-primary btn-sm"  
									onclick="openRepairMoadl(<s:property value="#i.index"/>)">维修记录</button>
									<a href="<%=path%>/admin/classroomDevice/move2alter_action?m2alter=<s:property value="#device.rtId"/>&classroomId=<s:property value="classroom.id"/>" id="mtoalter" type="button" class="btn btn-primary btn-sm"  
									>移入备用</a>
								</span>
								<span style="visibility:hidden" class="device-id-span"><s:property value="#device.rtId"/></span>
								<span style="visibility:hidden" class="device-num-span"><s:property value="#device.rtNumber"/></span>
							</div>
							<table class="table device-table-bordered">
								<thead>
									<tr><td>资产编号</td><td>型号</td><td>名称</td><td>出厂号</td><td>出厂日期</td><td>审批日期</td></tr>
								</thead>
								<tbody>
									<tr><td><s:property value="#device.rtNumber"/></td>
										<td><s:property value="#device.rtVersion"/></td>
										<td><s:property value="#device.rtType"/></td>
										<td><s:property value="#device.rtFactorynum"/></td>
										<td><s:property value="#device.rtProdDate"/></td>
										<td><s:property value="#device.rtApprDate"/></td>
									</tr>
								</tbody>
							</table>
						</li>
					</s:iterator>
				</ul>
			</div>
			<div class="record">
				<ul>
					<li>
						<label class="control-label">周检查记录：</label>
						<table class="table device-table-bordered" id="checkrecord_table">
							<thead>
								<tr><td>检查人</td><td>教室状况</td><td>检查时间</td></tr>
							</thead>
							<tbody>
								<s:iterator value="checkrecords" var="checkrecord" status="i">
									<tr>
										<td width="20%"><s:property value="#checkrecord.checkman.username"/></td>
										<td><s:property value="#checkrecord.checkdetail"/></td>
										<td><s:property value="#checkrecord.checkdate"/></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</li>
					<li>
					<label class="control-label">维修记录：</label>
						<table class="table device-table-bordered" id="repairrecord_table">
							<thead>
								<tr><td>维修人</td><td>维修设备</td><td>维修情况</td><td>维修时间</td></tr>
							</thead>
							<tbody>
								<s:iterator value="repairrecords" var="repairrecord" status="i">
									<tr>
										<td width="20%"><s:property value="#repairrecord.repairman.username"/></td>
										<td><s:property value="#repairrecord.device.rtType"/></td>
										<td><s:property value="#repairrecord.repairdetail"/></td>
										<td><s:property value="#repairrecord.repairdate"/></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</li>
				</ul>
			</div>
		</div>
				<div id="alter_table">
			<!-- <button id="alterSearch" class="btn btn-primary btn-sm" style="margin-left:5%" onclick="alter_device()">备用设备</button> -->
			<!-- <a id="alterSearch" target="myFrame1" class="btn btn-primary btn-sm" style="margin-left:5%" onclick="alter_device()">备用设备</a> -->

			<iframe name="myFrame1" id="main" frameborder="0" scrolling="no" style="width:100%;" height="" ></iframe>
		</div>
	</div>
	
</layout:override>

<%@ include file="/jsp/student/base.jsp" %>