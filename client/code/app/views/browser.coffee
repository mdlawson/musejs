AlbumsView = require '/views/albums'

class Browser extends Backbone.View
	el: $("#browserView")
	template: _.template $("#browserTemplate").html()
	initialize: ->
		@render()
	render: ->
		@$el.html @template {name: "albums"}
		@view = new AlbumsView

module.exports = Browser