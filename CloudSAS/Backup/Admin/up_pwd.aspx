<%@ Page language="c#" Codebehind="up_pwd.aspx.cs" AutoEventWireup="True" Inherits="CloudSAS.Admin.up_pwd" %>
<HTML>
	<HEAD>
		<title>up_pwd</title>
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<link href="../css/style.css" rel="stylesheet" type="text/css">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<!-- 
        <table height="26" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td class="sbx" align="center" width="127" bgColor="#87bae0" height="26"><font class="white">[
						<A href="javascript:history.back(-1);">返回操作</A> ] </font>
				</td>
				<td width="639">&nbsp;</td>
			</tr>
		</table>
         -->
		<form id="Form1" method="post" runat="server">
			<table height="80" cellSpacing="1" cellPadding="0" width="736" bgColor="#2c8ed8" border="0"
				style="WIDTH: 736px; HEIGHT: 80px">
				<tr>
					<td class="f12" style="HEIGHT: 24px" align="center" width="138" bgColor="#cce4f7">用户</td>
					<td style="HEIGHT: 24px" width="517" bgColor="#e6f2fb"><FONT face="宋体">
							<asp:TextBox id="UserID" runat="server" ReadOnly="True"></asp:TextBox>
						</FONT>
					</td>
				</tr>
				<TR>
					<TD class="f12" style="HEIGHT: 24px" align="center" bgColor="#cce4f7">新密码：</TD>
					<TD style="HEIGHT: 24px" bgColor="#e6f2fb">
						<asp:TextBox id="New_Pwd" runat="server" TextMode="Password"></asp:TextBox></TD>
				</TR>
				<TR bgColor="#e6f2fb">
					<TD align="center" colSpan="2">
                        <asp:button id="Submit1" runat="server" type="submit" name="Submit2" onclick="Submit1_ServerClick" Text="提交" CssClass="submit"></asp:button>
						<INPUT class="submit" type="reset" value="重置" name="Submit">
					</TD>
				</TR>
			</table>
		</form>
		<asp:Label id="ShowMsg" style="Z-INDEX: 101; LEFT: 168px; POSITION: absolute; TOP: 176px" runat="server"
			Height="24px" Width="224px" ForeColor="Red"></asp:Label>
	</body>
</HTML>
