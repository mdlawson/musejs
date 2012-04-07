class window.TrackView extends Backbone.View
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