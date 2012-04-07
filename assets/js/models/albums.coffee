class window.Albums extends Backbone.Collection
	model: Album
	backend: 'db'
	initialize: ->
		@bindBackend();