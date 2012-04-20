class window.Player extends Backbone.View
	el: $ "#player"
	template: _.template $("#playerTemplate").html()
	initialize: ->
		@playlist = new PlaylistView {el: "#player .tracks"}
		@render()
	render: ->
		@data = if (@playlist.collection.at 0)? then (@playlist.collection.at 0).toJSON() else {title:"",artist:""}
		$("#currentinfo").html @template @data