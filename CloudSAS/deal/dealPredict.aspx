<%@ Page Language="C#" AutoEventWireup="True" Codebehind="dealPredict.aspx.cs" Inherits="CloudSAS.dealPredict" %>

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
                //chart.categoryField = "year";
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
                valueAxis.title = "服务交易量";
                valueAxis.dashLength = 5;
                valueAxis.axisAlpha = 0;
				//坐标最值不设置则自动配置
				//valueAxis.minimum = 1;
                //valueAxis.maximum = 6;
                valueAxis.integersOnly = true;
                valueAxis.gridCount = 10;
                valueAxis.reversed = false; // 纵坐标反转
                chart.addValueAxis(valueAxis);

                // second value axis (on the right) 
                var valueAxis2 = new AmCharts.ValueAxis();
				valueAxis2.title = "服务交易金额";
                valueAxis2.position = "right"; // this line makes the axis to appear on the right
                //valueAxis2.axisColor = "#FCD202";
                valueAxis2.gridAlpha = 0;
                valueAxis2.axisThickness = 2;
                chart.addValueAxis(valueAxis2);

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
                graph.title = "交易量历史值";
				graph.valueAxis = valueAxis; 
                graph.valueField = "origin";
                graph.balloonText = "[[category]]交易服务[[value]]次";
                graph.bullet = "square";
                chart.addGraph(graph);

                // United Kingdom graph
                var graph = new AmCharts.AmGraph();
                graph.title = "交易量预测值";
                graph.valueField = "predict";
                graph.balloonText = "预测[[category]]交易服务[[value]]次";
                graph.bullet = "round";
                chart.addGraph(graph);

                // third graph
                var graph3 = new AmCharts.AmGraph();
                graph3.type = "column";
                graph3.valueAxis = valueAxis2; // we have to indicate which value axis should be used
                graph3.valueField = "price";
                graph3.lineAlpha = 0;
                graph3.fillAlphas = 1;
                graph3.title = "交易金额历史值";
                graph3.balloonText = "[[category]]交易金额[[value]]元";
                //graph3.bullet = "triangleUp";
                //graph3.hideBulletsCount = 30;
                chart.addGraph(graph3);

                // 4th graph
                var graph4 = new AmCharts.AmGraph();
                graph4.type = "column";
                graph4.valueAxis = valueAxis2; // we have to indicate which value axis should be used
                graph4.valueField = "predict2";
                graph4.lineAlpha = 0;
                graph4.fillAlphas = 1;
                graph4.title = "交易金额预测值";
                graph4.balloonText = "预测[[category]]交易金额[[value]]元";
                //graph3.bullet = "triangleUp";
                //graph4.hideBulletsCount = 30;
                chart.addGraph(graph4);

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
        <h1>基于一阶线性回归模型的服务交易量及金额预测</h1>  
        <div id="chartdiv" style="width:100%; height:400px;"></div>
        </form>
    </body>
</html>