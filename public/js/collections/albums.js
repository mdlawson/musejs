define(['models/album'], function(Album){
	var AlbumList = Backbone.Collection.extend({
		model: Album,
		url: 'albums'
	});
	return AlbumList
});