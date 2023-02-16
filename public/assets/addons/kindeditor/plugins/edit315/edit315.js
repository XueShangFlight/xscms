KindEditor.plugin('edit315', function(K) {
	var self = this, name = 'edit315';
	self.clickToolbar(name, function() {
	  if ($("#edit135modal").length > 0) {
		var url = $("#edit135modal").data('url');
		$(".iframeedit").attr('src',url);
		$("#edit135modal").modal('show');
	  }
	});
});