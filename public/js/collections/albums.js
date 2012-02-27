define(['models/album'], function(Album){
	var AlbumList = Backbone.Collection.extend({
		model: Album
	});
	return AlbumList
});