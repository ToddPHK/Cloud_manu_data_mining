<%@ Page Language="C#" %>

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
        
        string sql = "SELECT EntFullName as company,Avg(Assessment.[服务企业分]) as avgScore, Avg(Assessment.[服务企业分])/20 as rating FROM Assessment LEFT JOIN EntUserInfor as eu ON Assessment.[企业编号]=eu.UserID GROUP BY eu.EntFullName";
        store.DataSource = DBUtility.DbHelperSQL.FindTable(3, sql);
        store.DataBind();
    }
  
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    
    <style>
        .number-selected {
	        background : transparent url(../images/star_n.png) repeat-x left center;
        }
        
        .number-unselected {
	        background : transparent url(../images/star_fade_n.png) repeat-x left center;
        }
    </style>       
</head>
<body> 
    <form id="Form1" runat="server">
    <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />
    <ext:Viewport ID="Viewport1" runat="server" Layout="FitLayout">
        <Items>
    <ext:GridPanel 
        ID="GridPanel1"
        runat="server" 
        Title="Array Grid" 
        Layout="fit" >
        <Store>
            <ext:Store ID="Store1" runat="server" OnReadData="MyData_Refresh" PageSize="15">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="company" />
                            <ext:ModelField Name="avgScore" Type="Float" />
                            <ext:ModelField Name="rating" Type="Float" />                            
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column runat="server" Text="企业" DataIndex="company" /> 
                <ext:Column runat="server" Text="平均分" DataIndex="avgScore" />               
                <ext:RatingColumn Text="星级" DataIndex="rating" RoundToTick="false"  />

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
