var FormSubmit, Portfolio;

Portfolio = require("Portfolio");

FormSubmit = require("FormSubmit");

require("libs/buoy");

require("libs/spanner");

require("libs/pseudo");

require("libs/ieEvent");

(function() {
  var addPsuedoContent, animTime, inContact, inPortImgs, inc, logointro, setDelay, slidePortBg, staggerChild, staggerChildren;
  inc = 0;
  animTime = .2;
  window.onload = function() {
    buoy.addClass(document.querySelector("body"), "loaded");
    new Portfolio(this);
    new FormSubmit("form-contact");
    return logointro();
  };
  logointro = function() {
    var endTime, logo;
    logo = document.querySelector("header");
    spanner(logo);
    addPsuedoContent(logo);
    endTime = staggerChildren(logo);
    return setTimeout(slidePortBg, endTime - 600);
  };
  slidePortBg = function() {
    buoy.addClass(document.querySelector("#portfolio .label"), "ready");
    return setTimeout(inPortImgs, 600);
  };
  inPortImgs = function() {
    var delay;
    delay = staggerChildren(document.querySelector("#thumbs .images"));
    setTimeout(inContact, 400);
    return setTimeout((function() {
      return dispatchEvent(new Event("ready"));
    }), delay);
  };
  inContact = function() {
    buoy.addClass(document.querySelector("#contact .label"), "ready");
    return staggerChildren(document.getElementById("form-contact"), .45);
  };
  addPsuedoContent = function(parent, pseudo) {
    var elem, i, j, l, ref;
    if (pseudo == null) {
      pseudo = "before";
    }
    l = parent.children.length;
    for (i = j = 0, ref = l; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      elem = parent.children[i];
      elem.pseudoStyle(pseudo, "content", elem.innerHTML);
    }
  };
  staggerChildren = function(parent, initDelay) {
    var delay, i, j, l, ref;
    if (initDelay == null) {
      initDelay = 0;
    }
    inc = 0;
    l = parent.children.length;
    buoy.addClass(parent, "ready");
    for (i = j = 0, ref = l; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      delay = staggerChild(parent, i, i === l - 1, initDelay);
    }
    return delay;
  };
  staggerChild = function(parent, i, last, initDelay) {
    var delay, elem;
    elem = parent.children[i];
    inc += i;
    delay = (i / 1.5 - (inc / 40)) * .25 + initDelay;
    setDelay(elem, delay);
    if (last) {
      return (delay + .45) * 1000;
    }
  };
  return setDelay = function(elem, delay) {
    var delay2;
    delay2 = delay + animTime;
    elem.pseudoStyle("before", "animation-delay", delay + "s, " + delay2 + "s");
    return elem.style.animationDelay = delay + "s, " + delay2 + "s";
  };
})();
