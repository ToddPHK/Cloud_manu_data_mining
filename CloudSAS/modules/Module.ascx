<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Module.ascx.cs" Inherits="Ext.Net.Examples.Examples.Desktop.Introduction.Overview.modules.Module" %>
<%@ Import Namespace="Ext.Net.Utilities" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
 
<!DOCTYPE html>
 
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (X.IsAjaxRequest)
        {
            //We do not need to DataBind on an DirectEvent
            return;
        }
         
        //Build first level
        this.BuildLevel(null);
    }
 
    [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
    public string BuildLevel(Dictionary<string, string> parameters)
    {
        int level = parameters != null && parameters.ContainsKey("level") ? int.Parse(parameters["level"]) : 1;
         
        // bind store
        List<object> data = new List<object>();
 
        for (int i = 1; i <= 10; i++)
        {
            data.Add(new { ID = i, Name = "Level".ConcatWith(level, ": Row " + i) });
        }
         
        //build grid
        GridPanel grid = new GridPanel
            {
                Height = 215,
                HideHeaders = level != 1,
                DisableSelection = true,
                Store =
                {
                    new Store
                    {                       
                        Model =
                        {
                            new Model
                            {
                                IDProperty = "ID",
                                Fields =
                                {
                                    new ModelField("ID"),
                                    new ModelField("Name"),
                                    new ModelField
                                    {
                                        Name = "Level",
                                        DefaultValue = level.ToString()
                                    }
                                }
                            }  
                        },                       
                        DataSource = data  
                    }
                },
                ColumnModel =
                {
                    Columns =
                    {
                        new Column { DataIndex = "Name", Text = "Name", Flex = 1 }
                    }
                },
                View =
                {
                    new Ext.Net.GridView()
                    {
                        OverItemCls = " " //to avoid the known issue #6
                    }
                }
            };
 
        // add expander for all levels except last (last level is 5)
        if (level < 5)
        {
            RowExpander re = new RowExpander
            {               
                ScrollOffset = 10,
                Loader = new ComponentLoader
                {
                    Mode = LoadMode.Component,
                    DirectMethod = "#{DirectMethods}.BuildLevel",
                    LoadMask =
                    {
                        ShowMask = true
                    },
                    Params =
                    {
                        new Ext.Net.Parameter("level", (level + 1).ToString(), ParameterMode.Raw),
                        new Ext.Net.Parameter("id", "this.record.getId()", ParameterMode.Raw)
                    }
                }
            };
 
            grid.Plugins.Add(re);
        }
 
        if (level == 1)
        {
            grid.Title = "MultiLevel grid";
            grid.Width = 600;
            grid.Height = 600;
            grid.ResizableConfig = new Resizer { Handles = ResizeHandle.South };
            Window10.Items.Add(grid);
            //this.Form.Controls.Add(grid);           
        }
        else
        {
            grid.EnableColumnHide = false;
            return ComponentLoader.ToConfig(grid);
        } 
         
        return null;
    }
</script>
 
<ext:DesktopModuleProxy ID="DesktopModuleProxy1" runat="server">
    <Module ModuleID="test-win">
        <Shortcut Name="Test Window" IconCls="x-grid-shortcut" SortIndex="1" />
        <Launcher Text="Test Window" Icon="Table" />
        <Window>
            <ext:Window ID="Window10" runat="server"
                Icon="Table"
                Width="740"
                Height="480"
                AnimCollapse="false"
                ConstrainHeader="true"               
                Layout="Fit"
                Title="Test Window">
                <Items>
                </Items>
            </ext:Window>
        </Window>
    </Module>
</ext:DesktopModuleProxy>