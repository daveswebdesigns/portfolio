var Scroller;

module.exports = Scroller = (function() {
  function Scroller(selector) {
    this.elem = document.querySelector(selector);
    this.elem.addEventListener("mousewheel", this.mouseWheelHandler);
    this.elem.addEventListener("DOMMouseScroll", this.mouseWheelHandler);
  }

  Scroller.prototype.cancel = function() {
    this.elem.removeEventListener("mousewheel", this.mouseWheelHandler);
    return this.elem.removeEventListener("DOMMouseScroll", this.mouseWheelHandler);
  };

  Scroller.prototype.mouseWheelHandler = function(e) {
    e.preventDefault();
    return e.currentTarget.parentNode.scrollLeft -= e.wheelDelta || e.detail * -40;
  };

  return Scroller;

})();
