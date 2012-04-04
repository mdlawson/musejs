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