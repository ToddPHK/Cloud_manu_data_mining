<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }

        this.StoreCombo.DataSource = Province.GetAll();
        this.StoreCombo.DataBind();
    }

    protected void MyData_Refresh(object sender, StoreReadDataEventArgs e)
    {
        this.BindData();
    }

    private void BindData()
    {
        Store store = this.GridPanel1.GetStore();
        
        string sql = "SELECT ID,EntFullName,LocateRegion, BusinessSphere FROM EntUserInfor";
        store.DataSource = DBUtility.DbHelperSQL.FindTable(3, sql);
        store.DataBind();
    }

    [DirectMethod(Namespace = "CloudSAS.customer")]
    public void Edit(int id, string field, string oldValue, string newValue, object customer)
    {
        //string message = "<b>Index:</b> {0}<br /><b>字段:</b> {1}<br /><b>原值:</b> {2}<br /><b>现值:</b> {3}";
        string message = "<b>字段:</b> {1}<br /><b>原值:</b> {2}<br /><b>现值:</b> {3}";
        // Send Message...
        X.Msg.Notify("修改记录 #" + id.ToString() + " 成功", string.Format(message, id, field, oldValue, newValue)).Show();

        string sql = "UPDATE EntUserInfor SET "+field+"='"+newValue+"' WHERE ID ='"+id+"'";
        DBUtility.DbHelperSQL.ExecuteSql(3, sql);
        this.GridPanel1.GetStore().GetById(id).Commit();
    }
        
    public class Province
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public static List<Province> GetAll()
        {
            return new List<Province>
                       {
                           new Province {ID = 1, Name = "北京"},
                           new Province {ID = 2, Name = "天津"},
                           new Province {ID = 3, Name = "河北"},
                           new Province {ID = 4, Name = "山西"},
                           new Province {ID = 5, Name = "内蒙古"},
                           new Province {ID = 6, Name = "辽宁"},
                           new Province {ID = 7, Name = "吉林"},
                           new Province {ID = 8, Name = "黑龙江"},
                           new Province {ID = 9, Name = "上海"},
                           new Province {ID = 10, Name = "江苏"},
                           new Province {ID = 11, Name = "浙江"},
                           new Province {ID = 12, Name = "安徽"},
                           new Province {ID = 13, Name = "福建"},
                           new Province {ID = 14, Name = "江西"},
                           new Province {ID = 15, Name = "山东"},
                           new Province {ID = 16, Name = "河南"},
                           new Province {ID = 17, Name = "湖北"},
                           new Province {ID = 18, Name = "湖南"},
                           new Province {ID = 19, Name = "广东"},
                           new Province {ID = 20, Name = "广西"},
                           new Province {ID = 21, Name = "海南"},
                           new Province {ID = 22, Name = "重庆"},
                           new Province {ID = 23, Name = "四川"},
                           new Province {ID = 24, Name = "贵州"},
                           new Province {ID = 25, Name = "云南"},
                           new Province {ID = 26, Name = "西藏"},
                           new Province {ID = 27, Name = "陕西"},
                           new Province {ID = 28, Name = "甘肃"},
                           new Province {ID = 29, Name = "青海"},
                           new Province {ID = 30, Name = "宁夏"},
                           new Province {ID = 31, Name = "新疆"},
                           new Province {ID = 32, Name = "香港"},
                           new Province {ID = 33, Name = "澳门"},
                           new Province {ID = 34, Name = "台湾"}
                       };
        }
    }      
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    
    <script>
        var edit = function (editor, e) {
            // Call DirectMethod
            if (e.value !== e.originalValue) {
                CloudSAS.customer.Edit(e.record.data.ID, e.field, e.originalValue, e.value, e.record.data);
            }
        };
    </script>          
</head>
<body> 
    <form id="Form1" runat="server">
    <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />
        
        <h1>双击可编辑数据</h1>        

        <ext:Store ID="StoreCombo" runat="server">
            <Model>
                <ext:Model ID="Model1" runat="server" IDProperty="ID">
                    <Fields>
                        <ext:ModelField Name="ID" />
                        <ext:ModelField Name="Name" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
        

    <ext:Viewport ID="Viewport1" runat="server" Layout="FormLayout">
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
                            <ext:ModelField Name="ID" />
                            <ext:ModelField Name="EntFullName" />
                            <ext:ModelField Name="LocateRegion"  />
                            <ext:ModelField Name="BusinessSphere"  />                            
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:RowNumbererColumn ID="RowNumbererColumn1" Width="25" runat="server" />
                <ext:Column runat="server" Text="企业" DataIndex="EntFullName">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>                
                </ext:Column> 
                <ext:Column runat="server" Text="所在地" DataIndex="LocateRegion">                     
                        <Editor>
                            <ext:ComboBox  
                                runat="server"     
                                QueryMode="Local"   
                                Editable="false"                     
                                StoreID="StoreCombo" 
                                DisplayField="Name" 
                                ValueField="Name"
                                />
                        </Editor>                  
                </ext:Column>                            
                <ext:Column runat="server" Text="行业" DataIndex="BusinessSphere">
                        <Editor>
                            <ext:TextField ID="TextField1" runat="server" />
                        </Editor>                   
                </ext:Column> 
            </Columns>
        </ColumnModel>  
            <Plugins>
                <ext:CellEditing ID="CellEditing1" runat="server">
                    <Listeners>
                        <Edit Fn="edit" />
                    </Listeners>                
                </ext:CellEditing>
            </Plugins>
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
