<%@ Page language="c#" Codebehind="Index.aspx.cs" AutoEventWireup="True" Inherits="CloudSAS.WebForm1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<script runat="server">    
    private object TestData
    {
        get
        {
            return new object[]
            {
                new object[] { "BJ", "北京", " " },
                new object[] { "TJ", "天津", " " },
                new object[] { "HB", "河北", " " },
                new object[] { "SX", "山西", " " },
                new object[] { "NMG", "内蒙古", " " },
                new object[] { "LN", "辽宁", " " },
                new object[] { "JL", "吉林", " " },
                new object[] { "HLJ", "黑龙江", " " },
                new object[] { "SH", "上海", " " },
                new object[] { "JS", "江苏", " " },
                new object[] { "ZJ", "浙江", " " },
                new object[] { "AH", "安徽", " " },
                new object[] { "FJ", "福建", " " },
                new object[] { "JX", "江西", " " },
                new object[] { "SD", "山东", " " },
                new object[] { "HN", "河南", " " },
                new object[] { "HB", "湖北", " " },
                new object[] { "HN", "湖南", " " },
                new object[] { "GD", "广东", " " },
                new object[] { "GX", "广西", " " },
                new object[] { "HN", "海南", " " },
                new object[] { "CQ", "重庆", " " },
                new object[] { "SC", "四川", " " },
                new object[] { "GZ", "贵州", " " },
                new object[] { "YN", "云南", " " },
                new object[] { "XZ", "西藏", " " },
                new object[] { "SX", "陕西", " " },
                new object[] { "GS", "甘肃", " " },
                new object[] { "QH", "青海", " " },
                new object[] { "NX", "宁夏", " " },
                new object[] { "XJ", "新疆", " " },
                new object[] { "XG", "香港", " " },
                new object[] { "AM", "澳门", " " },
                new object[] { "TW", "台湾", " " }                 
            };
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
　　 <script type="text/javascript">
　　     function SubmitKeyClick(e) {
         var key = e.keyCode;
　　         if (key == 13) {
　　             key = 9;
             e.returnValue = false;
             document.getElementById("Button4").click(); 
             }
　　     }
   </script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>

<script type="text/javascript">
    if (top.location != self.location)
        top.location = self.location;

    function CheckIn() {
        //得到用户名和密码
        var names = document.getElementById("UserName").value;
        var pass = document.getElementById("Pwd").value;

        //验证用户名和密码是否为空
        if (names == "" && pass=="") {
            alert("请输入用户名和密码");
            document.getElementById("UserName").focus();
            return false;
        }

        //验证用户名是否为空
        if (names == "") {
            alert("请输入用户名");
            document.getElementById("UserName").focus();
            return false;
        }
        //验证用户密码是否为空
        else if (pass == "") {
            alert("请输入密码");
            document.getElementById("Pwd").focus();
            return false;
        }
    }
</script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.fullbg.min.js"></script>
<style type="text/css">
.fullBg {
	position: fixed;
	top: 0;
	left: 0;
	overflow: hidden;
        }
.hidden {
    visibility:hidden    
}

#maincontent {
	position: absolute;
	top: 150px;
	left: 0;
	z-index: 50;
	width: 100%;
	background: #fff;
	opacity: 0.8; 
	filter: alpha(opacity=90);
	}

#box {
	width: 600px;
	margin: auto;
	padding: 0 10px;
	}

</style>
</head>


<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" 
        LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx">
            <CustomDirectEvents>
                <ext:DirectEvent Target="Button4" OnEvent="Button1_Click">
                <EventMask ShowMask="true" Msg="验证中，请稍后..." />
                </ext:DirectEvent>
            </CustomDirectEvents>
    </ext:ResourceManager>
<img src="images/bg_demo2.jpg" alt="" id="background" />
		<script type="text/javascript" src="js/windowstatus.js"></script>
		<script type="text/javascript">
		 window_status("云平台数据统计分析系统");
		</script>

