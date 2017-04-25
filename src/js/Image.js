var Image;

module.exports = Image = (function() {
  function Image(elem) {
    this.elem = elem;
    this.parent = elem.parentNode;
    this.load();
  }

  Image.prototype.cancel = function() {
    return this.xhr.abort();
  };

  Image.prototype.load = function() {
    this.xhr = new XMLHttpRequest();
    this.xhr.onload = (function(_this) {
      return function(e) {
        return _this.xhrloaded(e);
      };
    })(this);
    this.xhr.onprogress = (function(_this) {
      return function(e) {
        return _this.xhrprogress(e);
      };
    })(this);
    this.xhr.open("get", this.elem.getAttribute("data-uri"), true);
    this.xhr.responseType = 'arraybuffer';
    return this.xhr.send();
  };

  Image.prototype.xhrprogress = function(e) {
    return this.parent.style.height = (e.loaded / e.total) * 100 + "%";
  };

  Image.prototype.xhrloaded = function(e) {
    var blb;
    if (window.Blob != null) {
      blb = new Blob([this.xhr.response], {
        type: 'image/png'
      });
      this.elem.src = window.URL.createObjectURL(blb);
    } else {
      this.elem.src = this.elem.getAttribute("data-uri");
    }
    this.handler = this.imgLoaded.bind(this);
    return this.parent.addEventListener("transitionend", this.handler);
  };

  Image.prototype.imgLoaded = function(e) {
    var responsiveWidth;
    this.parent.removeEventListener("transitionend", this.handler);
    responsiveWidth = Math.ceil(this.elem.naturalWidth * (this.parent.parentElement.clientHeight / this.elem.naturalHeight));
    this.parent.style.maxWidth = responsiveWidth + "px";
    this.parent.style.transitionDuration = responsiveWidth / 700 + "s";
    buoy.addClass(this.parent, "loaded");
    return setTimeout(((function(_this) {
      return function() {
        return _this.imgLoadedAndReady();
      };
    })(this)), 1400);
  };

  Image.prototype.imgLoadedAndReady = function(e) {
    return this.parent.removeAttribute('style');
  };

  return Image;

})();
