//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require_self

// Template-wide Javascript (setting up tabs, buttons, common callbacks, etc.)
(function (template, $, undefined) {
  // 'scope' allows setup of a sidebar within a portion of the DOM. Optional.
  template.setup_sidebar = function (scope) {
    scope = typeof(scope) != 'undefined' ? scope : $(document);
    
    // Hide all sidebar content
    scope.find(".sidebar_content").hide();
    
    // Open a specific tab based on anchors in the URL.
  	if(window.location.hash && window.location.hash.match('sb')) {
  		scope.find("ul.sidemenu li a[href="+window.location.hash+"]").parent().addClass("active").show();
  		scope.find(".block .sidebar_content#"+window.location.hash).show();
  	} else {
  		scope.find("ul.sidemenu li:first-child").addClass("active").show();
  		scope.find(".block .sidebar_content:first").show();
  	}

  	scope.find("ul.sidemenu li").click(function() {
  		var activeTab = $(this).find("a").attr("href");
  		window.location.hash = activeTab;
	
  		$(this).parent().find('li').removeClass("active");
  		$(this).addClass("active");
  		$(this).parents('.block').find(".sidebar_content").hide();			
  		$(activeTab).show();
      
  		return false;
  	});
  }
  
  template.status_text = function(message) {
    $("div.status_bar").show().html(message);
  }
  
  template.hide_status = function() {
    $("div.status_bar").hide();
  }
  
  template.setup_default_text = function(scope) {
    scope = typeof(scope) != 'undefined' ? scope : $(document);
    
    scope.on("focus", "input[data-default-text]", function(srcc) {
      if($(this).attr("readonly") != "readonly") {
        if($(this).val() == $($(this)[0]).attr("data-default-text")) {
          $(this).removeClass("default_text_active");
          $(this).val("");
        }
      }
    });
    scope.on("blur", "input[data-default-text]", function() {
      if ($(this).val() == "") {
        $(this).addClass("default_text_active");
        $(this).val($($(this)[0]).attr("data-default-text"));
      }
    });
    scope.find("input[data-default-text]").each(function() {
    	$(this).blur();
    });
  }
} (window.template = window.template || {}, jQuery));

// For dynamic, nested attribute add/remove
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().prev().children("tbody").append(content.replace(regexp, new_id));
}

$(function() {
  // Set up the token inputs
  $("#role_people_tokens").tokenInput($("#role_people_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#role_people_tokens").data("pre"),
    theme: "facebook"
  });

  $("#role_group_tokens").tokenInput($("#role_group_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#role_group_tokens").data("pre"),
    theme: "facebook"
  });

  $("#application_ou_tokens").tokenInput($("#application_ou_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#application_ou_tokens").data("pre"),
    theme: "facebook"
  });
  
  $("#ou_parent_tokens").tokenInput($("#ou_parent_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#ou_parent_tokens").data("pre"),
    theme: "facebook"
  });

  $("#ou_manager_tokens").tokenInput($("#ou_manager_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#ou_manager_tokens").data("pre"),
    theme: "facebook"
  });

  $("#classification_title_tokens").tokenInput($("#classification_title_tokens").attr("method") + ".json", {
    crossDomain: false,
    prePopulate: $("#classification_title_tokens").data("pre"),
    theme: "facebook"
  });
  
  // /people/new/:loginid specific
  $("input[name=fetch_ldap_details]").click(function() {
    var loginid = $("input[name=fetch_ldap_details_field]").val();
    document.location.href = document.location.href + "/" + loginid;
  });
	
	template.setup_sidebar();
  template.setup_default_text();
	
	// Search
	$('form.search .text').bind('click', function() { $(this).attr('value', ''); }).on('keyup', function(el) {
    var value = $(this).val();
    
    // Show all first
    $(this).parent().parent().children("ul.pins").children("li").show();
    
    // Hide whatever doesn't match the search term
    if(value != "") {
      $.each($(this).parent().parent().children("ul.pins").children("li"), function(el) {
        // Don't filter the 'Create new group' pin
        if($(this).attr("class") != "new") {
          var regex = new RegExp("^" + value + ".*$", "i");
          if($(this).attr("data-search-value").match(regex) == null) {
            $(this).hide();
          }
        }
      });
    }
  });
	
  // Fix AJAX headers
  $.ajaxSetup({
    beforeSend: function (xhr, settings) {
      xhr.setRequestHeader("accept", '*/*;q=0.5, ' + settings.accepts.script);
    }
  });
});
