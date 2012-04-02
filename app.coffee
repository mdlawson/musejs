# Module dependencies.

express = require 'express'
bio = require 'backbone.io'

app = module.exports = express.createServer();

# Configuration

app.configure ->
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use (require 'express-coffee') {path: __dirname + '/public'}
	app.use express.static __dirname + '/public'

app.configure 'development', ->
	app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', ->
	app.use express.errorHandler()

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

backend = bio.createBackend()

backend.use (req,res, next) ->
	console.log req.backend
	console.log req.method
	console.log JSON.stringify req.model
	next()

backend.use bio.middleware.memoryStore()
bio.listen app, { db: backend }