$ ->
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
			for file in files
				fileDisplay file
			false
	fileDisplay = (file) ->
		return
	filesUpload = (files) ->
		return
