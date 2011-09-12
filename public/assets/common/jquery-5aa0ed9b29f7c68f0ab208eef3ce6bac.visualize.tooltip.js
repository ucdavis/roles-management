/**
 * --------------------------------------------------------------------
 * Tooltip plugin for the jQuery-Plugin "Visualize"
 * Tolltip by Iraê Carvalho, irae@irae.pro.br, http://irae.pro.br/en/
 * Copyright (c) 2010 Iraê Carvalho
 * Dual licensed under the MIT (filamentgroup.com/examples/mit-license.txt) and GPL (filamentgroup.com/examples/gpl-license.txt) licenses.
 * 	
 * Visualize plugin by Scott Jehl, scott@filamentgroup.com
 * Copyright (c) 2009 Filament Group, http://www.filamentgroup.com
 *
 * --------------------------------------------------------------------
 */
(function(a){a.visualizePlugins.push(function b(b,c){var d=a.extend({tooltip:!1,tooltipalign:"auto",tooltipvalign:"top",tooltipclass:"visualize-tooltip",tooltiphtml:function(a){if(b.multiHover){var c="";for(var d=0;d<a.point.length;d++)c+="<p>"+a.point[d].value+" - "+a.point[d].yLabels[0]+"</p>";return c}return"<p>"+a.point.value+" - "+a.point.yLabels[0]+"</p>"},delay:!1},b);if(!d.tooltip)return;var e=a(this),f=e.next(),g=f.find(".visualize-scroller"),h=g.width(),i=f.find(".visualize-interaction-tracker");i.css({backgroundColor:"white",opacity:0,zIndex:100});var j=a('<div class="'+d.tooltipclass+'"/>').css({position:"absolute",display:"none",zIndex:90}).insertAfter(g.find("canvas")),k=!0;typeof G_vmlCanvasManager!="undefined"&&(g.css({position:"absolute"}),i.css({marginTop:"-"+d.height+"px"})),e.bind("vizualizeOver",function l(b,c){if(c.canvasContain.get(0)!=f.get(0))return;if(d.multiHover)var e=c.point[0].canvasCords;else var e=c.point.canvasCords;var i,l,m,n,p,q,r=Math.round(e[0]+c.tableData.zeroLocX),s=Math.round(e[1]+c.tableData.zeroLocY);if(d.tooltipalign=="left"||d.tooltipalign=="auto"&&r-g.scrollLeft()<=h/2){!a.browser.msie||a.browser.version!=7&&a.browser.version!=6?k=!0:k=!1,i=r-(k?g.scrollLeft():0);if(r-g.scrollLeft()<0)return;i=i+"px",l="",clasAdd="tooltipleft",n="tooltipright"}else{a.browser.msie&&a.browser.version==7?k=!1:k=!0,l=Math.abs(r-d.width)-(d.width-(k?g.scrollLeft():0)-h);if(Math.abs(r-d.width)-(d.width-g.scrollLeft()-h)<0)return;i="",l=l+"px",clasAdd="tooltipright",n="tooltipleft"}j.addClass(clasAdd).removeClass(n).html(d.tooltiphtml(c)).css({display:"block",top:s+"px",left:i,right:l})}),e.bind("vizualizeOut",function(a,b){j.css({display:"none"})})})})(jQuery)