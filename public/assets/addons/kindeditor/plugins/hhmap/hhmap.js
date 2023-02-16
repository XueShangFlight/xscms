KindEditor.plugin('hhmap', function(K) {
	var self = this, name = 'hhmap';
	self.clickToolbar(name, function() {
	  if ($("#hhmapmodal").length > 0) {
		var url = $("#hhmapmodal").data('url');
		$(".iframehhmap").attr('src',url);
	    $("#hhmapmodal").modal('show');
	  }
	});
});