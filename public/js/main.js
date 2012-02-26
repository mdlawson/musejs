$(function(){
	_.templateSettings = {
		interpolate : /\{\{(.+?)\}\}/g
	};
	window.Album = Backbone.Model.extend({});
	window.AlbumList = Backbone.Collection.extend({
		model: Album
	});
	window.Albums = new AlbumList;
	window.AlbumView = Backbone.View.extend({
		tagName: "li",
		className: "album",
		template: _.template($("#album-template").html()),
		initialize: function () {
			_.bindAll(this, 'render');
			this.model.bind('change', this.render);
			this.model.bind('destroy', this.remove);
		},
		render: function() {
			$(this.el).html(this.template(this.model.toJSON()))
			return this;
		},

	});
	window.AlbumsView = Backbone.View.extend({
		collection: Albums,
		el: $("#content-list"),
		initialize: function() {
			_.bindAll(this, 'render')
			this.collection.bind('reset', this.render)
		},
		render: function() {
			this.collection.each(function(album) {
				var view = new AlbumView({
					model: album
				});
				this.$el.append(view.render().el)
			});
		}
	});
	window.BrowserView = Backbone.View.extend({
		el: $("#browserView"),
		//template: _.template($("#brower-template").html())
	})
})



