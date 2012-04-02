(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  $(document).ready(function() {
    var Album, AlbumView, Albums, AlbumsView, BrowserView;
    console.log("main started");
    Album = (function() {

      __extends(Album, Backbone.Model);

      function Album() {
        Album.__super__.constructor.apply(this, arguments);
      }

      return Album;

    })();
    AlbumView = (function() {

      __extends(AlbumView, Backbone.View);

      function AlbumView() {
        AlbumView.__super__.constructor.apply(this, arguments);
      }

      AlbumView.prototype.tagName = "li";

      AlbumView.prototype.className = "album";

      AlbumView.prototype.template = _.template($("#albumTemplate").html());

      AlbumView.prototype.initialize = function() {
        _.bindAll(this, 'render');
        this.model.bind('change', this.render);
        return this.model.bind('remove', this.remove, this);
      };

      AlbumView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      AlbumView.prototype.remove = function() {
        return $(this.el).remove();
      };

      return AlbumView;

    })();
    Albums = (function() {

      __extends(Albums, Backbone.Collection);

      function Albums() {
        Albums.__super__.constructor.apply(this, arguments);
      }

      Albums.prototype.model = Album;

      Albums.prototype.backend = 'db';

      return Albums;

    })();
    AlbumsView = (function() {

      __extends(AlbumsView, Backbone.View);

      function AlbumsView() {
        AlbumsView.__super__.constructor.apply(this, arguments);
      }

      AlbumsView.prototype.el = $("#content-list");

      AlbumsView.prototype.initialize = function() {
        _.bindAll(this, 'render');
        this.collection.bind('add', this.addAlbum, this);
        return this.collection.bind('reset', this.render);
      };

      AlbumsView.prototype.addAlbum = function(album) {
        var view;
        view = new AlbumView({
          model: album
        });
        return $("#content-list").append(view.render().el);
      };

      AlbumsView.prototype.render = function() {
        $(this.el).empty();
        this.collection.each(this.addAlbum);
        return this;
      };

      return AlbumsView;

    })();
    BrowserView = (function() {

      __extends(BrowserView, Backbone.View);

      function BrowserView() {
        BrowserView.__super__.constructor.apply(this, arguments);
      }

      BrowserView.prototype.el = $("#browserView");

      BrowserView.prototype.initialize = function() {
        this.collection = new Albums;
        return this.view = new AlbumsView({
          collection: this.collection
        });
      };

      return BrowserView;

    })();
    return window.app = new BrowserView;
  });

}).call(this);
