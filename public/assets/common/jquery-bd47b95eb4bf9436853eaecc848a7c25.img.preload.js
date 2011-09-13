/**
 * jQuery-Plugin "preloadCssImages"
 * by Scott Jehl, scott@filamentgroup.com
 * http://www.filamentgroup.com
 * reference article: http://www.filamentgroup.com/lab/update_automatically_preload_images_from_css_with_jquery/
 * demo page: http://www.filamentgroup.com/examples/preloadImages/index_v2.php
 * 
 * Copyright (c) 2008 Filament Group, Inc
 * Dual licensed under the MIT (filamentgroup.com/examples/mit-license.txt) and GPL (filamentgroup.com/examples/gpl-license.txt) licenses.
 *
 * Version: 5.0, 10.31.2008
 * Changelog:
 * 	02.20.2008 initial Version 1.0
 *    06.04.2008 Version 2.0 : removed need for any passed arguments. Images load from any and all directories.
 *    06.21.2008 Version 3.0 : Added options for loading status. Fixed IE abs image path bug (thanks Sam Pohlenz).
 *    07.24.2008 Version 4.0 : Added support for @imported CSS (credit: http://marcarea.com/). Fixed support in Opera as well. 
 *    10.31.2008 Version: 5.0 : Many feature and performance enhancements from trixta
 * --------------------------------------------------------------------
 */
jQuery.preloadCssImages=function(a){function g(){clearTimeout(f);if(d&&d.length&&d[c]){c++;if(a.statusTextEl){var b=d[c]?"Now Loading: <span>"+d[c].split("/")[d[c].split("/").length-1]:"Loading complete";jQuery(a.statusTextEl).html('<span class="numLoaded">'+c+'</span> of <span class="numTotal">'+d.length+'</span> loaded (<span class="percentLoaded">'+(c/d.length*100).toFixed(0)+'%</span>) <span class="currentImg">'+b+"</span></span>")}if(a.statusBarEl){var e=jQuery(a.statusBarEl).width();jQuery(a.statusBarEl).css("background-position",-(e-(e*c/d.length).toFixed(0))+"px 50%")}h()}}function h(){if(d&&d.length&&d[c]){var b=new Image;b.src=d[c],b.complete?g():jQuery(b).bind("error load onreadystatechange",g),f=setTimeout(g,a.errorDelay)}}function i(b,c){var f=!1,g=[],j=[],k,l=b.length;while(l--){var m="";if(c&&c[l])k=c[l];else{var n=b[l].href?b[l].href:"window.location.href",o=n.split("/");o.pop(),k=o.join("/"),k&&(k+="/")}if(b[l].cssRules||b[l].rules){e=b[l].cssRules?b[l].cssRules:b[l].rules;var p=e.length;while(p--)if(e[p].style&&e[p].style.cssText){var q=e[p].style.cssText;q.toLowerCase().indexOf("url")!=-1&&(m+=q)}else e[p].styleSheet&&(g.push(e[p].styleSheet),f=!0)}var r=m.match(/[^\("]+\.(gif|jpg|jpeg|png)/g);if(r){var s=r.length;while(s--){var t=r[s].charAt(0)=="/"||r[s].match("://")?r[s]:k+r[s];jQuery.inArray(t,d)==-1&&d.push(t)}}if(!f&&b[l].imports&&b[l].imports.length)for(var u=0,v=b[l].imports.length;u<v;u++){var w=b[l].imports[u].href;w=w.split("/"),w.pop(),w=w.join("/"),w&&(w+="/");var x=w.charAt(0)=="/"||w.match("://")?w:k+w;j.push(x),g.push(b[l].imports[u])}}if(g.length)return i(g,j),!1;var y=a.simultaneousCacheLoading;while(y--)setTimeout(h,y)}a=jQuery.extend({statusTextEl:null,statusBarEl:null,errorDelay:999,simultaneousCacheLoading:2},a);var b=[],c=0,d=[],e,f;return i(document.styleSheets),d}