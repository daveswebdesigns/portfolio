module.exports = class Image
	constructor: (elem)-> 
		@elem = elem
		@parent = elem.parentNode
		@load()

	cancel: ->
		@xhr.abort()

	load: ->
		@xhr = new XMLHttpRequest()
		@xhr.onload = (e)=>@xhrloaded(e)
		@xhr.onprogress = (e)=>@xhrprogress(e)
		@xhr.open "get", @elem.getAttribute("data-uri"), true
		@xhr.responseType = 'arraybuffer'
		@xhr.send()

	xhrprogress: (e)->
		@parent.style.height = (e.loaded / e.total)*100 + "%"

	xhrloaded: (e)->
		if window.Blob?
			blb = new Blob [@xhr.response], type: 'image/png'
			@elem.src = window.URL.createObjectURL(blb);
		else
			@elem.src = @elem.getAttribute "data-uri"
		@handler = @imgLoaded.bind this
		@parent.addEventListener "transitionend", @handler

	imgLoaded: (e)->
		@parent.removeEventListener "transitionend", @handler
		responsiveWidth = Math.ceil @elem.naturalWidth * (@parent.parentElement.clientHeight / @elem.naturalHeight)
		@parent.style.maxWidth = responsiveWidth + "px"
		@parent.style.transitionDuration = responsiveWidth / 700 + "s"
		buoy.addClass @parent, "loaded"
		setTimeout (=> @imgLoadedAndReady()), 1400

	imgLoadedAndReady: (e)->
		@parent.removeAttribute 'style'
