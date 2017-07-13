/*!
* jVectorMap version 0.1
*
* Copyright 2011, Kirill Lebedev
* Licensed under the MIT license.
*
*/
(function (e) { var f = { colors: 1, values: 1, backgroundColor: 1, scaleColors: 1, normalizeFunction: 1 }; var b = { onLabelShow: "labelShow", onRegionOver: "regionMouseOver", onRegionOut: "regionMouseOut", onRegionClick: "regionClick" }; e.fn.vectorMap = function (g) { var h = { map: "world_en", backgroundColor: "#ffffff", color: "#ffffff", hoverColor: "#00CCFF", scaleColors: ["#b6d6ff", "#005ace"], normalizeFunction: "linear" }, j; if (g === "addMap") { c.maps[arguments[1]] = arguments[2] } else { if (g === "set" && f[arguments[1]]) { this.data("mapObject")["set" + arguments[1].charAt(0).toUpperCase() + arguments[1].substr(1)].apply(this.data("mapObject"), Array.prototype.slice.call(arguments, 2)) } else { e.extend(h, g); h.container = this; this.css({ position: "relative", overflow: "hidden" }); j = new c(h); this.data("mapObject", j); for (var i in b) { if (h[i]) { this.bind(b[i] + ".jvectormap", h[i]) } } } } }; var d = function (h, g) { this.mode = window.SVGAngle ? "svg" : "vml"; if (this.mode == "svg") { this.createSvgNode = function (j) { return document.createElementNS(this.svgns, j) } } else { try { if (!document.namespaces.rvml) { document.namespaces.add("rvml", "urn:schemas-microsoft-com:vml") } this.createVmlNode = function (j) { return document.createElement("<rvml:" + j + ' class="rvml">') } } catch (i) { this.createVmlNode = function (j) { return document.createElement("<" + j + ' xmlns="urn:schemas-microsoft.com:vml" class="rvml">') } } document.createStyleSheet().addRule(".rvml", "behavior:url(#default#VML)") } if (this.mode == "svg") { this.canvas = this.createSvgNode("svg") } else { this.canvas = this.createVmlNode("group"); this.canvas.style.position = "absolute" } this.setSize(h, g) }; d.prototype = { svgns: "http://www.w3.org/2000/svg", mode: "svg", width: 0, height: 0, canvas: null, setSize: function (m, g) { if (this.mode == "svg") { this.canvas.setAttribute("width", m); this.canvas.setAttribute("height", g) } else { this.canvas.style.width = m + "px"; this.canvas.style.height = g + "px"; this.canvas.coordsize = m + " " + g; this.canvas.coordorigin = "0 0"; if (this.rootGroup) { var j = this.rootGroup.getElementsByTagName("shape"); for (var k = 0, h = j.length; k < h; k++) { j[k].coordsize = m + " " + g; j[k].style.width = m + "px"; j[k].style.height = g + "px" } this.rootGroup.coordsize = m + " " + g; this.rootGroup.style.width = m + "px"; this.rootGroup.style.height = g + "px" } } this.width = m; this.height = g }, createPath: function (g) { var h; if (this.mode == "svg") { h = this.createSvgNode("path"); h.setAttribute("d", g.path); h.setFill = function (k) { this.setAttribute("fill", k) }; h.getFill = function (k) { return this.getAttribute("fill") }; h.setOpacity = function (k) { this.setAttribute("fill-opacity", k) } } else { h = this.createVmlNode("shape"); h.coordorigin = "0 0"; h.coordsize = this.width + " " + this.height; h.style.width = this.width + "px"; h.style.height = this.height + "px"; h.fillcolor = c.defaultFillColor; h.stroked = false; h.path = d.pathSvgToVml(g.path); var j = this.createVmlNode("skew"); j.on = true; j.matrix = "0.01,0,0,0.01,0,0"; j.offset = "0,0"; h.appendChild(j); var i = this.createVmlNode("fill"); h.appendChild(i); h.setFill = function (k) { this.getElementsByTagName("fill")[0].color = k }; h.getFill = function (k) { return this.getElementsByTagName("fill")[0].color }; h.setOpacity = function (k) { this.getElementsByTagName("fill")[0].opacity = parseInt(k * 100) + "%" } } return h }, createGroup: function (g) { var h; if (this.mode == "svg") { h = this.createSvgNode("g") } else { h = this.createVmlNode("group"); h.style.width = this.width + "px"; h.style.height = this.height + "px"; h.style.left = "0px"; h.style.top = "0px"; h.coordorigin = "0 0"; h.coordsize = this.width + " " + this.height } if (g) { this.rootGroup = h } return h }, applyTransformParams: function (i, h, g) { if (this.mode == "svg") { this.rootGroup.setAttribute("transform", "scale(" + i + ") translate(" + h + ", " + g + ")") } else { this.rootGroup.coordorigin = (this.width - h) + "," + (this.height - g); this.rootGroup.coordsize = this.width / i + "," + this.height / i } } }; d.pathSvgToVml = function (k) { var h = ""; var g = 0, l = 0, j, i; return k.replace(/([MmLlHhVvCcSs])((?:-?(?:\d+)?(?:\.\d+)?,?\s?)+)/g, function (q, p, r, n) { r = r.replace(/(\d)-/g, "$1,-").replace(/\s+/g, ",").split(","); if (!r[0]) { r.shift() } for (var o = 0, m = r.length; o < m; o++) { r[o] = Math.round(100 * r[o]) } switch (p) { case "m": g += r[0]; l += r[1]; return "t" + r.join(","); break; case "M": g = r[0]; l = r[1]; return "m" + r.join(","); break; case "l": g += r[0]; l += r[1]; return "r" + r.join(","); break; case "L": g = r[0]; l = r[1]; return "l" + r.join(","); break; case "h": g += r[0]; return "r" + r[0] + ",0"; break; case "H": g = r[0]; return "l" + g + "," + l; break; case "v": l += r[0]; return "r0," + r[0]; break; case "V": l = r[0]; return "l" + g + "," + l; break; case "c": j = g + r[r.length - 4]; i = l + r[r.length - 3]; g += r[r.length - 2]; l += r[r.length - 1]; return "v" + r.join(","); break; case "C": j = r[r.length - 4]; i = r[r.length - 3]; g = r[r.length - 2]; l = r[r.length - 1]; return "c" + r.join(","); break; case "s": r.unshift(l - i); r.unshift(g - j); j = g + r[r.length - 4]; i = l + r[r.length - 3]; g += r[r.length - 2]; l += r[r.length - 1]; return "v" + r.join(","); break; case "S": r.unshift(l + l - i); r.unshift(g + g - j); j = r[r.length - 4]; i = r[r.length - 3]; g = r[r.length - 2]; l = r[r.length - 1]; return "c" + r.join(","); break } return "" }).replace(/z/g, "") }; var c = function (k) { k = k || {}; var i = this; var j = c.maps[k.map]; this.container = k.container; this.defaultWidth = j.width; this.defaultHeight = j.height; this.color = k.color; this.hoverColor = k.hoverColor; this.setBackgroundColor(k.backgroundColor); this.width = k.container.width(); this.height = k.container.height(); this.resize(); e(window).resize(function () { i.width = k.container.width(); i.height = k.container.height(); i.resize(); i.canvas.setSize(i.width, i.height); i.applyTransform() }); this.canvas = new d(this.width, this.height); k.container.append(this.canvas.canvas); this.makeDraggable(); this.rootGroup = this.canvas.createGroup(true); this.index = c.mapIndex; this.label = e("<div/>").addClass("jvectormap-label").appendTo(e("body")); e("<div/>").addClass("jvectormap-zoomin").text("+").appendTo(k.container); e("<div/>").addClass("jvectormap-zoomout").html("&#x2212;").appendTo(k.container); for (var g in j.pathes) { var h = this.canvas.createPath({ path: j.pathes[g].path }); h.setFill(this.color); h.id = "jvectormap" + i.index + "_" + g; i.countries[g] = h; e(this.rootGroup).append(h) } e(k.container).delegate(this.canvas.mode == "svg" ? "path" : "shape", "mouseover mouseout", function (p) { var o = p.target, m = p.target.id.split("_").pop(), l = e.Event("labelShow.jvectormap"), n = e.Event("regionMouseOver.jvectormap"); if (p.type == "mouseover") { e(k.container).trigger(n, [m]); if (!n.isDefaultPrevented()) { if (k.hoverOpacity) { o.setOpacity(k.hoverOpacity) } if (k.hoverColor) { o.currentFillColor = o.getFill() + ""; o.setFill(k.hoverColor) } } i.label.html(j.pathes[m].name); e(k.container).trigger(l, [i.label, m]); if (!l.isDefaultPrevented()) { i.label.show(); i.labelWidth = i.label.width(); i.labelHeight = i.label.height() } } else { o.setOpacity(1); if (o.currentFillColor) { o.setFill(o.currentFillColor) } i.label.hide(); e(k.container).trigger("regionMouseOut.jvectormap", [m]) } }); e(k.container).delegate(this.canvas.mode == "svg" ? "path" : "shape", "click", function (n) { var m = n.target; var l = n.target.id.split("_").pop(); e(k.container).trigger("regionClick.jvectormap", [l]) }); k.container.mousemove(function (l) { if (i.label.is(":visible")) { i.label.css({ left: l.pageX - 15 - i.labelWidth, top: l.pageY - 15 - i.labelHeight }) } }); this.setColors(k.colors); this.canvas.canvas.appendChild(this.rootGroup); this.applyTransform(); this.colorScale = new a(k.scaleColors, k.normalizeFunction, k.valueMin, k.valueMax); if (k.values) { this.values = k.values; this.setValues(k.values) } this.bindZoomButtons(); c.mapIndex++ }; c.prototype = { transX: 0, transY: 0, scale: 1, baseTransX: 0, baseTransY: 0, baseScale: 1, width: 0, height: 0, countries: {}, countriesColors: {}, countriesData: {}, zoomStep: 1.4, zoomMaxStep: 4, zoomCurStep: 1, setColors: function (i, h) { if (typeof i == "string") { this.countries[i].setFill(h) } else { var g = i; for (var j in g) { if (this.countries[j]) { this.countries[j].setFill(g[j]) } } } }, setValues: function (i) { var g = 0, j = Number.MAX_VALUE, k; for (var l in i) { k = parseFloat(i[l]); if (k > g) { g = i[l] } if (k && k < j) { j = k } } this.colorScale.setMin(j); this.colorScale.setMax(g); var h = {}; for (l in i) { k = parseFloat(i[l]); if (k) { h[l] = this.colorScale.getColor(k) } else { h[l] = this.color } } this.setColors(h); this.values = i }, setBackgroundColor: function (g) { this.container.css("background-color", g) }, setScaleColors: function (g) { this.colorScale.setColors(g); if (this.values) { this.setValues(this.values) } }, setNormalizeFunction: function (g) { this.colorScale.setNormalizeFunction(g); if (this.values) { this.setValues(this.values) } }, resize: function () { var g = this.baseScale; if (this.width / this.height > this.defaultWidth / this.defaultHeight) { this.baseScale = this.height / this.defaultHeight; this.baseTransX = Math.abs(this.width - this.defaultWidth * this.baseScale) / (2 * this.baseScale) } else { this.baseScale = this.width / this.defaultWidth; this.baseTransY = Math.abs(this.height - this.defaultHeight * this.baseScale) / (2 * this.baseScale) } this.scale *= this.baseScale / g; this.transX *= this.baseScale / g; this.transY *= this.baseScale / g }, reset: function () { this.countryTitle.reset(); for (var g in this.countries) { this.countries[g].setFill(c.defaultColor) } this.scale = this.baseScale; this.transX = this.baseTransX; this.transY = this.baseTransY; this.applyTransform() }, applyTransform: function () { var i, h, g, h; if (this.defaultWidth * this.scale <= this.width) { i = (this.width - this.defaultWidth * this.scale) / (2 * this.scale); g = (this.width - this.defaultWidth * this.scale) / (2 * this.scale) } else { i = 0; g = (this.width - this.defaultWidth * this.scale) / this.scale } if (this.defaultHeight * this.scale <= this.height) { h = (this.height - this.defaultHeight * this.scale) / (2 * this.scale); minTransY = (this.height - this.defaultHeight * this.scale) / (2 * this.scale) } else { h = 0; minTransY = (this.height - this.defaultHeight * this.scale) / this.scale } if (this.transY > h) { this.transY = h } else { if (this.transY < minTransY) { this.transY = minTransY } } if (this.transX > i) { this.transX = i } else { if (this.transX < g) { this.transX = g } } this.canvas.applyTransformParams(this.scale, this.transX, this.transY) }, makeDraggable: function () { var h = false; var i, g; var j = this; this.container.mousemove(function (m) { if (h) { var l = j.transX; var k = j.transY; j.transX -= (i - m.pageX) / j.scale; j.transY -= (g - m.pageY) / j.scale; j.applyTransform(); i = m.pageX; g = m.pageY } return false }).mousedown(function (k) { h = true; i = k.pageX; g = k.pageY; return false }).mouseup(function () { h = false; return false }) }, bindZoomButtons: function () { var h = this; var g = (e("#zoom").innerHeight() - 6 * 2 - 15 * 2 - 3 * 2 - 7 - 6) / (this.zoomMaxStep - this.zoomCurStep); this.container.find(".jvectormap-zoomin").click(function () { if (h.zoomCurStep < h.zoomMaxStep) { var j = h.transX; var i = h.transY; var k = h.scale; h.transX -= (h.width / h.scale - h.width / (h.scale * h.zoomStep)) / 2; h.transY -= (h.height / h.scale - h.height / (h.scale * h.zoomStep)) / 2; h.setScale(h.scale * h.zoomStep); h.zoomCurStep++; e("#zoomSlider").css("top", parseInt(e("#zoomSlider").css("top")) - g) } }); this.container.find(".jvectormap-zoomout").click(function () { if (h.zoomCurStep > 1) { var j = h.transX; var i = h.transY; var k = h.scale; h.transX += (h.width / (h.scale / h.zoomStep) - h.width / h.scale) / 2; h.transY += (h.height / (h.scale / h.zoomStep) - h.height / h.scale) / 2; h.setScale(h.scale / h.zoomStep); h.zoomCurStep--; e("#zoomSlider").css("top", parseInt(e("#zoomSlider").css("top")) + g) } }) }, setScale: function (g) { this.scale = g; this.applyTransform() }, getCountryPath: function (g) { return e("#" + g)[0] } }; c.xlink = "http://www.w3.org/1999/xlink"; c.mapIndex = 1; c.maps = {}; var a = function (g, h, i, j) { if (g) { this.setColors(g) } if (h) { this.setNormalizeFunction(h) } if (i) { this.setMin(i) } if (i) { this.setMax(j) } }; a.prototype = { colors: [], setMin: function (g) { this.clearMinValue = g; if (typeof this.normalize === "function") { this.minValue = this.normalize(g) } else { this.minValue = g } }, setMax: function (g) { this.clearMaxValue = g; if (typeof this.normalize === "function") { this.maxValue = this.normalize(g) } else { this.maxValue = g } }, setColors: function (g) { for (var h = 0; h < g.length; h++) { g[h] = a.rgbToArray(g[h]) } this.colors = g }, setNormalizeFunction: function (g) { if (g === "polynomial") { this.normalize = function (h) { return Math.pow(h, 0.2) } } else { if (g === "linear") { delete this.normalize } else { this.normalize = g } } this.setMin(this.clearMinValue); this.setMax(this.clearMaxValue) }, getColor: function (k) { if (typeof this.normalize === "function") { k = this.normalize(k) } var o = []; var m = 0; var g; for (var j = 0; j < this.colors.length - 1; j++) { g = this.vectorLength(this.vectorSubtract(this.colors[j + 1], this.colors[j])); o.push(g); m += g } var n = (this.maxValue - this.minValue) / m; for (j = 0; j < o.length; j++) { o[j] *= n } j = 0; k -= this.minValue; while (k - o[j] >= 0) { k -= o[j]; j++ } var h; if (j == this.colors.length - 1) { h = this.vectorToNum(this.colors[j]).toString(16) } else { h = (this.vectorToNum(this.vectorAdd(this.colors[j], this.vectorMult(this.vectorSubtract(this.colors[j + 1], this.colors[j]), (k) / (o[j]))))).toString(16) } while (h.length < 6) { h = "0" + h } return "#" + h }, vectorToNum: function (g) { var h = 0; for (var j = 0; j < g.length; j++) { h += Math.round(g[j]) * Math.pow(256, g.length - j - 1) } return h }, vectorSubtract: function (k, j) { var g = []; for (var h = 0; h < k.length; h++) { g[h] = k[h] - j[h] } return g }, vectorAdd: function (k, j) { var g = []; for (var h = 0; h < k.length; h++) { g[h] = k[h] + j[h] } return g }, vectorMult: function (h, j) { var g = []; for (var k = 0; k < h.length; k++) { g[k] = h[k] * j } return g }, vectorLength: function (h) { var g = 0; for (var j = 0; j < h.length; j++) { g += h[j] * h[j] } return Math.sqrt(g) } }; a.arrayToRgb = function (g) { var h = "#"; var k; for (var j = 0; j < g.length; j++) { k = g[j].toString(16); h += k.length == 1 ? "0" + k : k } return h }; a.rgbToArray = function (g) { g = g.substr(1); return [parseInt(g.substr(0, 2), 16), parseInt(g.substr(2, 2), 16), parseInt(g.substr(4, 2), 16)] } })(jQuery);
