Track = require '/models/track'

class Playlist extends Backbone.Collection
	model: Track

module.exports = Playlist