app =
	initialize: ->
		Browser = require '/views/browser'
		Player = require '/views/player'
		
		@browser = new Browser
		@player = new Player
		
module.exports = app