<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="privilegeMgr.aspx.cs"
    Inherits="CloudSAS.Admin.privilegeMgr" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<script runat="server">

    [DirectMethod(Namespace = "CloudSAS.Admin.privilegeMgr")]
    public void Edit(string funno)
    {

        string sql = "UPDATE UserInfor SET privilege ='" + funno + "' WHERE UserID ='"+tmpUserID.Value.ToString()+"'";
        DBUtility.DbHelperSQL.ExecuteSql(2, sql);

    }
</script>
<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <style>
        .complete .x-grid-cell-inner
        {
            text-decoration: line-through;
            color: #777;
        }
    </style>
    <script>
        var getTasks = function () {

            var msg = "", funno = "",
                selChildren = App.TreePanel1.getChecked();

            Ext.each(selChildren, function (node) {
                if (msg.length > 0) {
                    msg += ", ";
                    funno += ",";
                }
                funno += node.data.id;
                msg += node.data.text;
                //msg += node.data.id;//NodeID在此处通过node.data.id获取
            });
            
            //if (msg.length > 0) {
                CloudSAS.Admin.privilegeMgr.Edit(funno);//允许赋值和置空
            //}

            Ext.Msg.show({
                title: "以下权限已赋予",
                msg: msg.length > 0 ? msg : "None",
                icon: Ext.Msg.INFO,
                minWidth: 200,
                buttons: Ext.Msg.OK
            });

            //alert(tmpUserID.getValue());
        };

        var confir = function () {
            Ext.Msg.confirm('确认', '为该用户赋予所选功能权限？', function (btn) {
                if (btn == 'yes') { getTasks(); }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
    <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />
    <ext:Hidden ID="tmpUserID" runat="server" />
    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:GridPanel runat="server" Title="平台用户" Margins="0 0 5 5" Region="Center" Frame="true"
                ID="GridPanel1">
                <Store>
                    <ext:Store ID="Store2" runat="server" OnReadData="MyData_Refresh">
                        <Model>
                            <ext:Model ID="Model1" runat="server" IDProperty="userID">
                                <Fields>
                                    <ext:ModelField Name="userID" />
                                    <ext:ModelField Name="userName" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server">
                    <Columns>
                        <ext:Column runat="server" DataIndex="userID" Text="用户编号" />
                        <ext:Column runat="server" DataIndex="userName" Text="用户名" />
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:CheckboxSelectionModel runat="server" Mode="Single">
                        <DirectEvents>
                            <Select OnEvent="RowSelect" Buffer="250">
                                <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="#{FormPanel1}" />
                                <ExtraParams>
                                    <%--or can use params[2].id as value--%>
                                    <ext:Parameter Name="userID" Value="record.getId()" Mode="Raw" />
                                </ExtraParams>
                            </Select>
                        </DirectEvents>
                    </ext:CheckboxSelectionModel>
                </SelectionModel>
                <BottomBar>
                    <ext:PagingToolbar runat="server" />
                </BottomBar>
            </ext:GridPanel>
            <ext:TreePanel ID="TreePanel1" runat="server" Region="East" Split="true" Margins="0 5 5 5"
                BodyPadding="2" Frame="true" Title="用户功能树" Width="280" DefaultAnchor="100%" AutoScroll="True"
                UseArrows="True">
                <Store>
                    <ext:TreeStore ID="TreeStore1" runat="server">
                        <Proxy>
                            <ext:PageProxy />
                        </Proxy>
                    </ext:TreeStore>
                </Store>
                <Root>
                    <ext:Node NodeID="root" Text="Root" Icon="Folder" />
                </Root>
                <Listeners>
                    <CheckChange Handler="var node = Ext.get(this.getView().getNode(item));
                                      node[checked ? 'addCls' : 'removeCls']('complete')" />
                </Listeners>
                <Buttons>
                    <ext:Button ID="Button2" runat="server" Text="赋予以上功能权限" Icon="Accept">
                        <Listeners>
                            <Click Fn="confir" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
            </ext:TreePanel>
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
