KindEditor.plugin('hhtpl', function(K) {
	var self = this, name = 'hhtpl';
	self.clickToolbar(name, function() {
	  if ($("#hhtpl").length > 0) {
	    $("#hhtpl").modal('show');
	  }
	});
});