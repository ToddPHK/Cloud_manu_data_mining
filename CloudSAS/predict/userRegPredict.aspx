<%@ Page Language="C#" AutoEventWireup="True" Codebehind="userRegPredict.aspx.cs" Inherits="CloudSAS.userRegPredict" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    <title></title>
    <script src="../js/amcharts.js" type="text/javascript"></script>
        <script type="text/javascript">
            var chart;

            //var oJSON_DataTable_DataHolder = document.getElementById("JSON_DataTable_DataHolder");


            //var chartData = tmp;
			var chartData = <%=sjson%>;

            AmCharts.ready(function () {
                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();
                chart.dataProvider = chartData;
                chart.categoryField = "date";
                chart.startDuration = 0.5;
                chart.balloon.color = "#000000";

                // AXES
                // category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.parseDates = true; // as our data is date-based, we set parseDates to true
                categoryAxis.minPeriod = "MM"; // our data is daily, so we set minPeriod to DD
                categoryAxis.fillAlpha = 1;
                categoryAxis.fillColor = "#FAFAFA";
                categoryAxis.gridAlpha = 0;
                categoryAxis.axisAlpha = 0;
                categoryAxis.gridPosition = "start";
                categoryAxis.position = "top";//横坐标显示在上方/下方

                // value
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.title = "用户注册数量";
                valueAxis.dashLength = 5;
                valueAxis.axisAlpha = 0;
				//坐标最值不设置则自动配置
				//valueAxis.minimum = 1;
                //valueAxis.maximum = 6;
                valueAxis.integersOnly = true;
                valueAxis.gridCount = 10;
                valueAxis.reversed = false; // 纵坐标反转
                chart.addValueAxis(valueAxis);

                // GRAPHS
                // Italy graph	
				/*
                var graph = new AmCharts.AmGraph();
                graph.title = "Italy";
                graph.valueField = "italy";
                graph.hidden = true; // this line makes the graph initially hidden           
                graph.balloonText = "place taken by Italy in [[category]]: [[value]]";
                graph.lineAlpha = 1;
                graph.bullet = "round";
                chart.addGraph(graph);
				*/

                // origin graph
                var graph = new AmCharts.AmGraph();
                graph.title = "历史值";
                graph.valueField = "origin";
                graph.balloonText = "[[category]]注册用户[[value]]名";
                graph.bullet = "square";
                chart.addGraph(graph);

                // United Kingdom graph
                var graph = new AmCharts.AmGraph();
                graph.title = "预测值";
                graph.valueField = "predict";
                graph.balloonText = "预测[[category]]有[[value]]名用户注册";
                graph.bullet = "round";
                chart.addGraph(graph);

				// CURSOR
                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                //chartCursor.cursorPosition = "mouse";//在category间平滑滑动
                chartCursor.categoryBalloonDateFormat = "YYYY-MM";
                chart.addChartCursor(chartCursor);


                // LEGEND
                var legend = new AmCharts.AmLegend();
                legend.markerType = "circle";
                chart.addLegend(legend);

                // WRITE
                chart.write("chartdiv");
            });
</script>
    </head>
    <body>
    <form id="form1" runat="server">
        <h1>基于指数平滑法的用户注册数量预测</h1>  
        <div id="chartdiv" style="width:100%; height:400px;"></div>
        </form>
    </body>
</html>