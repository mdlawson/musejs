$(document).ready ->
	console.log "main started"

	class Album extends Backbone.Model

	class AlbumView extends Backbone.View
		tagName: "li"
		className: "album"
		template: _.template $("#albumTemplate").html()
		initialize: ->
			_.bindAll @,'render'
			@model.bind 'change', @render
			@model.bind 'remove', @remove, @
		render: ->
			$(@el).html @template @model.toJSON()
			return @
		remove: ->
			$(@el).remove()

	class Albums extends Backbone.Collection
		model: Album
		backend: 'db'

	class AlbumsView extends Backbone.View
		el: $("#content-list")
		initialize: ->
			_.bindAll @, 'render'
			@collection.bind 'add', @addAlbum, @
			@collection.bind 'reset', @render
		addAlbum: (album) ->
			view = new AlbumView {model: album}
			$("#content-list").append view.render().el
		render: ->
			$(@el).empty()
			@collection.each @addAlbum
			return @

	class BrowserView extends Backbone.View
		el: $ "#browserView"
		initialize: ->
			@collection = new Albums
			@view = new AlbumsView { collection: @collection }

	window.app = new BrowserView