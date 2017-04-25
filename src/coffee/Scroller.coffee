module.exports = class Scroller
	constructor: (selector)->
		@elem = document.querySelector selector
		@elem.addEventListener "mousewheel", @mouseWheelHandler
		@elem.addEventListener "DOMMouseScroll", @mouseWheelHandler

	# public methods
	cancel: ->
		@elem.removeEventListener "mousewheel", @mouseWheelHandler
		@elem.removeEventListener "DOMMouseScroll", @mouseWheelHandler

	# private methods
	mouseWheelHandler: (e)->
		e.preventDefault()
		e.currentTarget.parentNode.scrollLeft -= e.wheelDelta or e.detail * -40

