class Player extends Backbone.View
	el: $ "#player"
	template: _.template $("#playerTemplate").html()
	initialize: ->
		@render()
	render: ->
		@$el.html @template