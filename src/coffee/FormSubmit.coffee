require "libs/buoy"

module.exports = class FormSubmit
	constructor: (formID)->
		form = document.getElementById formID
		form.addEventListener "submit", @formSubmitted

	formSubmitted: (e)->
		e.preventDefault()
		xhr = new XMLHttpRequest()
		xhr.open "POST", "/php/sendmail.php"
		xhr.send new FormData e.target
		buoy.addClass e.target.parentNode, 'sent'

