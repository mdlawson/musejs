Albums = require '/models/albums'
AlbumView = require '/views/album'

class AlbumsView extends Backbone.View
	initialize: ->
		@collection = new Albums
		@collection.fetch()
		_.bindAll @, 'render'
		@collection.bind 'add', @renderAlbum, @
		@collection.bind 'reset', @render
	renderAlbum: (album) ->
		view = new AlbumView {model: album}
		$("#albums-list").append view.render().el
	render: ->
		@collection.each @renderAlbum
		return @

module.exports = AlbumsView