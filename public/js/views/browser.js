define(['views/albums', 'collections/albums'], function(AlbumsView , AlbumList){
	var BrowserView = Backbone.View.extend({
		el: $("#browserView"),
		initialize: function() {
			var albums = new AlbumList;
			this.browser = new AlbumsView({collection : albums});
		}
	});
	return BrowserView;
});