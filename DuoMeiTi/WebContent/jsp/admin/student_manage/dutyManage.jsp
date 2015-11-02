<%@ include file="/jsp/base/taglib.jsp" %>

<layout:override name="mycontent">

<link rel="stylesheet" type="text/css" media="screen" href="/css/admin/dutyManage.css"/> 

<div class="dutyManage">
	<h3>选班开关</h3>
	<s:if test="chooseClassSwitch==false">
		<button type="button" class="btn btn-primary" id="chooseClassSwitch">选班功能已关闭</button>
	</s:if>
	<s:else>
		<button type="button" class="btn btn-warning" id="chooseClassSwitch">选班功能已打开</button>
	</s:else>
	<h3>值班表</h3>
	<div class="teachbuilding-droplist">
		<select class="form-control buildingSelect">
			<option value=0></option>
			<s:iterator value="teahBuildings" var="i" status="index" >
	  			<option value=<s:property value="#i.buildingId"/>><s:property value="#i.buildingName"/></option>
	  		</s:iterator>
	  	</select>

		<button type="button" class="btn btn-primary adjust-btn" statu=0>调整</button>
	</div>
	<br/>
	<div class="time-table hide">
		<table class="table table-bordered">
			<thead>
				<tr class="row">
					<th class="col-md-2">值班时间</th>
					<s:iterator value="{'一','二','三','四','五','六','日'}" var='week'>
						<th class="col-md-1.5"><span><s:property value='week'/></span></th>
					</s:iterator>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="{'7:40 ~~ 9:20','9:50 ~~ 11:30','13:15 ~~ 14:50','15:20 ~~ 17:00','17:45 ~~ 19:20'}" var="time" status="row">
					<tr class="row" row=<s:property value="#row.index+1"/>>
						<td class="col-md-2"><s:property value="time"/></td>
						<s:iterator value="{'','','','','','',''}" var="num" status="col">
							<td class="col-md-1.5 students" col=<s:property value="#col.index+1"/>><s:property value="num"/></td>
						</s:iterator>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</div>
	<div class="not-in-list">
	</div>
	
</div>

<script type='text/javascript' src="/js/admin/dutyManage.js"></script>
</layout:override>

<%@ include file="base.jsp" %>