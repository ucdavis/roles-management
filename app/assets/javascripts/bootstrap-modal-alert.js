// Uses Twitter Bootstrap modal to replace built-in alert()
function bootstrap_modal_alert(text, options, callback) {
  var template = '<div class="container"><div id="_bootstrap_modal_alert_container"> \
  <div class="modal" id="_bootstrap_modal_alert_modal"> \
  <div class="modal-header"> \
    <a class="close" data-dismiss="modal">×</a> \
    <h3>Confirm</h3> \
  </div> \
  <div class="modal-body"> \
  <p>' + text + '</p> \
  </div> \
  <div class="modal-footer"> \
    <a href="#" class="btn" data-dismiss="modal">' + options['textNo'] + '</a> \
    <a href="#" class="btn btn-primary" id="save">' + options['textYes'] + '</a> \
  </div> \
  </div></div></div>';
  
  var existing_modals = $("div.modal");
  
  // If there's an existing modal, knock it's z-index down a bit to put it in the background
  if(existing_modals.length) {
    $(existing_modals).css("z-index", 1000);
  }

  // Insert the modal into the DOM
  // TODO: This assumes usage of .container-fluid. That's not always the case but there's CSS woes if you do 'body:last-child'
  if($(".container-fluid").length) {
    $(template).insertAfter(".container-fluid:last>:last-child");
  } else {
    $(template).insertAfter(".container:last>:last-child");
  }
  $("#_bootstrap_modal_alert_container").modal();
  
  $(document).ready(function() {
    $("#_bootstrap_modal_alert_container a.btn-primary").click(function() {
      callback(true);
      $("#_bootstrap_modal_alert_container").modal('hide');
      $("#_bootstrap_modal_alert_container").remove();
      
      // Restore any existing modals z-index (so they're not faded out)
      if(existing_modals.length) {
        $(existing_modals).css("z-index", 1050);
      }
    });
    
    $("#_bootstrap_modal_alert_container a.btn:first").click(function() {
      callback(false);
      $("#_bootstrap_modal_alert_container").modal('hide');
      $("#_bootstrap_modal_alert_container").remove();
      
      // Restore any existing modals z-index (so they're not faded out)
      if(existing_modals.length) {
        $(existing_modals).css("z-index", 1050);
      }
    });
  });
}
