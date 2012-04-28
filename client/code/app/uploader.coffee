class UploadView extends Backbone.View
	template: _.template $("#uploadTemplate").html()
	initialize: ->
		@collection = new Tracks



$('#container')
	.bind "dragenter dragover", (e) ->
		e.stopPropagation()
		e.preventDefault()
		false
	.bind "drop", (e) ->
		e.stopPropagation()
		e.preventDefault()
		$('#fileUpload').modal()
		files = e.originalEvent.dataTransfer.files
		$('#uploadButton').bind "click", ->

		for file in files
			fileDisplay file, template
		false

fileDisplay = (file, template) ->
	$('#fileUpload .modal-body').append template { filename: file.name }
	return
filesUpload = (files) ->
#	for file in files
#
	return
