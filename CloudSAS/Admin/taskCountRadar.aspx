<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void ReloadData(object sender, DirectEventArgs e)
    {
        Store store = this.Chart1.GetStore();
        
        store.DataSource = Ext.Net.Examples.ChartData.GenerateData();
        store.DataBind();
    }
</script>    

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>

    <script>
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if(choice == 'yes'){
                    btn.up('panel').down('chart').save({
                        type: 'image/png'
                    });
                }
            });
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server"  LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />

        <h1>企业项目任务雷达统计图</h1>

        <ext:Panel 
            runat="server"
            Title="Filled Radar Chart"
            Width="800"
            Height="600"
            StyleSpec="overflow:hidden;"
            Layout="FitLayout">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button 
                            runat="server" 
                            Text="Reload Data" 
                            Icon="ArrowRefresh" 
                            OnDirectClick="ReloadData" 
                            />
                        <ext:Button 
                            runat="server" 
                            Text="Animate" 
                            Icon="ShapesManySelect" 
                            EnableToggle="true" 
                            Pressed="true">
                            <Listeners>
                                <Toggle Handler="#{Chart1}.animate = pressed ? {easing: 'ease', duration: 500} : false;" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button 
                            runat="server" 
                            Text="Save Chart" 
                            Icon="Disk"
                            Handler="saveChart"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:Chart 
                    ID="Chart1" 
                    runat="server"
                    StyleSpec="background:#fff;"                   
                    StandardTheme="Category2"
                    InsetPadding="20"
                    Animate="true">
                    <LegendConfig Position="Right" />
                    <Store>
                        <ext:Store 
                            runat="server" 
                            Data="<%# Ext.Net.Examples.ChartData.GenerateData() %>" 
                            AutoDataBind="true">                           
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:RadialAxis />
                    </Axes>
                    <Series>
                        <ext:RadarSeries XField="Name" YField="Data1" ShowInLegend="true">
                            <Style Opacity="0.4" />
                        </ext:RadarSeries>

                        <ext:RadarSeries XField="Name" YField="Data2" ShowInLegend="true">
                            <Style Opacity="0.4" />
                        </ext:RadarSeries>

                        <ext:RadarSeries XField="Name" YField="Data3" ShowInLegend="true">
                            <Style Opacity="0.4" />
                        </ext:RadarSeries>
                    </Series>
                </ext:Chart>
            </Items>
        </ext:Panel>
    </form>    
</body>
</html>