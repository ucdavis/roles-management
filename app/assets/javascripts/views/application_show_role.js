DssRm.Views.ApplicationShowRole = Support.CompositeView.extend({
  tagName: "tr",
  className: "fields",
  
  events: {
    "blur input[name=name]" : "autofillEmptyToken"
  },

  render: function () {
    this.$el.html(JST['applications/show_role']({ role: this.model }));
    this.$('input[name=token]').val(this.model.escape('token'));
    
    // If this is a new role, we will attempt to automatically generate a token
    if(this.model.escape('token').length == 0) this.$('input[name=token]').data('autofill', true);
    
    if(this.model.get('default')) this.$('input[name=default]').attr("checked", "checked");
    this.$('input[name=name]').val(this.model.escape('name'));
    this.$('input[name=description]').val(this.model.escape('description'));
    this.$el.data("role_id", this.model.escape('id'));

    return this;
  },
  
  autofillEmptyToken: function(e) {
    var roleName = $(e.target).val();
    var $tokenInput = $(e.target).parents("tr").find("input[name=token]");
    
    if($tokenInput.data('autofill')) {
      $tokenInput.val(this.model.tokenize(roleName));
      $tokenInput.trigger('change');
    }
    
    return true;
  }
});
