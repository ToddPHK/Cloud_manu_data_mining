<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="backMgr.aspx.cs"
    Inherits="CloudSAS.backMgr" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<script runat="server">
    [DirectMethod]
    public void DoYes()
    {
        Session.Clear();
        //Response.Write("<script>self.parent.location.href='sysExit.aspx';</" + "script>"); 
        //Response.Write("<script type='text/javascript' language='javascript'> alert('Test');window.location.href = 'sysExit.aspx';</" + "script>");
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", "<script type='text/javascript' language='javascript'> alert('Test');window.location.href = 'sysExit.aspx';</" + "script>", true); 
        Response.Redirect("sysExit.aspx");
    }

    [DirectMethod]
    public string GetThemeUrl(string theme, bool reload)
    {
        Theme temp = (Theme)Enum.Parse(typeof(Theme), theme);

        this.Session["Ext.Net.Theme"] = temp;

        if (reload)
        {
            this.Session["clearTheme"] = false;
            X.Redirect(this.Request.RawUrl);
            return "";
        }

        return this.ResourceManager1.GetThemeUrl(temp);
    }
	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>云平台数据统计分析系统</title>
    <link href="css/icon.css" rel="stylesheet" type="text/css" />
    <script src="js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        function redirec() {
            window.location.href = "sysExit.aspx";
        }
    </script>
    <script type="text/javascript">
        var loadPage = function (tabPanel, record) {
            var tab = tabPanel.getComponent(record.getId());

            //if (record.getId() == "145") {
            if (record.data.text == "退出系统") {
                document.getElementById("Button2").click();
                return;
            }
            if (!tab) {
                tab = tabPanel.add({
                    id: record.getId(),
                    title: record.data.text,
                    closable: true,
                    loader: {
                        url: record.data.href,
                        renderer: "frame",
                        loadMask: {
                            showMask: true,
                            msg: "Loading " + record.data.href + "..."
                        }
                    },
                    autoScroll: true
                });
            }

            tabPanel.setActiveTab(tab);
        };
    </script>
    <style type="text/css">
        .hidden
        {
            visibility: hidden;
        }
    </style>
</head>
<body style="background: #93B0CC  url(/View/images/loading32.gif)  no-repeat center center;">
    <form id="form1" runat="server">
    <asp:Button ID="Button2" runat="server" Text="Button" CssClass="hidden" />
    <ext:ResourceManager ID="ResourceManager1" runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx">
        <CustomDirectEvents>
            <ext:DirectEvent Target="Button2" OnEvent="Button2_Click">
                <EventMask ShowMask="true" Msg="载入中，请稍后..." />
            </ext:DirectEvent>
        </CustomDirectEvents>
    </ext:ResourceManager>
    <ext:History ID="History1" runat="server">
        <Listeners>
            <Change Fn="change" />
        </Listeners>
    </ext:History>
    <ext:Viewport ID="Viewport1" runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel ID="WestPanel" runat="server" Region="West" Title="系统导航" Width="200" Layout="Accordion"
                Collapsible="true" Split="true" Margins="0 0 4 0" Border="false">
                <HeaderConfig>
                    <Items>
                        <ext:Button ID="Button1" runat="server" Icon="Cog" ToolTip="选项" MenuArrow="False"
                            Flat="True">
                            <Menu>
                                <ext:Menu ID="Menu2" runat="server">
                                    <Items>
                                        <ext:MenuItem ID="MenuItem1" runat="server" Text="全部展开" IconCls="icon-expand-all">
                                            <Listeners>
                                                <Click Handler="#{exampleTree}.expandAll(false);" />
                                            </Listeners>
                                        </ext:MenuItem>
                                        <ext:MenuItem ID="MenuItem2" runat="server" Text="全部折叠" IconCls="icon-collapse-all">
                                            <Listeners>
                                                <Click Handler="#{exampleTree}.collapseAll(false);" />
                                            </Listeners>
                                        </ext:MenuItem>
                                        <ext:MenuSeparator ID="MenuSeparator" runat="server" />
                                        <ext:MenuItem runat="server" Text="主题" Icon="Paintcan">
                                            <Menu>
                                                <ext:Menu ID="Menu1" runat="server">
                                                    <Items>
                                                        <ext:CheckMenuItem ID="DefaultThemeItem" runat="server" Text="Default" Group="theme" />
                                                        <ext:CheckMenuItem ID="GrayThemeItem" runat="server" Text="Gray" Group="theme" Checked="true" />
                                                        <ext:CheckMenuItem ID="AccessThemeItem" runat="server" Text="Access" Group="theme" />
                                                        <ext:CheckMenuItem ID="NeptuneThemeItem" runat="server" Text="Neptune" Group="theme" />
                                                    </Items>
                                                    <Listeners>
                                                        <Click Fn="themeChange" />
                                                    </Listeners>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:MenuItem>
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>
                    </Items>
                    <Listeners>
                        <BeforeRender Handler="this.insert(0, this.titleCmp);" />
                    </Listeners>
                </HeaderConfig>
                <Items>
                    <ext:TreePanel ID="exampleTree" runat="server" Title="功能菜单" AnimCollapse="true" AutoScroll="false"
                        Lines="True" ContainerScroll="false" RootVisible="false" AutoHeight="true" HideParent="True"
                        Border="false">
                        <Store>
                            <ext:TreeStore runat="server" OnReadData="NodeLoad">
                                <Proxy>
                                    <ext:PageProxy />
                                </Proxy>
                            </ext:TreeStore>
                        </Store>
                        <Root>
                            <ext:Node NodeID="root" Text="Root" />
                        </Root>
                        <Listeners>
                            <ItemClick Handler="if (record.data.href) { e.stopEvent(); loadPage(#{CenterPanel}, record); }" />
                        </Listeners>
                    </ext:TreePanel>
                    <ext:Panel ID="Settings" runat="server" Title="自定义功能" AnimCollapse="true" Border="false"
                        BodyStyle="padding:16px;" Html="<b>您可在此添加自定义功能，或直接删除</b>" />
                </Items>
            </ext:Panel>
            <ext:TabPanel ID="CenterPanel" ActiveTabIndex="0" runat="server" Region="Center"
                Margins="0 0 4 0" EnableTabScroll="true">
                <Items>
                    <ext:Panel ID="Home" runat="server" Title="系统桌面" Icon="House" Closable="true" HideMode="Offsets">
                        <Loader ID="Loader1" runat="server" Mode="Frame" Url="Desktop.aspx">
                            <LoadMask ShowMask="true" />
                        </Loader>
                    </ext:Panel>
                </Items>
                <Listeners>
                    <TabChange Fn="addToken" />
                </Listeners>
                <Plugins>
                    <ext:TabCloseMenu runat="server" CloseAllTabsText="关闭所有" 
                        CloseTabText="关闭" CloseOthersTabsText="关闭其它" />
                </Plugins>
            </ext:TabPanel>
        </Items>
    </ext:Viewport>   
    </form>
</body>
</html>
