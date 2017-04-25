window.spanner = function(elem) {
  var t;
  t = elem.innerHTML;
  return elem.innerHTML = "<span>" + t.split('').join("</span><span>") + "</span>";
};
