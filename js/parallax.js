
window.Em = window.Em || { };

(function(e)
{
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
            var style = this.elData(els[i], 'style');
            var scale = this.elData(els[i], 'scale');
            
            els[i].style[style] = s * scale + 'px';
        }
    });
    
    e.Parallax.prototype.elData = (function(el, name)
    {
        return el.data('parallax-' + name) || this[name];
    });
    
    e.Parallax.prototype.registerListener = (function()
    {
        var _this = this;
        
        window.addEventListener('scroll', (function()
        {
            _this.doParallax();
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
})(window.Em);