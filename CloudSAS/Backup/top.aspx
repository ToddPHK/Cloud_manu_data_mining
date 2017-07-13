<%@ Page language="c#" Codebehind="top.aspx.cs" AutoEventWireup="True" Inherits="Gdshare.Admin.top" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<script language="JavaScript">
		function $(s){return document.getElementById(s);}
		function swap(s,a,b,c){$(s)[a]=$(s)[a]==b?c:b;}
		function hide(s){
					$(s).style.display=$(s).style.display=="none"?"":"none";
						}
		function resizeFrame(){
		if(parent.myFrameset.rows != '19,2*'){
		parent.document.getElementById('myFrameset').setAttribute('rows', '19,2*', 0);
		}else{
		parent.document.getElementById('myFrameset').setAttribute('rows', '107,2*', 0);
		}
		}
		</script>
		<title>top</title>
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="css/style.css" rel="stylesheet" type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language="javascript" src="js/windowstatus.js"></script>
		<script language="javascript">
	 window_status("云平台数据统计分析系统");
		</script>
	</HEAD>
	<body leftmargin="0" topmargin="0" MS_POSITIONING="GridLayout">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<form id="Form1" method="post" runat="server">
				<TBODY>
					<tr onClick="javascript:hide('content');swap('title','className','up','down');resizeFrame();">
						<td id="title" class="up" height="20" background="images/top_2.jpg">
							<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="7%"><img src="images/top_1.jpg" width="70" height="20"></td>
									<td width="83%">&nbsp;</td>
									<td width="14%"><img src="images/Copyright.jpg" width="119" height="20"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="content">
						<td height="79" background="images/bg-3.jpg">
							<table width="100%" height="79" border="0" cellpadding="0" cellspacing="0">
								<tr>
									
									<td><img src="images/top_left.jpg" width="386" height="89"></td>
									
									<td align="right" valign="middle"><img src="images/top_right.jpg" width="208" height="89"></td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 
					<tr>
						<td height="30" bgcolor="#e3ebf5"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="2%" align="center">&nbsp;</td>
									<td width="12%" height="25" align="center"><a href="left.aspx" target="left"><img src="images/top_7.jpg" width="90" height="23" border="0"></a></td>
									<td width="11%" align="center"><a href="sysExit.aspx" target="_top"><img src="images/top_8.jpg" width="96" height="22" border="0"></a></td>
									<td align="center" class="f12">尊敬的
										<asp:Label id="yhzcm" runat="server" ForeColor="Red"></asp:Label>
                ，欢迎您使用本系统	</td>
									<td width="26%"><img src="images/top_9.jpg" width="206" height="19" border="0" usemap="#Map"></td>
								</tr>
							</table>
						</td>
					</tr> 
					-->
			</form>
			</TBODY>
		</table>
		<map name="Map">
			<area shape="RECT" coords="55,1,95,17" href="javascript:history.go(-1);" target="right">
			<area shape="RECT" coords="104,0,148,21" href="javascript:history.go(1);" target="right">
			<area shape="RECT" coords="163,-2,202,18" href="#" onClick="parent.right.location.reload()">
			<area shape="RECT" coords="0,0,41,24" href="null.htm" target="right">
		</map>
	</body>
</HTML>
