# Module dependencies.

express = require 'express'
bio = require 'backbone.io'

app = module.exports = express.createServer();

# Express Configuration

app.configure ->
	app.set 'views', __dirname + '/views'
	app.set 'view engine', 'jade'
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use (require 'connect-assets') {buildDir: false, build: true, minifyBuilds: false, buildFilenamer: (filename, code) -> "#{filename}"}
	app.use express.static __dirname + '/public'

app.configure 'development', ->
	app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', ->
	app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.get '/', (req, res) ->
	res.render 'index'

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

# Backbone.io Configuration

backend = bio.createBackend()

backend.use (req,res, next) ->
	console.log req.backend
	console.log req.method
	console.log JSON.stringify req.model
	next()

backend.use bio.middleware.memoryStore()
io = bio.listen app, { db: backend }

# Socket.io Configuration

io.configure ->
	io.set 'transports', ['websocket']
	io.set 'log level', 2 
	io.enable 'browser client minification'
	io.enable 'browser client gzip'