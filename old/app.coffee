# Module dependencies.

express = require 'express'
bio = require 'backbone.io'
assets = require 'connect-assets'
mongoose = require 'mongoose'
meta = require 'musicmetadata'
fs = require 'fs'

# mongoose configuration

mongoose.connect 'mongodb://localhost/musejs'
Album = mongoose.model 'album', require './models/album'

app = module.exports = express.createServer() # create the express server

# Express Configuration

app.configure -> 
	app.set 'views', __dirname + '/views' # serve views from the views dir
	app.set 'view engine', 'jade' # using the jade engine
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use assets {buildDir: false, build: true, minifyBuilds: false, buildFilenamer: (filename, code) -> "#{filename}"} #build all out static assets for the client
	app.use express.static __dirname + '/public' # serve static files from public

app.configure 'development', ->
	app.use express.errorHandler { dumpExceptions: true, showStack: true } # show errors in development

app.configure 'production', ->
	app.use express.errorHandler { dumpExceptions: false, showStack: false } # not in production

app.get '/', (req, res) -> # when the index is requested, render the view with jade
	res.render 'index'

app.post '/upload', (req, res, next) -> 
	parser = new meta fs.createReadStream req.files.track.path
	parser.on 'metadata', (result) ->
		console.log(result)
	res.render 'index'

app.listen 3000 # listen on port 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

# Backbone.io Configuration

backend = bio.createBackend() # create a backend store for backbone

backend.use (req,res, next) -> # logging middleware
	console.log req.backend
	console.log req.method
	console.log JSON.stringify req.model
	next()

#backend.use bio.middleware.memoryStore() # memory store middleware
backend.use bio.middleware.mongooseStore Album
io = bio.listen app, { db: backend } # listen on socket io

# Socket.io Configuration

io.configure ->
	io.set 'transports', ['websocket'] # only use websockets
	io.set 'log level', 2 # lowish log level to stop log spam
	io.enable 'browser client minification' # minify the client because we can
	io.enable 'browser client gzip' # gzip as well