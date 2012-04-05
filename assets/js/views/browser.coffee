class Browser extends Backbone.View
	el: $ "#browserView"
	template: _.template $("#browserTemplate").html()
	initialize: ->
		@collection = new Albums
		@collection.fetch()
		@render()
	render: ->
		@$el.html @template {name: "albums"}
		@view = new AlbumsView { collection: @collection }