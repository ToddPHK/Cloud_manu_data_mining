<%@ Page Language="C#" %>

<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Linq" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    protected void MyData_Refresh(object sender, StoreReadDataEventArgs e)
    {
        this.BindData();
    }

    private void BindData()
    {
        Store store = this.GridPanel1.GetStore();

        string sql = "SELECT ID,ServiceID,Applicant,Publisher,price, DealDate FROM deal_fact WHERE deal='1'";
        store.DataSource = DBUtility.DbHelperSQL.FindTable(3, sql);
        store.DataBind();
    }
    protected void Store1_Submit(object sender, StoreSubmitDataEventArgs e)
    {
        string format = this.FormatType.Value.ToString();

        XmlNode xml = e.Xml;

        this.Response.Clear();

        switch (format)
        {
            case "xml":
                string strXml = xml.OuterXml;
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
                this.Response.AddHeader("Content-Length", strXml.Length.ToString());
                this.Response.ContentType = "application/xml";
                this.Response.Write(strXml);
                break;

            case "xls":
                this.Response.ContentType = "application/vnd.ms-excel";
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xls");
                XslCompiledTransform xtExcel = new XslCompiledTransform();
                xtExcel.Load(Server.MapPath("../Excel.xsl"));
                xtExcel.Transform(xml, null, Response.OutputStream);

                break;

            case "csv":
                this.Response.ContentType = "application/octet-stream";
                this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.csv");
                XslCompiledTransform xtCsv = new XslCompiledTransform();
                xtCsv.Load(Server.MapPath("../Csv.xsl"));
                xtCsv.Transform(xml, null, Response.OutputStream);

                break;
        }
        this.Response.End();
    }

</script>
<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <script>
        var submitValue = function (grid, hiddenFormat, format) {
            hiddenFormat.setValue(format);
            grid.submitData(false, { isUpload: true });
        };

    </script>
</head>
<body>
    <form id="Form1" runat="server">
    <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />
    <ext:Hidden ID="FormatType" runat="server" />
    <ext:Viewport ID="Viewport1" runat="server" Layout="FitLayout">
        <Items>
            <ext:GridPanel ID="GridPanel1" runat="server" Title="Array Grid" Layout="fit" Header="False">
                <TopBar>
                    <ext:Toolbar ID="Toolbar1" runat="server">
                        <Items>
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
                <Store>
                    <ext:Store ID="Store1" runat="server" OnReadData="MyData_Refresh" PageSize="15" OnSubmitData="Store1_Submit">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="ID" />
                                    <ext:ModelField Name="ServiceID" />
                                    <ext:ModelField Name="Applicant" />
                                    <ext:ModelField Name="Publisher" />
                                    <ext:ModelField Name="price" />
                                    <ext:ModelField Name="DealDate" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server">
                    <Columns>
                        <ext:RowNumbererColumn ID="RowNumbererColumn1" Width="25" runat="server" />
                        <ext:Column runat="server" Text="服务编号" DataIndex="ServiceID">
                        </ext:Column>
                        <ext:Column ID="Column1" runat="server" Text="服务申请方" DataIndex="Applicant">
                        </ext:Column>
                        <ext:Column runat="server" Text="服务发布方" DataIndex="Publisher">
                        </ext:Column>
                        <ext:Column ID="Column2" runat="server" Text="成交价" DataIndex="price">
                        </ext:Column>
                        <ext:Column ID="Column3" runat="server" Text="成交时间" DataIndex="DealDate">
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Multi" />
                </SelectionModel>
                <View>
                    <ext:GridView ID="GridView1" runat="server" StripeRows="true" />
                </View>
                <BottomBar>
                    <ext:PagingToolbar ID="PagingToolbar1" runat="server">
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
    </form>
</body>
</html>
