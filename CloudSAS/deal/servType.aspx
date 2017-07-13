

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="../js/amcharts.js" type="text/javascript"></script>
    <script type="text/javascript">
            var chart;

            var chartData = [{
                year: 2000,
                cars: 1200,
                motorcycles: 650,
                bicycles: 121,
				knowledge: 150,
				calcu: 130
            }, {
                year: 1995,
                cars: 1567,
                motorcycles: 683,
                bicycles: 146,
				knowledge: 250,
				calcu: 120
            }, {
                year: 1996,
                cars: 1617,
                motorcycles: 691,
                bicycles: 138,
				knowledge: 150,
				calcu: 130
            }, {
                year: 1997,
                cars: 1630,
                motorcycles: 642,
                bicycles: 127,
				knowledge: 150,
				calcu: 130
            }, {
                year: 1998,
                cars: 1660,
                motorcycles: 699,
                bicycles: 105,
				knowledge: 150,
				calcu: 130
            }, {
                year: 1999,
                cars: 1683,
                motorcycles: 721,
                bicycles: 109,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2000,
                cars: 1691,
                motorcycles: 737,
                bicycles: 112,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2001,
                cars: 1298,
                motorcycles: 680,
                bicycles: 101,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2002,
                cars: 1275,
                motorcycles: 664,
                bicycles: 97,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2003,
                cars: 1246,
                motorcycles: 648,
                bicycles: 93,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2004,
                cars: 1218,
                motorcycles: 637,
                bicycles: 101,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2005,
                cars: 1213,
                motorcycles: 633,
                bicycles: 87,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2006,
                cars: 1199,
                motorcycles: 621,
                bicycles: 79,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2007,
                cars: 1110,
                motorcycles: 210,
                bicycles: 81,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2008,
                cars: 1165,
                motorcycles: 232,
                bicycles: 75,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2009,
                cars: 1145,
                motorcycles: 219,
                bicycles: 88,
				knowledge: 170,
				calcu: 130
            }, {
                year: 2010,
                cars: 663,
                motorcycles: 201,
                bicycles: 82,
				knowledge: 150,
				calcu: 130
            }, {
                year: 2011,
                cars: 980,
                motorcycles: 285,
                bicycles: 87,
				knowledge: 250,
				calcu: 130
            }, {
                year: 2012,
                cars: 859,
                motorcycles: 277,
                bicycles: 71,
				knowledge: 310,
				calcu: 230
            }];

            AmCharts.ready(function () {
                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();
                chart.pathToImages = "../images/Icons/";
                chart.zoomOutButton = {
                    backgroundColor: "#000000",
                    backgroundAlpha: 0.15
                };
                chart.dataProvider = chartData;
                chart.categoryField = "year";

                chart.addTitle("服务交易类型分析", 15);

                // AXES
                // Category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.gridAlpha = 0.07;
                categoryAxis.axisColor = "#DADADA";
                categoryAxis.startOnAxis = true;

                // Value
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.title = "百分比"; // this line makes the chart "stacked"
                valueAxis.stackType = "100%";
                valueAxis.gridAlpha = 0.07;
                chart.addValueAxis(valueAxis);

                // GRAPHS
                // first graph
                var graph = new AmCharts.AmGraph();
                graph.type = "line"; // it's simple line graph
                graph.title = "设备";
                graph.valueField = "cars";
                graph.balloonText = "[[value]] ([[percents]]%)";
                graph.lineAlpha = 0;
                graph.fillAlphas = 0.6; // setting fillAlphas to > 0 value makes it area graph 
                chart.addGraph(graph);

                // second graph
                var graph = new AmCharts.AmGraph();
                graph.type = "line";
                graph.title = "软件";
                graph.valueField = "motorcycles";
                graph.balloonText = "[[value]] ([[percents]]%)";
                graph.lineAlpha = 0;
                graph.fillAlphas = 0.6;
                chart.addGraph(graph);

                // third graph
                var graph = new AmCharts.AmGraph();
                graph.type = "line";
                graph.title = "专家";
                graph.valueField = "bicycles";
                graph.balloonText = "[[value]] ([[percents]]%)";
                graph.lineAlpha = 0;
                graph.fillAlphas = 0.6;
                chart.addGraph(graph);

                // 4th graph
                var graph = new AmCharts.AmGraph();
                graph.type = "line";
                graph.title = "知识";
                graph.valueField = "knowledge";
                graph.balloonText = "[[value]] ([[percents]]%)";
                graph.lineAlpha = 0;
                graph.fillAlphas = 0.6;
                chart.addGraph(graph);

                // 5th graph
                var graph = new AmCharts.AmGraph();
                graph.type = "line";
                graph.title = "计算能力";
                graph.valueField = "calcu";
                graph.balloonText = "[[value]] ([[percents]]%)";
                graph.lineAlpha = 0;
                graph.fillAlphas = 0.6;
                chart.addGraph(graph);

                // LEGEND
                var legend = new AmCharts.AmLegend();
                legend.align = "center";
                chart.addLegend(legend);

                // CURSOR
                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.zoomable = false; // as the chart displayes not too many values, we disabled zooming
                chartCursor.cursorAlpha = 0;
                chart.addChartCursor(chartCursor);

                // WRITE
                chart.write("chartdiv");
            });
    </script>
</head>
    <body>
        <div id="chartdiv" style="width:100%; height:400px;"></div>
    </body>
</html>
