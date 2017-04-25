Portfolio = require "Portfolio"
FormSubmit = require "FormSubmit"
require "libs/buoy"
require "libs/spanner"
require "libs/pseudo"
require "libs/ieEvent"

do ->
	
	inc = 0
	animTime = .2 

	window.onload = ->
		buoy.addClass document.querySelector("body"), "loaded"
		new Portfolio this 
		new FormSubmit "form-contact" 
		logointro()

	logointro = ->
		logo = document.querySelector "header"
		spanner logo
		addPsuedoContent logo
		endTime = staggerChildren logo
		setTimeout slidePortBg, endTime - 600

	slidePortBg = ()->
		buoy.addClass document.querySelector("#portfolio .label") , "ready"
		setTimeout inPortImgs, 600

	inPortImgs = ()->
		delay = staggerChildren document.querySelector "#thumbs .images"
		setTimeout inContact, 400
		setTimeout (-> dispatchEvent new Event "ready"), delay

	inContact = ()->
		buoy.addClass document.querySelector("#contact .label"), "ready"
		staggerChildren document.getElementById("form-contact"), .45
		
	addPsuedoContent = (parent, pseudo = "before")->
		l = parent.children.length
		for i in [0...l]
			elem = parent.children[i]
			elem.pseudoStyle pseudo, "content", elem.innerHTML
		return

	staggerChildren = (parent, initDelay = 0)->
		inc = 0
		l = parent.children.length
		buoy.addClass parent, "ready"
		for i in [0...l]
			delay = staggerChild parent, i, i is l-1, initDelay
		delay

	staggerChild = (parent, i, last, initDelay)->
		elem = parent.children[i]
		inc += i
		delay = (i/1.5 - (inc/40))*.25 + initDelay
		setDelay elem, delay 
		if last then return (delay+.45)*1000

	setDelay = (elem, delay)->
		delay2 = delay + animTime
		elem.pseudoStyle "before", "animation-delay", "#{delay}s, #{delay2}s"
		elem.style.animationDelay = "#{delay}s, #{delay2}s"
