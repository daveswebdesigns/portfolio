var Images, Portfolio, tmpl;

Images = require('Images');

tmpl = require('blueimp-tmpl');

module.exports = Portfolio = (function() {
  function Portfolio(app) {
    this.detail = document.getElementById("detail");
    this.addThumbs();
    app.addEventListener("ready", (function(_this) {
      return function() {
        return _this.initThumbs();
      };
    })(this));
  }

  Portfolio.prototype.addThumbs = function() {
    return document.getElementById("thumbs").innerHTML = tmpl("tmpl-thumbs", portfolio_data);
  };

  Portfolio.prototype.initThumbs = function() {
    var i, len, thumb, thumbs;
    new Images("#thumbs .images");
    thumbs = document.querySelectorAll("#thumbs img");
    for (i = 0, len = thumbs.length; i < len; i++) {
      thumb = thumbs[i];
      this.addClick(thumb);
    }
  };

  Portfolio.prototype.addClick = function(thumb) {
    return thumb.addEventListener("click", (function(_this) {
      return function(e) {
        return _this.switchTmpl(e);
      };
    })(this));
  };

  Portfolio.prototype.switchTmpl = function(e) {
    this.detail.innerHTML = tmpl("tmpl-portfolio", this.getSelectedData(e));
    if (this.images != null) {
      this.images.init();
    } else {
      this.images = new Images("#detail .images");
    }
    return this.scrollIntoView();
  };

  Portfolio.prototype.getSelectedData = function(e) {
    var i, id, len, o;
    id = e.target.getAttribute("data-itemid");
    for (i = 0, len = portfolio_data.length; i < len; i++) {
      o = portfolio_data[i];
      if (o.id === id) {
        return o;
      }
    }
  };

  Portfolio.prototype.scrollIntoView = function() {
    var dest, gap, thumbs;
    thumbs = document.getElementById("thumbs");
    gap = window.innerWidth > 800 ? 20 : 3;
    dest = thumbs.getBoundingClientRect().top - gap;
    return window.scrollBy(0, dest);
  };

  return Portfolio;

})();
