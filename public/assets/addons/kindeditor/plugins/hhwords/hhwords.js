KindEditor.plugin('hhwords', function(K) {
	var self = this, name = 'hhwords';
	self.clickToolbar(name, function() {
		console.log('hhwords');
	    if ($("#hhwords").length > 0) {
		  $("#hhwords").modal('show');
	   }
	});
});