<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void Logout_Click(object sender, DirectEventArgs e)
    {
        // Logout from Authenticated Session
        this.Response.Redirect("sysExit.aspx");
    }

</script>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title></title>

    <link href="css/desktop.css" rel="stylesheet" type="text/css" />

    <script>
        var tile = function () {
            Ext.net.Desktop.desktop.tileWindows();
        };

        var cascade = function () {
            Ext.net.Desktop.desktop.cascadeWindows();
        };

        var initSlidePanel = function () {
            this.setHeight(Ext.net.Desktop.desktop.body.getHeight());            

            if (!this.windowListen) {                
                this.windowListen = true;

                this.el.alignTo(Ext.net.Desktop.desktop.body, 'tl-tr', [0, 0]);                
                Ext.EventManager.onWindowResize(initSlidePanel, this);
            }
        };
    </script>
</head>
<body>
        <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx">
            <Listeners>
                <WindowResize Handler="Ext.net.Bus.publish('App.Desktop.ready');" Buffer="500" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Desktop ID="Desktop1" runat="server">            
            <Modules>
                <ext:DesktopModule ModuleID="notepad">
                    <Shortcut Name="记事本" IconCls="x-notepad-shortcut"  SortIndex="2" />                       
                    <Launcher Text="记事本" Icon="ApplicationForm" />
                    <Window>
                        <ext:Window runat="server"
                            Title="记事本"
                            Width="600"
                            Height="400"
                            Icon="ApplicationForm"
                            AnimCollapse="false"
                            Border="false"
                            HideMode="Offsets"
                            Layout="FitLayout"
                            CloseAction="Destroy">
                            <Items>
                                <ext:HtmlEditor runat="server" Text="在<u>这里</u>可以编辑<b>丰富</b>的<font color='red'>文字</font>效果，<br>赶紧<font size='3'>试</font>一试吧！">
                                </ext:HtmlEditor>
                            </Items>
                        </ext:Window>
                    </Window>
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="create-module">
                    <Shortcut Name="天气预报" IconCls="x-weather-shortcut" SortIndex="3">
                    </Shortcut>
                    <Launcher Text="天气预报" Icon="WeatherCloudy" />
                    <Window>
                        <ext:Window ID="Window1" runat="server"
                            Title="天气预报"
                            Width="300"
                            Height="180"
                            Icon="WeatherCloudy"
                            AnimCollapse="false"
                            Border="false"
                            HideMode="Offsets"
                            Layout="FitLayout"
                            CloseAction="Destroy" 
                            Html="<p><center><iframe src='http://m.weather.com.cn/m/pn12/weather.htm?id=101210101T' width='245' height='110' marginwidth='0' marginheight='0' hspace='0' vspace='0' frameborder='0' scrolling='no'></iframe></center>">
                        </ext:Window>
                    </Window>
                </ext:DesktopModule>
            </Modules>

            <DesktopConfig Wallpaper="images/wallpapers/desk2.jpg" ShortcutDragSelector="true">
                <ShortcutDefaults IconCls="x-default-shortcut" />
                <ContextMenu>
                    <ext:Menu runat="server">
                        <Items>
                            <ext:MenuItem runat="server" Text="变更设置" />
                            <ext:MenuSeparator runat="server" />
                            <ext:MenuItem runat="server" Text="平铺" Handler="tile" Icon="ApplicationTileVertical" />
                            <ext:MenuItem runat="server" Text="层叠" Handler="cascade" Icon="ApplicationCascade" />
                        </Items>
                    </ext:Menu>
                </ContextMenu>
               
            </DesktopConfig>

            <StartMenu Height="300" Header="False">
                <ToolConfig>
                    <ext:Toolbar runat="server" Width="100">
                        <Items>
                            <ext:Button runat="server" Text="设置" Icon="Cog" />
                            <ext:Button runat="server" Text="退出" Icon="Key">
                                <DirectEvents>
                                    <Click OnEvent="Logout_Click">
                                        <EventMask ShowMask="true" Msg="感谢您使用本系统，再见..." MinDelay="1000" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </ToolConfig>
            </StartMenu>

            <TaskBar TrayWidth="100">
                <QuickStart>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button runat="server" Handler="tile" Icon="ApplicationTileVertical">
                                <QTipCfg Text="平铺窗口" />
                            </ext:Button>

                            <ext:Button runat="server" Handler="cascade" Icon="ApplicationCascade">
                                <QTipCfg Text="层叠窗口" />
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </QuickStart>

                <Tray>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button ID="LangButton" runat="server" Text="EN" MenuArrow="false" Cls="x-bold-text" MenuAlign="br-tr">
                                <Menu>
                                    <ext:Menu runat="server">
                                        <Items>
                                            <ext:CheckMenuItem runat="server" Group="lang" Text="English" Checked="true" CheckHandler="function(item, checked) {checked && #{LangButton}.setText('EN');}" />
                                            <ext:CheckMenuItem runat="server" Group="lang" Text="Chinese" CheckHandler="function(item, checked) {checked && #{LangButton}.setText('CH');}" />
                                            <ext:MenuSeparator runat="server" />
                                            <ext:MenuItem runat="server" Text="Show the Language Bar" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:Button>
                            <ext:ToolbarFill runat="server" />
                        </Items>
                    </ext:Toolbar>
                </Tray>
            </TaskBar>
            <Listeners>
                <Ready BroadcastOnBus="App.Desktop.ready" />
            </Listeners>
        </ext:Desktop>
       

        <%--Modules from User controls--%>
     
</body>
</html>