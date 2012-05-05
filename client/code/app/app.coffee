class App
	constructor: ->
		Browser = require '/views/browser'
		Player = require '/views/player'
		
		@browser = new Browser
		@player = new Player
		return @

app = new App

module.exports = app