$(function(){
	_.templateSettings = {
		interpolate : /\{\{(.+?)\}\}/g
	};
	window.Album = Backbone.Model.extend({});
	window.Albums = Backbone.Collection.extend({
		model: Album
	});
	window.AlbumView = Backbone.View.extend({
		tagName: "li",
		className: "album",
		template: _.template($('#album-template').html()),
		render: function() {
			$(this.el).html(this.template(this.model.toJSON()))
			return this;
		},

	})
})



