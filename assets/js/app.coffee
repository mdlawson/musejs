#= require libs

$(document).ready ->

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
			@$el.html @template @model.toJSON()
			return @
		remove: ->
			@$el.remove()

	class Albums extends Backbone.Collection
		model: Album
		backend: 'db'
		initialize: ->
    		@bindBackend();

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

	class BrowserView extends Backbone.View
		el: $ "#browserView"
		template: _.template $("#browserTemplate").html()
		initialize: ->
			@collection = new Albums
			@collection.fetch()
			@render()
		render: ->
			@$el.html @template {name: "albums"}
			@view = new AlbumsView { collection: @collection }

	class Player extends Backbone.View
		el: $ "#player"
		template: _.template $("#playerTemplate").html()
		initialize: ->
			@render()
		render: ->
			@$el.html @template

	class App extends Backbone.Router
		initialize: ->
			@browser = new BrowserView
			@player = new Player
	
	window.app = new App