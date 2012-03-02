define(['views/album'], function(AlbumView){
	var AlbumsView = Backbone.View.extend({
		el: $("#content-list"),
		initialize: function() {
			console.log("albums view initialized");
			this.collection.bind('add', this.addAlbum, this);
			this.collection.bind('reset', this.render);
			this.collection.add([
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
			this.collection.each(this.addAlbum);
			return this
		},
	});
	return AlbumsView;
});