<%@ Page Language="C#" AutoEventWireup="True" EnableViewState="false" CodeBehind="servDealReport.aspx.cs"
    Inherits="CloudSAS.servDealReport" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <style>
        body
        {
            font: normal 11px tahoma, arial, helvetica, sans-serif;
        }
        
        #customers-ct table
        {
            width: 100% !important;
        }
        
        #customers-ct th
        {
            background: #F0F4F5 url(/extjs/resources/themes/images/default/toolbar/toolbar-default-bg-gif/ext.axd) repeat-x scroll left top;
            font-weight: bold;
            padding: 8px 5px;
        }
        
        #customers-ct td
        {
            padding: 5px;
            border-bottom: 1px solid silver;
        }
        
        #customers-ct .letter-row
        {
            padding-top: 15px;
            border: none;
        }
        
        #customers-ct .letter-row h2
        {
            font-size: 2em;
        }
        
        #customers-ct .header
        {
            padding: 10px 0px 10px 5px;
        }
        
        #customers-ct .header p
        {
            font-size: 2em;
        }
        
        #customers-ct .header a
        {
            margin-bottom: 10px;
        }
        
        .cust-name-over
        {
            cursor: pointer;
            background-color: #efefef;
        }
        
        #customers-ct .letter-row div
        {
            border-bottom: 2px solid #99bbe8;
            cursor: pointer;
            background: transparent url(/extjs/resources/themes/images/default/grid/group-expand-sprite-gif/ext.axd) no-repeat 0px -42px;
            margin-bottom: 5px;
        }
        
        #customers-ct .letter-row div h2
        {
            padding-left: 18px;
        }
        
        #customers-ct .letter-row div.collapsed
        {
            background-position: 0px 8px;
        }
        
        #customers-ct table.collapsed
        {
            display: none;
        }
        
        .customer-label
        {
            font-weight: bold;
            font-size: 12px;
            padding: 0px 0px 0px 32px;
            width: 150px;
        }
    </style>
    <ext:XScript runat="server">
        <script>
            var itemClick = function (view, record, item, index, e) {
                var group = e.getTarget("h2.letter-selector");
            
                if (group) {
                    Ext.get(group)
                        .up("div")
                        .toggleCls("collapsed")
                        .up("td")
                        .select("table")
                        .toggleCls("collapsed");
                }

                var row = e.getTarget("tr.customer-record"),
                    nd = row && Ext.get(row).child("td.cust-name");
                
                if(nd){
                    #{DataViewContextMenu}.node = {
                        id    : nd.getAttribute("custID"),
                        name  : nd.getAttribute("custName"),
                        contact : nd.dom.innerHTML
                    };
            
                    #{DataViewContextMenu}.showAt(e.getXY());
                }
            };
        </script>
    </ext:XScript>
</head>
<body>
    <ext:ResourceManager runat="server" LicenseKey="NTcwMjk3NjQsMiw5OTk5LTEyLTMx" />
    <ext:Store ID="Store1" runat="server" OnRefreshData="MyData_Refresh">
        <Reader>
            <ext:JsonReader>
            </ext:JsonReader>
        </Reader>
        <Model>
            <ext:Model ID="Model1" runat="server">
                <Fields>
                    <ext:ModelField Name="ServiceID" />
                    <ext:ModelField Name="CompanyName" />
                    <ext:ModelField Name="ContactName" />
                    <ext:ModelField Name="Email" />
                    <ext:ModelField Name="Address" />
                    <ext:ModelField Name="City" />
				</Fields>
            </ext:Model>
        </Model>
    </ext:Store>
    <ext:Menu ID="DataViewContextMenu" runat="server">
        <Items>
            <ext:Label ID="CustomerLabel" runat="server" Cls="customer-label" />
            <ext:MenuItem runat="server" Text="显示详细信息" Icon="ApplicationFormEdit">
                <Listeners>
                    <Click Handler="Ext.Msg.alert('交易详情','此处可显示交易详情');" />
                </Listeners>
            </ext:MenuItem>
        </Items>
        <Listeners>
            <BeforeShow Handler="#{CustomerLabel}.setText(this.node.contact);" />
        </Listeners>
    </ext:Menu>
    <ext:Toolbar runat="server">
        <Items>
            <ext:Button runat="server" Text="打印" Icon="Printer" OnClientClick="window.print();" />
        </Items>
    </ext:Toolbar>
    <ext:DataView runat="server" DisableSelection="true" ItemSelector="td.letter-row"
        EmptyText="没有数据">
        <Store>
            <ext:Store ID="dsReport" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="Letter" />
                            <ext:ModelField Name="Customers" Type="Object" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <Tpl ID="Template1" runat="server">
            <Html>
                <div id="customers-ct">
					<div class="header">
						<p>服务交易报表</p>                                                                        
					</div>
					<table>
						<tr>
							<th style="width:10%">服务编号</th>
							<th style="width:18%">服务发布方</th>
							<th style="width:18%">服务申请方</th>
							<th style="width:18%">成交价</th>
							<th style="width:18%">成交时间</th>
							<th style="width:18%">服务到期时间</th>
						</tr>
					
						<tpl for=".">
								<tr>
									<td class="letter-row" colspan="6">
										<div><h2 class="letter-selector">{Letter}</h2></div>
                                        <tpl for="Customers">
									        <table>                                                
                                                <tr class="customer-record">
										            <td class="cust-name" custID="{CustomerID}" custName="{CompanyName}" style="width:10%">{ServiceID}</td>
										            <td style="width:18%">&nbsp;{CompanyName}</td>
										            <td style="width:18%">&nbsp;{ContactName}</td>
										            <td style="width:18%">&nbsp;{Email}</td>
										            <td style="width:18%">&nbsp;{Address}</td>
										            <td style="width:18%">&nbsp;{City}</td>
									            </tr>
                                            </table>
								        </tpl>
									</td>
								</tr>								
						</tpl>                    
					</table>
				</div>
            </Html>
        </Tpl>
        <Listeners>
            <ItemClick Fn="itemClick" />
            <Refresh Handler="this.el.select('tr.customer-record').addClsOnOver('cust-name-over');"
                Delay="100" />
        </Listeners>
    </ext:DataView>
</body>
</html>
