var Image, Images, Scroller, tmpl;

Image = require("Image");

Scroller = require("Scroller");

tmpl = require('blueimp-tmpl');

module.exports = Images = (function() {
  function Images(elem) {
    this.elem = elem;
    this.all = [];
    this.init();
  }

  Images.prototype.init = function() {
    var i, imgs, j, ref;
    if (this.all.length) {
      this.cancel();
    }
    imgs = document.querySelectorAll(this.elem + " img");
    for (i = j = ref = imgs.length - 1; j >= 0; i = j += -1) {
      this.initImage(imgs[i]);
    }
    if (this.scroller) {
      this.scroller.cancel();
    }
    return this.scroller = new Scroller(this.elem);
  };

  Images.prototype.initImage = function(img) {
    return [].push.call(this.all, new Image(img));
  };

  Images.prototype.cancel = function() {
    var results;
    results = [];
    while (this.all.length) {
      results.push(this.all.shift().cancel());
    }
    return results;
  };

  return Images;

})();
