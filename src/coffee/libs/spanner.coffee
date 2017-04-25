window.spanner = (elem) -> 
	t = elem.innerHTML
	elem.innerHTML = "<span>" + t.split('').join("</span><span>") + "</span>"