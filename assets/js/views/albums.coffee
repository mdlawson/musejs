class AlbumsView extends Backbone.View
	initialize: ->
		_.bindAll @, 'render'
		@collection.bind 'add', @addAlbum, @
		@collection.bind 'reset', @render
	addAlbum: (album) ->
		view = new AlbumView {model: album}
		$("#albums-list").append view.render().el
	render: ->
		@collection.each @addAlbum
		return @