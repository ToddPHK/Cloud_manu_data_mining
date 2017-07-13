<%@ Page Language="C#" AutoEventWireup="True" Codebehind="jquery_entGIS.aspx.cs" Inherits="CloudSAS.map" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="../css/jquery-jvectormap.css" rel="stylesheet" type="text/css" />
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.2.js" type="text/javascript"></script>
    <script src="../js/jquery.vector-map.js" type="text/javascript"></script>  
    <script src="../js/china-zh.js" type="text/javascript"></script>
    <script type="text/javascript">

        function colorHexToRGB(htmlColor) {
            var COLOR_REGEX = /^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$/;
            arrRGB = htmlColor.match(COLOR_REGEX);
            if (arrRGB == null) {
                alert("Invalid color passed, the color should be in the html format. Example: #ff0033");
            }
            var red = parseInt(arrRGB[1], 16);
            var green = parseInt(arrRGB[2], 16);
            var blue = parseInt(arrRGB[3], 16);
            return { "r": red, "g": green, "b": blue };
        }

        function ColorOpacity(foregroundColor, backgroundColor, opacity) {
            if (opacity < 0.00 || opacity > 1.00) {
                alert("assertion, opacity should be between 0 and 1");
            }          
            var foregroundRGB = colorHexToRGB(foregroundColor);
            var backgroundRGB = colorHexToRGB(backgroundColor);
            var finalRed = Math.round(foregroundRGB.r * (1 - opacity) + backgroundRGB.r * opacity);
            var finalGreen = Math.round(foregroundRGB.g * (1 - opacity) + backgroundRGB.g * opacity);
            var finalBlue = Math.round(foregroundRGB.b * (1 - opacity) + backgroundRGB.b * opacity);
            return colorRGBToHex(finalRed, finalGreen, finalBlue);
        }

        function colorRGBToHex(red, green, blue) {
            if (red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255) {
                alert("Invalid color value passed. Should be between 0 and 255.");
            }
            var formatHex = function (value) {
                value = value + "";
                if (value.length == 1) {
                    return "0" + value;
                }
                return value;
            }
            hexRed = formatHex(red.toString(16));
            hexGreen = formatHex(green.toString(16));
            hexBlue = formatHex(blue.toString(16));

            return "#" + hexRed + hexGreen + hexBlue;
        }
    
        function ColorLuminance(hex, lum) {
            // validate hex string
            hex = String(hex).replace(/[^0-9a-f]/gi, '');
            if (hex.length < 6) {
                hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
            }
            lum = lum || 0;
            // convert to decimal and change luminosity
            var rgb = "#", c, i;
            for (i = 0; i < 3; i++) {
                c = parseInt(hex.substr(i * 2, 2), 16);
                c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
                rgb += ("00" + c).substr(c.length);
            }
            return rgb;
        }

		function showmyinfo(event,code){
		    var oJSON_DataTable_DataHolder = document.getElementById("JSON_DataTable_DataHolder");
		    var oJSON_DataTable_DataHolder2 = document.getElementById("JSON_DataTable_DataHolder2");
            var oJSON = eval("(" + oJSON_DataTable_DataHolder.value + ")");
            var oJSON2 = eval("(" + oJSON_DataTable_DataHolder2.value + ")");
            var len = oJSON.TABLE[0].ROW.length;
            var len2 = oJSON2.TABLE[0].ROW.length;
			var detail='';
			for (var i = 0; i < len; i++) {
				if (code==oJSON.TABLE[0].ROW[i].COL[0].DATA)
				{
				  var num=oJSON.TABLE[0].ROW[i].COL[2].DATA;
				  var pname=oJSON.TABLE[0].ROW[i].COL[1].DATA;
				  var found=1;
				  break;
				}
			}
			for (var i = 0; i < len2; i++) {
				if (code==oJSON2.TABLE[0].ROW[i].COL[0].DATA)
				{
				   detail=detail+'<li>'+oJSON2.TABLE[0].ROW[i].COL[1].DATA+'</li>';
				  //break;
				}
			}
				if (found==1)
				{
					$('#location').html('<h3>'+pname+num+'家企业：</h3><ul>'+ detail +'</ul>');
				}
		}

        $(function () {

            var oJSON_DataTable_DataHolder = document.getElementById("JSON_DataTable_DataHolder");
            var oJSON = eval("(" + oJSON_DataTable_DataHolder.value + ")");
            var len = oJSON.TABLE[0].ROW.length;
            var tmp = new Array();
            var divisor = oJSON.TABLE[0].ROW[0].COL[2].DATA * 1.00;
            for (var i = 0; i < len; i++) {
                var obj = {
                    cha: oJSON.TABLE[0].ROW[i].COL[0].DATA,
                    name: oJSON.TABLE[0].ROW[i].COL[1].DATA,
                    des: "<br/>" + oJSON.TABLE[0].ROW[i].COL[2].DATA + "家企业",
                    //lum: 1.00 - (oJSON.TABLE[0].ROW[i].COL[2].DATA * 1.00 / divisor),
                    opacity: 1.00 - oJSON.TABLE[0].ROW[i].COL[2].DATA * 1.00 / divisor
                };
                tmp.push(obj);
            }
            //数据可以动态生成，格式自己定义，cha对应china-zh.js中省份的简称
            var dataStatus = tmp;
            var map = $('#container').vectorMap({ 
                map: 'china_zh',
                color: "#B4B4B4", //地图颜色
                onLabelShow: function (event, label, code) {//动态显示内容
                    $.each(dataStatus, function (i, items) {
                        if (code == items.cha) {
                            label.html(items.name + items.des);
                        }
                    });
                },
				onRegionClick: showmyinfo 
            })
            $.each(dataStatus, function (i, items) {
                //if (items.des.indexOf('家') != -1) {//动态设定颜色，此处用了自定义简单的判断
                    //var josnStr = "{" + items.cha + ":'#00FF00'}";
                    //var josnStr = "{" + items.cha + ":'" + ColorLuminance("009900", items.lum) + "'}";
                    var josnStr = "{" + items.cha + ":'" + ColorOpacity("#009900", "#d3d3d3", items.opacity) + "'}";
                    //alert(items.opacity);
                    $('#container').vectorMap('set', 'colors', eval('(' + josnStr + ')'));
                //}
            });
            $('.jvectormap-zoomin').click(); //放大
        });
      
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>        
        <asp:HiddenField ID="JSON_DataTable_DataHolder" runat="server" />
    </div>
    <div>        
        <asp:HiddenField ID="JSON_DataTable_DataHolder2" runat="server" />
    </div>
    <div id="container" style="margin-left: 10px; padding-top: 10px; padding-left: 0px;
        background: white; width: 800px; height: 500px;float:left">
    </div>
    <div id="location"  style="margin-left: 10px; padding-top: 10px; padding-right: 10px;
        background: white; width:220px; height: 500px;float:right">
    </div>
    </form>
</body>
</html>
