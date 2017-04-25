var FormSubmit;

require("libs/buoy");

module.exports = FormSubmit = (function() {
  function FormSubmit(formID) {
    var form;
    form = document.getElementById(formID);
    form.addEventListener("submit", this.formSubmitted);
  }

  FormSubmit.prototype.formSubmitted = function(e) {
    var xhr;
    e.preventDefault();
    xhr = new XMLHttpRequest();
    xhr.open("POST", "/php/sendmail.php");
    xhr.send(new FormData(e.target));
    return buoy.addClass(e.target.parentNode, 'sent');
  };

  return FormSubmit;

})();
