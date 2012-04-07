class window.PlaylistView extends Backbone.View
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