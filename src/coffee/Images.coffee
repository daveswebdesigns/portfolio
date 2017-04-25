Image = require "Image"
Scroller = require "Scroller"
tmpl = require 'blueimp-tmpl'

module.exports = class Images
	constructor: (elem)->
		@elem = elem
		@all = []
		@init()

	init: ->
		if @all.length then @cancel()
		imgs = document.querySelectorAll @elem + " img"
		@initImage(imgs[i]) for i in [imgs.length-1..0] by -1
		if @scroller then @scroller.cancel()
		@scroller = new Scroller @elem

	initImage: (img)->
		[].push.call @all, new Image img

	cancel: ->
		while @all.length 
			@all.shift().cancel()