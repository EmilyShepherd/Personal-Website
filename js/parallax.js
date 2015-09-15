
window.Em = window.Em || { };

(function(e)
{
    var _loaded = false;
    
    window.addEventListener('load', (function()
    {
        _loaded = true;
    }));
    
    e.Parallax = (function(config)
    {
        config         = config           || { };
        this.className = config.className || 'parallax';
        this.scale     = config.scale     || 0.8;
        this.style     = config.style     || 'backgroundPositionY';
    });
    
    e.Parallax.prototype.doParallax = (function(s)
    {
        s       = s || window.scrollY;
        var els = document.getElementsByClassName(this.className);
        
        for (var i = 0; i < els.length; i++)
        {
            var vPos  = els[i].winOffsetY;
            
            // Check whether this object is in view
            // (If not, rendering it is a waste of time)
            if (s + window.innerHeight < vPos || s > vPos + els[i].offsetHeight)
            {
                continue;
            }
            
            var style = this.elData(els[i], 'style');
            var scale = this.elData(els[i], 'scale');
            
            if (style !== 'backgroundPositionY' && style !== 'backgroundPositionX')
            {
                els[i].style[style] = s * scale + 'px';
            }
            else
            {
                var cStyle  = window.getComputedStyle(els[i]);
                var bg      = cStyle.backgroundImage;
                var size    = cStyle.backgroundSize;
                var img     = new Image();
                
                if (bg.substr(0, 3) === 'url')
                {
                    img.src = bg.replace(/url\((['"])?(.*?)\1\)/gi, '$2');
                }

                switch (size)
                {
                    case 'cover':
                        processCover(img, els[i]);
                        break;

                    case 'contain':
                        processContain(img, els[i]);
                        break;
                }

                var static = (els[i].offsetHeight - img.height) / 2;
                var midP   = vPos + els[i].offsetHeight / 2;
                var offset = (s + window.innerHeight / 2 - midP) * scale;

                els[i].style[style] = static + offset + 'px';
            }
        }
    });
    
    e.Parallax.prototype.elData = (function(el, name)
    {
        return el.data('parallax' + name.ucfirst()) || this[name];
    });
    
    e.Parallax.prototype.registerListener = (function()
    {
        var _this = this;
        
        window.addEventListener('scroll', (function()
        {
            if (_loaded)
            {
                _this.doParallax();
            }
            else
            {
                window.addEventListener('load', (function()
                {
                    _this.doParallax();
                }));
            }
        }));
        
        return this;
    });
    
    window.Element.prototype.data = (function(data)
    {
        if (typeof this.dataset !== 'undefined')
        {
            return this.dataset[data];
        }
        else
        {
            return this.getAttribute
            (
                 'data-'
                + data.replace(/([a-z])([A-Z])/, '$1-$2').toLowerCase()
            );
        }
    });
    
    window.Element.prototype.__defineGetter__('winOffsetY', (function()
    {
        var el    = this;
        var total = 0;

        do
        {
            total += el.offsetTop;
            el     = el.offsetParent;
        }
        while (el);

        return total;
    }));
    
    String.prototype.ucfirst = function()
    {
        return this.charAt(0).toUpperCase() + this.slice(1);
    }
    
    function processCover(img, el)
    {
        var wDiff = img.width - el.offsetWidth;
        var hDiff = img.height - el.offsetHeight;

        // Needs to be scaled up
        if (wDiff < 0 || hDiff < 0)
        {
            // Width Difference is most, scale it up
            if (wDiff < hDiff)
            {
                setWidth(img, el.offsetWidth);
            }
            // Height Difference is most, scale it up
            else
            {
                setHeight(img, el.offsetHeight);
            }
        }
        // Needs to be scaled down
        else if (wDiff > 0 && hDiff > 0)
        {
            // Width is smallest, it can be scaled
            if (wDiff < hDiff)
            {
                setWidth(img, el.offsetWidth);
            }
            // Height is smallest, it can be scaled
            else
            {
                setHeight(img, el.offsetHeight);
            }
        }
    }
    
    function processContain(img, el)
    {
        var wDiff = img.width - el.offsetWidth;
        var hDiff = img.height - el.offsetHeight;

        // Needs to be scaled up
        if (wDiff < 0 || hDiff < 0)
        {
            // Width Difference is least, scale it up
            if (wDiff < hDiff)
            {
                setWidth(img, el.offsetWidth);
            }
            // Height Difference is most, scale it up
            else
            {
                setHeight(img, el.offsetHeight);
            }
        }
        // Needs to be scaled down
        else if (wDiff > 0 && hDiff > 0)
        {
            // Width is largest, it must be scaled
            if (wDiff > hDiff)
            {
                setWidth(img, el.offsetWidth);
            }
            // Height is smallest, it can be scaled
            else
            {
                setHeight(img, el.offsetHeight);
            }
        }
    }
    
    function setWidth(img, newWidth)
    {
        img.height *= newWidth / img.width;
        img.width   = newWidth;
    }
    
    function setHeight(img, newHeight)
    {
        img.width *= newHeight / img.height;
        img.height = newHeight;
    }
})(window.Em);