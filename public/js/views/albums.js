define(['views/album'], function(AlbumView){
	var AlbumsView = Backbone.View.extend({
		el: $("#content-list"),
		initialize: function() {
			console.log("albums view initialized");
			albums.bind('add', this.addAlbum, this);
			albums.bind('reset', this.render);
			albums.add([
				{name: "test1", artist: "artist1"},
				{name: "test2", artist: "artist2"}
			]);
		},
		addAlbum: function(album) {
			var view = new AlbumView({ model: album });
			$("#content-list").append(view.render().el);
		},
		render: function() {
			$("#content-list").empty();
			albums.each(this.addAlbum);
			return this
		},
	});
	return AlbumsView;
});