/*jquery.select_skin.js */
/*
 * jQuery select element skinning
 * version: 1.0.4 (03/03/2009)
 * @requires: jQuery v1.2 or later
 * adapted from Derek Harvey code
 *   http://www.lotsofcode.com/javascript-and-ajax/jquery-select-box-skin.htm
 * Licensed under the GPL license:
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Copyright 2009 Colin Verot
 */
(function(a){a.fn.select_skin=function(b){return a(this).each(function(b){s=a(this);if(!s.attr("multiple")){s.wrap('<div class="cmf-skinned-select"></div>'),c=s.parent(),c.children().before('<div class="cmf-skinned-text">&nbsp;</div>').each(function(){this.selectedIndex>=0&&a(this).prev().text(this.options[this.selectedIndex].innerHTML)}),c.width(s.outerWidth()-2),c.height(s.outerHeight()-2),c.css("background-color",s.css("background-color")),c.css("color",s.css("color")),c.css("font-size",s.css("font-size")),c.css("font-family",s.css("font-family")),c.css("font-style",s.css("font-style")),c.css("position","relative"),s.css({opacity:0,position:"relative","z-index":100});var d=c.children().prev();d.height(c.outerHeight()-s.css("padding-top").replace(/px,*\)*/g,"")-s.css("padding-bottom").replace(/px,*\)*/g,"")-d.css("padding-top").replace(/px,*\)*/g,"")-d.css("padding-bottom").replace(/px,*\)*/g,"")-2),d.width(c.innerWidth()-s.css("padding-right").replace(/px,*\)*/g,"")-s.css("padding-left").replace(/px,*\)*/g,"")-d.css("padding-right").replace(/px,*\)*/g,"")-d.css("padding-left").replace(/px,*\)*/g,"")-c.innerHeight()),d.css({opacity:100,overflow:"hidden",position:"absolute","text-indent":"0px","z-index":1,top:0,left:0}),c.children().click(function(){d.text(this.options.length>0&&this.selectedIndex>=0?this.options[this.selectedIndex].innerHTML:"")}),c.children().change(function(){d.text(this.options.length>0&&this.selectedIndex>=0?this.options[this.selectedIndex].innerHTML:"")})}})}})(jQuery)