define(function(){
	var AlbumView = Backbone.View.extend({
		tagName: "li",
		className: "album",
		template: _.template($("#albumTemplate").html()),
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
	return AlbumView;
});