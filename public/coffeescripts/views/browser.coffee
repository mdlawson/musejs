define ['jquery', 'lib/underscore', 'lib/backbone', 'collections/albums', 'views/albums'], ($,_,backbone,Albums,AlbumsView) ->
	class BrowserView extends Backbone.View
		el: $ "#browserView"
		initialize: ->
			@collection = new Albums
			@view = new AlbumsView { collection: @collection }