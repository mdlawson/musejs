$(function(){
	console.log("main started")
	_.templateSettings = {
		interpolate : /\{\{(.+?)\}\}/g
	};
	window.Album = Backbone.Model.extend({});
	window.AlbumList = Backbone.Collection.extend({
		model: Album
	});
	window.albums = new AlbumList;
	window.AlbumView = Backbone.View.extend({
		tagName: "li",
		className: "album",
		template: _.template($("#album-template").html()),
		initialize: function () {
			_.bindAll(this, 'render');
			this.model.bind('change', this.render);
			this.model.bind('destroy', this.remove, this);
		},
		render: function() {
			$(this.el).html(this.template(this.model.toJSON()));
			return this;
		},
		remove: function() {
			$(this.el).remove();
		}

	});
	window.AlbumsView = Backbone.View.extend({
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
	window.BrowserView = Backbone.View.extend({
		el: $("#browserView"),
		initialize: function() {
			window.browser = new AlbumsView;
		}
	})
	window.App = new BrowserView
})



