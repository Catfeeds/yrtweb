function Zoompic()
    {
       this.initialize.apply(this,arguments);
    }
    Zoompic.prototype=
    {
        initialize:function(id)
        {
           var _this=this;
           this.box=typeof id=="string"?document.getElementById(id):id;
           this.oPre=this.box.getElementsByTagName('pre')[0];
           this.oNext=this.box.getElementsByTagName('pre')[1];
           this.oUl=this.box.getElementsByTagName('ul')[0];
           this.aLi=this.oUl.getElementsByTagName('li');
           this.timer=null;
           this.iCenter=3;
           this.aStor=[];
            this.options = [
                {width:120, height:150, top:71, left:134, zIndex:1},
                {width:130, height:170, top:61, left:0, zIndex:2},
                {width:170, height:218, top:37, left:110, zIndex:3},
                {width:224, height:288, top:0, left:262, zIndex:4},
                {width:170, height:218, top:37, left:468, zIndex:3},
                {width:130, height:170, top:61, left:620, zIndex:2},
                {width:120, height:150, top:71, left:496, zIndex:1}
            ];
           for(var i=0;i<this.aLi.length;i++) this.aStor[i]=this.aLi[i];
           this.up();
            this._oNext=function()
            {
                return _this.doNext.apply(_this);
            }
            this._oPre=function()
            {
                return _this.doPre.apply(_this);
            }
           this.addBing(this.oNext,"click",this._oNext);
           this.addBing(this.oPre,"click",this._oPre);
           setInterval(this._oNext,5000);
        },
        doNext:function()
        {
          this.aStor.unshift(this.aStor.pop());
          this.up();
        },
        doPre:function()
        {
          this.aStor.push(this.aStor.shift());
          this.up();
        },
        up:function()
        {
          _this=this;
           for(var i=0;i<this.aStor.length;i++) this.oUl.appendChild(this.aStor[i]);
            for(var i=0;i<this.aStor.length;i++)
            {
               this.aStor[i].index=i;
               if(i<7)
               {
                   this.css(this.aStor[i],"display","block");
                   this.starMove(this.aStor[i],this.options[i],function()
                   {
                       _this.starMove(_this.aStor[_this.iCenter].getElementsByTagName('img')[0],{opacity:100},function()
                       {
                           _this.aStor[_this.iCenter].onmouseover=function()
                           {
                               _this.starMove(this.getElementsByTagName('div')[0],{bottom:0});
                           }
                           _this.aStor[_this.iCenter].onmouseout=function()
                           {
                               _this.starMove(this.getElementsByTagName('div')[0],{bottom:-100});
                           }
                       });
                   })
               }
                if(i<this.iCenter || i>this.iCenter)
                {
                    this.css(this.aStor[i].getElementsByTagName('img')[0],"opacity",30);
                    this.aStor[i].onmouseover=function()
                    {
                     _this.starMove(this.getElementsByTagName('img')[0],{opacity:100});
                    }
                    this.aStor[i].onmouseout=function()
                    {
                        _this.starMove(this.getElementsByTagName('img')[0],{opacity:30});
                    }
                    this.aStor[i].onmouseout();
                }else
                {
                    this.aStor[i].onmouseover=this.aStor[i].onmouseout=null;
                }
            }
        },
        starMove:function(obj,json,fnEnd)
        {
            _this=this;
            clearInterval(obj.timer);
            obj.timer=setInterval(function()
            {
                var oStop=true;
                for( var attr in json)
                {
                    if(attr=="opacity")
                    {
                        icurr=Math.round(parseFloat(_this.css(obj,attr))*100);
                    }else
                    {
                        icurr=parseInt(_this.css(obj,attr));
                    }
                   var ispeed=(json[attr]-icurr)/8;
                    ispeed=ispeed>0?Math.ceil(ispeed):Math.floor(ispeed);
                    if(icurr!=json[attr])
                    {
                        oStop=false;
                        _this.css(obj,attr,icurr+ispeed);
                    }
                }
                if(oStop)
                {
                    clearInterval(obj.timer);
                    fnEnd && fnEnd.apply(_this,arguments);
                }
            },30);
        },
        css:function(obj,attr,value)
        {
         if(arguments.length===2)
         {
             return obj.currentStyle?obj.currentStyle[attr]:getComputedStyle(obj,false)[attr];
         }else if(arguments.length===3)
         {
           switch (attr)
           {
               case "width":
               case "height":
               case "left":
               case "right":
               case "top":
               case "bottom":
                   obj.style[attr]=value+'px';
                   break;
               case "opacity":
                   obj.style.filter="alpha(opacity="+value+")";
                   obj.style.opacity=value/100;
                   break;
               default :
                   obj.style[attr]=value;
                   break;
           }
         }
        },
        addBing:function(obj,type,fnEnd)
        {
            return obj.addEventListener?obj.addEventListener(type,fnEnd,false):obj.attachEvent("on"+type,fnEnd);
        }
    }
    window.onload=function()
    {
       new Zoompic("box_wwwzzjsnet");
    }