<div id="maincontent">
    <div id="box" align="center">
        <form id="Form1" method="post" runat="server">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" 
                align="center">
				<tbody align="center">
				<tr>
					<td align="center" class="f12" style="text-align:center"><table width="655" height="369" border="0" align="center"  cellpadding="0" cellspacing="1" style="margin:auto;"
							>
							<tr>
								<td background="images/indexbg.png" align="center">
									<TABLE height="75" cellPadding="0" width="345" align="center" border="0">
										<TBODY>
											<TR class="f12">
												<TD width="78" align="center">&nbsp;</TD>
												<TD width="75" height="28" align="center">用户</TD>
												<TD width="184">&nbsp;                              
                                                <INPUT type="text" name="UserName" id="UserName" runat="server" onkeydown="SubmitKeyClick(event)" value="">
                                                </TD>
											</TR>
											<TR class="f12">
												<TD align="center">&nbsp;</TD>
												<TD height="19" align="center">密码</TD>
												<TD>&nbsp; 
                                                <INPUT id="Pwd" type="password" value="" onkeydown="SubmitKeyClick(event)" name="Pwd"">
												</TD>
											</TR>                                            
											<TR class="f12">
												<TD>&nbsp;</TD>
												<TD height="20">&nbsp;</TD>
												<TD height="20">&nbsp;
                                                <ext:Toolbar ID="Toolbar1" runat="server" Width="173px">
                                                    <Items>
													<ext:button ID="Button1" runat="server" Type="Submit" Text="登录" 
                                                         Cls="submit" Icon="User">
                                                    <DirectEvents>
                                                        <Click OnEvent="Button1_Click">
                                                            <EventMask ShowMask="true" Msg="验证中，请稍后..." />
                                                        </Click>
                                                    </DirectEvents>
                                                    </ext:button>
                                                    <ext:Button ID="Button2" Type="reset" runat="server" Text="重写" OnClientClick="clear()" Icon="Reload">                                                 
                                                    </ext:Button>                        
                                                    <ext:Button ID="Button3" Type="Button" runat="server" Text="注册" Icon="New">
                                                                    <Listeners>
                                                                        <Click Handler="#{Window1}.show()" />
                                                                    </Listeners>                                                 
                                                    </ext:Button>                                                       
                                                    </Items>
                                                 </ext:Toolbar>	
                                                 <!-- 这是一个隐藏的Button，用来触发Button1_Click事件 -->
                                                 <asp:Button ID="Button4" runat="server" Text="Button" Visible="true"  CssClass="hidden" />	                                         	
                                                </TD>
											</TR>
										</TBODY>
									</TABLE>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <ext:Window 
            ID="Window1" 
            runat="server" 
            Icon="House" 
            Title="注册新用户" 
            Hidden="true"
            X="510"
            Y="280" Width="400" BodyPadding="13">
                <Items>
                    <ext:FieldSet ID="FieldSet1" runat="server" Title="用户信息" DefaultWidth="300">
                        <Items>
                            <ext:TextField ID="TextField1" 
                                runat="server" 
                                AllowBlank="false"
                                FieldLabel="用户名"
                                Name="user"
                               />

                            <ext:TextField ID="TextField2" 
                                runat="server" 
                                AllowBlank="false"
                                FieldLabel="密码"
                                Name="pass"                              
                                InputType="password" />

                            <ext:TextField ID="TextField3" 
                                runat="server" 
                                AllowBlank="false"
                                FieldLabel="确认密码"
                                Name="pass"                  
                                InputType="password" />

                        </Items>
                    </ext:FieldSet>

                    <ext:FieldSet ID="FieldSet2" runat="server" Title="联系信息" DefaultWidth="300">
                        <Items>
                            <ext:TextField ID="TextField4" 
                                runat="server" 
                                FieldLabel="姓名"
                                Name="first"
                                 />

                            <ext:TextField ID="TextField5" 
                                runat="server" 
                                FieldLabel="Email"
                                Name="email"
                                Vtype="email" />

                            <ext:ComboBox ID="ComboBox1" 
                                runat="server"
                                FieldLabel="省份"
                                Name="state"
                                DisplayField="name"
                                ValueField="abbr"
                                QueryMode="Local"               
                                TypeAhead="true"
                                EmptyText="选择省份...">
                                <Store>
                                    <ext:Store ID="Store1" runat="server" Data="<%# TestData %>" AutoDataBind="true">
                                        <Model>
                                            <ext:Model ID="Model1" runat="server">
                                                <Fields>
                                                    <ext:ModelField Name="abbr" />
                                                    <ext:ModelField Name="name" />
                                                    <ext:ModelField Name="slogan" />
                                                </Fields>
                                            </ext:Model>
                                        </Model>

                                        <Reader>
                                            <ext:ArrayReader />    
                                        </Reader>
                                    </ext:Store>
                                </Store>
                            </ext:ComboBox>

                            <ext:DateField ID="DateField1" 
                                runat="server"
                                FieldLabel="生日"
                                Name="dob"
                                AllowBlank="false"
                                MaxDate="<%# DateTime.Today %>"
                                AutoDataBind="true" />
                        </Items>
                    </ext:FieldSet>

                </Items>

                <Buttons>
                    <ext:Button ID="Button5" 
                        runat="server" 
                        Text="确认注册" 
                        Disabled="true" 
                        FormBind="true" />
                </Buttons>
            </ext:Window>            
		</form>
    </div>
</div>
<script type="text/javascript">
    function clear() {
        document.Form1.UserName.value = "";
        document.Form1.Pwd.value = "";
    }
		function clear_F()
		{
		  document.Form1.UserName.value="";
		}
		function clear_M()
		{
		  document.Form1.Pwd.value="";
		}
</script>
<script type="text/javascript">
$(window).load(function() {
	$("#background").fullBg();
});
</script>
</body>
</html>





