//$(function(){
require(['collections/albums', 'views/browser'], function (AlbumList,BrowserView) {
	console.log("main started")
	_.templateSettings = {
		interpolate : /\{\{(.+?)\}\}/g
	};
	window.albums = new AlbumList;
	window.App = new BrowserView;
});



