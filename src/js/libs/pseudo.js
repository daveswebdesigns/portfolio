(function() {
	a = {
		_b: 0,
		c: function() {
			this._b++;
			return this._b;
		}
	};
	HTMLElement.prototype.pseudoStyle = function(d, e, f) {
		var g = "pseudoStyles";
		var h = document.head || document.getElementsByTagName('head')[0];
		var i = document.getElementById(g) || document.createElement('style');
		i.id = g;
		var j = "pseudoStyle" + a.c();
		this.className += " " + j;
		if (e == 'content') f = '"'+f+'"'
		i.innerHTML += " ." + j + ":" + d + "{" + e + ":" + f + "}";
		h.appendChild(i);
		return this;
	}
	;
})(); 