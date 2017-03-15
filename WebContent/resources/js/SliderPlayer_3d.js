function Zoompic() {
    this.initialize.apply(this, arguments);
}
Zoompic.prototype =
{
    initialize: function (id) {
        var _this = this;
        this.box = typeof id == "string" ? document.getElementById(id) : id;
        this.oPre = this.box.getElementsByTagName('pre')[0];
        this.oNext = this.box.getElementsByTagName('pre')[1];
        this.oUl = this.box.getElementsByTagName('ul')[0];
        this.aLi = this.oUl.getElementsByTagName('li');
        this.timer = null;
        this.iCenter = 3;
        this.aStor = [];
        this.options = [
            { width: 99, height: 147, top: 62, left: 20, zIndex: 1 },
            { width: 118, height: 175, top: 47, left: 86, zIndex: 2 },
            { width: 132, height: 196, top: 35, left: 184, zIndex: 3 },
            { width: 150, height: 219, top: 20, left: 299, zIndex: 4 },
            { width: 132, height: 196, top: 35, left: 432, zIndex: 3 },
            { width: 118, height: 175, top: 47, left: 544, zIndex: 2 },
            { width: 99, height: 147, top: 62, left: 630, zIndex: 1 }
        ];
        for (var i = 0; i < this.aLi.length; i++) this.aStor[i] = this.aLi[i];
        this.up();
        this._oNext = function () {
            return _this.doNext.apply(_this);
        }
        this._oPre = function () {
            return _this.doPre.apply(_this);
        }
        this.addBing(this.oNext, "click", this._oNext);
        this.addBing(this.oPre, "click", this._oPre);
        setInterval(this._oNext, 5000);
    },
    doNext: function () {
        this.aStor.unshift(this.aStor.pop());
        this.up();
    },
    doPre: function () {
        this.aStor.push(this.aStor.shift());
        this.up();
    },
    up: function () {
        _this = this;
        for (var i = 0; i < this.aStor.length; i++) this.oUl.appendChild(this.aStor[i]);
        for (var i = 0; i < this.aStor.length; i++) {
            this.aStor[i].index = i;
            if (i < 7) {
                this.css(this.aStor[i], "display", "block");
                this.starMove(this.aStor[i], this.options[i], function () {
                    _this.starMove(_this.aStor[_this.iCenter].getElementsByTagName('div')[0], { opacity: 80 }, function () {
                        _this.aStor[_this.iCenter].onmouseover = function () {
                            _this.starMove(this.getElementsByTagName('div')[0], { bottom: 0 });
                        }
                        _this.aStor[_this.iCenter].onmouseout = function () {
                            _this.starMove(this.getElementsByTagName('div')[0], { bottom: -100 });
                        }
                    });
                })
            }
            if (i < this.iCenter || i > this.iCenter) {
                this.css(this.aStor[i].getElementsByTagName('div')[0], "opacity", 80);
                this.aStor[i].onmouseover = function () {
                    _this.starMove(this.getElementsByTagName('div')[0], { opacity: 80 });
                }
                this.aStor[i].onmouseout = function () {
                    _this.starMove(this.getElementsByTagName('div')[0], { opacity: 80 });
                }
                this.aStor[i].onmouseout();
            } else {
                this.aStor[i].onmouseover = this.aStor[i].onmouseout = null;
            }
        }
    },
    starMove: function (obj, json, fnEnd) {
        _this = this;
        clearInterval(obj.timer);
        obj.timer = setInterval(function () {
            var oStop = true;
            for (var attr in json) {
                if (attr == "opacity") {
                    icurr = Math.round(parseFloat(_this.css(obj, attr)) * 100);
                } else {
                    icurr = parseInt(_this.css(obj, attr));
                }
                var ispeed = (json[attr] - icurr) / 8;
                ispeed = ispeed > 0 ? Math.ceil(ispeed) : Math.floor(ispeed);
                if (icurr != json[attr]) {
                    oStop = false;
                    _this.css(obj, attr, icurr + ispeed);
                }
            }
            if (oStop) {
                clearInterval(obj.timer);
                fnEnd && fnEnd.apply(_this, arguments);
            }
        }, 30);
    },
    css: function (obj, attr, value) {
        if (arguments.length === 2) {
            return obj.currentStyle ? obj.currentStyle[attr] : getComputedStyle(obj, false)[attr];
        } else if (arguments.length === 3) {
            switch (attr) {
                case "width":
                case "height":
                case "left":
                case "right":
                case "top":
                case "bottom":
                    obj.style[attr] = value + 'px';
                    break;
                case "opacity":
                    obj.style.filter = "alpha(opacity=" + value + ")";
                    obj.style.opacity = value / 100;
                    break;
                default:
                    obj.style[attr] = value;
                    break;
            }
        }
      
    },
    addBing: function (obj, type, fnEnd) {
        return obj.addEventListener ? obj.addEventListener(type, fnEnd, false) : obj.attachEvent("on" + type, fnEnd);
    }
}
window.onload = function () {
	//new Zoompic("box_wwwzzjsnet");
}