(function() {
  var form, formSubmitted;
  formSubmitted = function(e) {
    var params, url, xhr;
    e.preventDefault();
    document.querySelector('#contact .content').innerHTML = "<h2>Thanks!</h2> I'll get back to you ASAP";
    xhr = new XMLHttpRequest();
    url = "/php/sendmail.php";
    params = "name=" + this[0].value + "&email=" + this[1].value + "&message=" + this[2].value;
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    return xhr.send(params);
  };
  form = document.forms[0];
  return form.addEventListener("submit", formSubmitted);
})();
