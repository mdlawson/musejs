class window.Browser extends Backbone.View
	el: $("#browserView")
	template: _.template $("#browserTemplate").html()
	initialize: ->
	#	@render()
	render: ->
		@$el.html @template {name: "albums"}
		@view = new AlbumsView