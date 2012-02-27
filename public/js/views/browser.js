define(['views/albums'], function(AlbumsView){
	var BrowserView = Backbone.View.extend({
		el: $("#browserView"),
		initialize: function() {
			this.browser = new AlbumsView;
		}
	});
	return BrowserView;
});