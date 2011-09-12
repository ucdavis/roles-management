/**
 * --------------------------------------------------------------------
 * jQuery-Plugin "pngFix"
 * Version: 1.2, 09.03.2009
 * by Andreas Eberhard, andreas.eberhard@gmail.com
 *                      http://jquery.andreaseberhard.de/
 *
 * Copyright (c) 2007 Andreas Eberhard
 * Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)
 *
 * Changelog:
 *    09.03.2009 Version 1.2
 *    - Update for jQuery 1.3.x, removed @ from selectors
 *    11.09.2007 Version 1.1
 *    - removed noConflict
 *    - added png-support for input type=image
 *    - 01.08.2007 CSS background-image support extension added by Scott Jehl, scott@filamentgroup.com, http://www.filamentgroup.com
 *    31.05.2007 initial Version 1.0
 * --------------------------------------------------------------------
 * @example $(function(){$(document).pngFix();});
 * @desc Fixes all PNG's in the document on document.ready
 *
 * jQuery(function(){jQuery(document).pngFix();});
 * @desc Fixes all PNG's in the document on document.ready when using noConflict
 *
 * @example $(function(){$('div.examples').pngFix();});
 * @desc Fixes all PNG's within div with class examples
 *
 * @example $(function(){$('div.examples').pngFix( { blankgif:'ext.gif' } );});
 * @desc Fixes all PNG's within div with class examples, provides blank gif for input with png
 * --------------------------------------------------------------------
 */
(function(a){jQuery.fn.pngFix=function(a){a=jQuery.extend({blankgif:"blank.gif"},a);var b=navigator.appName=="Microsoft Internet Explorer"&&parseInt(navigator.appVersion)==4&&navigator.appVersion.indexOf("MSIE 5.5")!=-1,c=navigator.appName=="Microsoft Internet Explorer"&&parseInt(navigator.appVersion)==4&&navigator.appVersion.indexOf("MSIE 6.0")!=-1;return jQuery.browser.msie&&(b||c)&&(jQuery(this).find("img[src$=.png]").each(function(){jQuery(this).attr("width",jQuery(this).width()),jQuery(this).attr("height",jQuery(this).height());var a="",b="",c=jQuery(this).attr("id")?'id="'+jQuery(this).attr("id")+'" ':"",d=jQuery(this).attr("class")?'class="'+jQuery(this).attr("class")+'" ':"",e=jQuery(this).attr("title")?'title="'+jQuery(this).attr("title")+'" ':"",f=jQuery(this).attr("alt")?'alt="'+jQuery(this).attr("alt")+'" ':"",g=jQuery(this).attr("align")?"float:"+jQuery(this).attr("align")+";":"",h=jQuery(this).parent().attr("href")?"cursor:hand;":"";this.style.border&&(a+="border:"+this.style.border+";",this.style.border=""),this.style.padding&&(a+="padding:"+this.style.padding+";",this.style.padding=""),this.style.margin&&(a+="margin:"+this.style.margin+";",this.style.margin="");var i=this.style.cssText;b+="<span "+c+d+e+f,b+='style="position:relative;white-space:pre-line;display:inline-block;background:transparent;'+g+h,b+="width:"+jQuery(this).width()+"px;"+"height:"+jQuery(this).height()+"px;",b+="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+jQuery(this).attr("src")+"', sizingMethod='scale');",b+=i+'"></span>',a!=""&&(b='<span style="position:relative;display:inline-block;'+a+h+"width:"+jQuery(this).width()+"px;"+"height:"+jQuery(this).height()+"px;"+'">'+b+"</span>"),jQuery(this).hide(),jQuery(this).after(b)}),jQuery(this).find("*").each(function(){var a=jQuery(this).css("background-image");if(a.indexOf(".png")!=-1){var b=a.split('url("')[1].split('")')[0];jQuery(this).css("background-image","none"),jQuery(this).get(0).runtimeStyle.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+b+"',sizingMethod='scale')"}}),jQuery(this).find("input[src$=.png]").each(function(){var b=jQuery(this).attr("src");jQuery(this).get(0).runtimeStyle.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+b+"', sizingMethod='scale');",jQuery(this).attr("src",a.blankgif)})),jQuery}})(jQuery)