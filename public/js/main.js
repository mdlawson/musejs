//$(function(){
require(['views/browser'], function (BrowserView) {
	console.log("main started");
	Backbone.socket = io.connect();
	Backbone.socket.emit('albums:create', { foo: 'bar'});
	window.App = new BrowserView;
});



