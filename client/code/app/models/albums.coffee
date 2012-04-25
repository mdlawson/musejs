Album = require '/models/album'

class Albums extends Backbone.Collection
	model: Album
	backend: 'db'

module.exports = Albums