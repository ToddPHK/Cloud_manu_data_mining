<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="entMember.aspx.cs"
    Inherits="CloudSAS.entMember" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />       
            
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:GridPanel 
                    runat="server" 
                    Title="企业员工"
                    Margins="0 0 5 5"
                    Region="Center" 
                    Frame="true" ID="GridPanel1">
             <HeaderConfig>
                            <Items>
                                <ext:Button ID="Button1" runat="server" Icon="Delete" ToolTip="删除所选记录" MenuArrow="False" Flat="True" Text="删除">                              
                                        <DirectEvents>
                                            <Click OnEvent="BtnDel_Click">
                                                <Confirmation ConfirmRequest="true" Title="确认" Message="确实要删除吗?" />
                                                <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                            </Click>
                                        </DirectEvents>
                                        <Listeners>
                                            <Click Handler="if(#{GridPanel1}.getSelectionModel().getCount()<=0) {Ext.Msg.show({icon: Ext.MessageBox.WARNING, msg: '请选择要删除的记录项！', buttons:Ext.Msg.OK});return false;}" />
                                        </Listeners>                          
                                </ext:Button>
                            </Items>
	            <Listeners>
		            <BeforeRender Handler="this.insert(0, this.titleCmp);" />
	            </Listeners>	            
            </HeaderConfig>
                    <Store>
                        <ext:Store ID="Store2" runat="server" OnReadData="MyData_Refresh" >
                            <Model>
                                <ext:Model ID="Model1" runat="server" IDProperty="EmployeeID">
                                    <Fields>
                                        <ext:ModelField Name="EmployeeID" />
                                        <ext:ModelField Name="FullName" />                           
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:Column runat="server" DataIndex="EmployeeID" Text="人员编号"  />
                            <ext:Column runat="server" DataIndex="FullName" Text="姓名"  />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel runat="server" Mode="Multi" ID="MultiSelect1">
                            <DirectEvents>
                                <Select OnEvent="RowSelect" Buffer="250">
                                    <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="#{FormPanel1}" />
                                    <ExtraParams>
                                        <%--or can use params[2].id as value--%>
                                        <ext:Parameter Name="EmployeeID" Value="record.getId()" Mode="Raw" />
                                    </ExtraParams>
                                </Select>
                            </DirectEvents>
                        </ext:CheckboxSelectionModel>
                    </SelectionModel>
                    <BottomBar>
                        <ext:PagingToolbar runat="server" />
                    </BottomBar>
                </ext:GridPanel>
                <ext:FormPanel 
                    ID="FormPanel1" 
                    runat="server" 
                    Region="East"
                    Split="true"
                    Margins="0 5 5 5"
                    BodyPadding="2"
                    Frame="true" 
                    Title="员工详细信息" 
                    Width="280"
                    Icon="User"
                    DefaultAnchor="100%" 
                    AutoScroll="True">
                    <Items>
                        <ext:TextField runat="server" FieldLabel="人员编号" Name="EmployeeNumber" />
                        <ext:TextField runat="server" FieldLabel="姓名" Name="FullName" />
                        <ext:TextField runat="server" FieldLabel="性别" Name="Gender" />
                        <ext:TextField runat="server" FieldLabel="学历" Name="degree" />
                        <ext:TextField runat="server" FieldLabel="归属角色" Name="Position" />
                        <ext:TextField runat="server" FieldLabel="归属部门" Name="DepartmentNumber" />
                        <ext:DateField runat="server" FieldLabel="进厂时间" Name="HireDate" Format="yyyy-MM-dd" />
                        <ext:TextField runat="server" FieldLabel="移动电话" Name="MobilePhone" />
                        <ext:TextField runat="server" FieldLabel="Email" Name="Email" />
                        <ext:TextField runat="server" FieldLabel="通讯地址" Name="Address" />
                        <ext:DateField runat="server" FieldLabel="出生年月" Name="BirthDate" Format="yyyy-MM-dd" />
                        <ext:TextArea runat="server" FieldLabel="培训情况" Name="BriefIntroduction" />
                    </Items>
                </ext:FormPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
