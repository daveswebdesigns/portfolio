Images = require 'Images'
tmpl = require 'blueimp-tmpl'

module.exports = class Portfolio
	constructor: (app)->
		@detail = document.getElementById "detail"
		@addThumbs()
		app.addEventListener "ready", => @initThumbs()
		# @initThumbs()

	addThumbs: ->
		document.getElementById("thumbs").innerHTML = tmpl "tmpl-thumbs", portfolio_data

	initThumbs: ->
		new Images "#thumbs .images"
		thumbs = document.querySelectorAll "#thumbs img"
		for thumb in thumbs
			@addClick thumb 
		return

	addClick: (thumb)->
		thumb.addEventListener "click", (e)=>@switchTmpl e

	switchTmpl: (e)->
		@detail.innerHTML = tmpl "tmpl-portfolio", @getSelectedData e
		if @images? 
			@images.init() 
		else 
			@images = new Images "#detail .images"
		@scrollIntoView()

	getSelectedData: (e)->
		id = e.target.getAttribute "data-itemid"		
		for o in portfolio_data
			return o if o.id is id 

	scrollIntoView: ->
		thumbs = document.getElementById "thumbs"
		gap = if window.innerWidth > 800 then 20 else 3
		dest = thumbs.getBoundingClientRect().top - gap
		window.scrollBy 0, dest
