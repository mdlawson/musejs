#= require libs
#= require uploader

$(document).ready ->

	class Track extends Backbone.Model

	class TrackView extends Backbone.View
		tagName: "li"
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

	class Tracks extends Backbone.Collection
		model: Track

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
			@collection.bind 'add', @renderAlbum, @
			@collection.bind 'reset', @render
		renderAlbum: (album) ->
			view = new AlbumView {model: album}
			$("#albums-list").append view.render().el
		render: ->
			@collection.each @renderAlbum
			return @

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

	class Player extends Backbone.View
		el: $ "#player"
		template: _.template $("#playerTemplate").html()
		initialize: ->
			@playlist = new PlaylistView {el: "#player .tracks"}
			@render()
		render: ->
			@data = if (@playlist.collection.at 0)? then (@playlist.collection.at 0).toJSON() else {title:"",artist:""}
			$("#currentinfo").html @template @data
	
	class Playlist extends Backbone.Collection
		model: Track

	class PlaylistView extends Backbone.View
		initialize: ->
			@collection = new Playlist
			_.bindAll @, 'render'
			@collection.bind 'add', @renderTrack, @
			@collection.bind 'reset', @render
		renderTrack: (track) ->
			view = new TrackView {model: track}
			$(@el).append view.render().el
		render: ->
			@collection.each @renderTrack
			return @

	class App extends Backbone.Router
		initialize: ->
			@browser = new Browser
			@player = new Player
	
	window.app = new App