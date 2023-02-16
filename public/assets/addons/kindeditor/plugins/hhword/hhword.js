KindEditor.plugin('hhword', function(K) {
	var self = this, name = 'hhword';
	self.clickToolbar(name, function() {
	    if ($("#hhword").length > 0) {
		  $("#hhword").modal('show');
	   }
	});
});