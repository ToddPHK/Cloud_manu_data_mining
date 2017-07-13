<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="userMgr.aspx.cs"
    Inherits="CloudSAS.userMgr" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
 
    <script type="text/javascript">

        var submitValue = function (grid, hiddenFormat, format) {
            hiddenFormat.setValue(format);
            grid.submitData(false, { isUpload: true });
        };


        var GetRoleName = function (value) {
            switch (value) {
                //index = S_Roles.find("roleid", value, 0, false, false);            
                //return S_Roles.getAt(index).get('rolename');            
                case 1:
                    roleName = "管理员";
                    break;
                case 2:
                    roleName = "企业用户";
                    break;
                case 3:
                    roleName = "个人用户";
                    break;
                default:
                    roleName = "其它";
            }
            return roleName;
        } 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />
    <ext:Hidden ID="FormatType" runat="server" />
    <ext:Store runat="server" ID="S_Roles" OnRefreshData="GetAllRoles" AutoLoad="true">
        <Proxy>
            <ext:PageProxy>
                <Reader>
                    <ext:JsonReader IDProperty="roleid" />
                </Reader>
            </ext:PageProxy>
        </Proxy>
        <Model>
            <ext:Model runat="server">
                <Fields>
                    <ext:ModelField Name="roleid" />
                    <ext:ModelField Name="rolename" />
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cboRole}.setValue(#{S_Roles}.getAt(0).get('roleid'));" />
        </Listeners>
    </ext:Store>
    <ext:Viewport ID="Viewport1" runat="server" Layout="FitLayout">
        <Items>
            <ext:GridPanel ID="GridPanel1" Layout="fit" TrackMouseOver="true" runat="server"
                Header="false" Border="false" Collapsible="true">
                <Store>
                    <ext:Store ID="Store1" runat="server" OnReadData="MyData_Refresh" PageSize="15"  OnSubmitData="Store1_Submit">
                        <Model>
                            <ext:Model runat="server" IDProperty="userid">
                                <Fields>
                                    <ext:ModelField Name="userid" />
                                    <ext:ModelField Name="username" />
                                    <ext:ModelField Name="password" />
                                    <ext:ModelField Name="roleid" />
                                    <ext:ModelField Name="telephone" />
                                    <ext:ModelField Name="address" />
                                    <ext:ModelField Name="email" />
                                    <ext:ModelField Name="logintime" />
                                    <ext:ModelField Name="createtime" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
                <TopBar>
                    <ext:Toolbar ID="Toolbar1" runat="server">
                        <Items>
                            <ext:Button ID="Button1" runat="server" Text="添加" Icon="Add">
                                <Listeners>
                                    <Click Handler="#{WinUser}.show();#{RegistForm}.getForm().reset();#{cboRole}.setValue(#{cboRole}.store.getAt(0).get('roleid'));#{Hid}.setValue('');" />
                                </Listeners>
                            </ext:Button>
                            <ext:Button ID="BtnDel" runat="server" Text="删除" Icon="Delete">
                                <DirectEvents>
                                    <Click OnEvent="BtnDel_Click">
                                        <Confirmation ConfirmRequest="true" Title="确认" Message="确实要删除吗?" />
                                        <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                    </Click>
                                </DirectEvents>
                                <Listeners>
                                    <Click Handler="if(#{GridPanel1}.getSelectionModel().getCount()<=0) {TellAlert('请选择要删除的记录');return false;}" />
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                            <ext:Button ID="Button2" runat="server" Text="To XML" Icon="PageCode">
                                <Listeners>
                                    <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'xml');" />
                                </Listeners>
                            </ext:Button>
                            <ext:Button ID="Button3" runat="server" Text="To Excel" Icon="PageExcel">
                                <Listeners>
                                    <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'xls');" />
                                </Listeners>
                            </ext:Button>
                            <ext:Button ID="Button4" runat="server" Text="To CSV" Icon="PageAttach">
                                <Listeners>
                                    <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'csv');" />
                                </Listeners>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <ColumnModel ID="ColumnModel1" runat="server">
                    <Columns>
                        <ext:RowNumbererColumn Width="25" runat="server" />
                        <ext:Column Header="用户ID" Sortable="true" Hidden="true" DataIndex="userid" runat="server" />
                        <ext:Column Header="用户名" Sortable="true" DataIndex="username" runat="server" />
                        <ext:Column Header="电话" Sortable="true" DataIndex="telephone" runat="server" />
                        <ext:Column Header="地址" Sortable="true" DataIndex="address" runat="server" />
                        <ext:Column Header="邮箱" Sortable="true" DataIndex="email" runat="server" />
                        <ext:Column Header="最后登录" Sortable="true" DataIndex="logintime" runat="server" />
                        <ext:Column Header="创建时间" Sortable="true" DataIndex="createtime" runat="server" />
                        <ext:Column Header="角色" Sortable="true" DataIndex="roleid" runat="server">
                            <Renderer Fn="GetRoleName" />
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:CheckboxSelectionModel ID="CheckBoxGrid" runat="server" />
                </SelectionModel>
                <BottomBar>
                    <ext:PagingToolbar ID="PagingToolBar1" StoreID="Store1" PageSize="15" runat="server">
                        <Items>
                            <ext:Label ID="Label1" runat="server" Text="Page size:" />
                            <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                            <ext:ComboBox ID="ComboBox1" runat="server" Width="80">
                                <Items>
                                    <ext:ListItem Text="10" />
                                    <ext:ListItem Text="15" />
                                    <ext:ListItem Text="20" />
                                </Items>
                                <SelectedItems>
                                    <ext:ListItem Value="15" />
                                </SelectedItems>
                                <Listeners>
                                    <Select Handler="#{GridPanel1}.store.pageSize = parseInt(this.getValue(), 10); #{GridPanel1}.store.reload();" />
                                </Listeners>
                            </ext:ComboBox>
                        </Items>
                        <Plugins>
                            <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                        </Plugins>
                    </ext:PagingToolbar>
                </BottomBar>
            </ext:GridPanel>
        </Items>
    </ext:Viewport>
    <ext:Window ID="WinUser" Collapsible="true" Hidden="true" Modal="true" TitleCollapse="true"
        Maximizable="false" runat="server" Title="添加用户" Icon="User" Width="500" AutoHeight="true"
        Resizable="true">
        <Items>
            <ext:Hidden ID="Hid" runat="server">
            </ext:Hidden>
            <ext:FormPanel ID="RegistForm" LabelWidth="50" Frame="true" runat="server" Border="false"
                Height="100" ButtonAlign="Right"  Layout="Column" Header="False">
                <Items>
                    <ext:Panel ID="Panel1" runat="server" Border="false" Header="false" ColumnWidth=".5"
                        Layout="Form">
                        <Items>
                            <ext:TextField ID="TxtUserName" AnchorHorizontal="92%" runat="server" AllowBlank="false"
                                EmptyText="该项不可为空" FieldLabel="用户名" />
                            <ext:TextField ID="TxtTel" AnchorHorizontal="92%" runat="server" AllowBlank="false"
                                EmptyText="该项不可为空" FieldLabel="电话" />
                            <ext:TextField ID="TxtAddress" AnchorHorizontal="92%" runat="server" AllowBlank="false"
                                EmptyText="该项不可为空" FieldLabel="地址" />
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="Panel2" runat="server" Border="false" Header="false" ColumnWidth=".5"
                        Layout="Form">
                        <Items>
                            <ext:TextField ID="TxtEmail" AnchorHorizontal="92%" runat="server" AllowBlank="false"
                                EmptyText="该项不可为空" FieldLabel="邮箱" Vtype="email" />
                            <ext:ComboBox ID="cboRole" AnchorHorizontal="92%" StoreID="S_Roles" runat="server"
                                FieldLabel="角色" TypeAhead="true" Editable="false" ForceSelection="true" DisplayField="rolename"
                                ValueField="roleid">
                            </ext:ComboBox>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:FormPanel>
        </Items>
        <Buttons>
            <ext:Button Text="提交" ID="BtnSave" runat="server" Icon="Disk">
                <DirectEvents>
                    <Click OnEvent="BtnSave_Click">
                        <EventMask ShowMask="true" Msg="正在提交，请等候 ..." />
                    </Click>
                </DirectEvents>
                <Listeners>
                    <Click Handler="if (#{RegistForm}.getForm().isValid()) {;}else{Ext.Msg.show({icon: Ext.MessageBox.ERROR, msg: '您填写的信息不正确，请您确认！', buttons:Ext.Msg.OK});return false;}" />
                </Listeners>
            </ext:Button>
            <ext:Button Text="取消" ID="Button6" runat="server" Icon="Delete">
                <Listeners>
                    <Click Handler="#{WinUser}.hide();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
    </form>
</body>
</html>
