/**
 * Cubic Spline Interpolator
 * 
 * Credit: http://blog.ivank.net/interpolation-with-cubic-splines.html
 */

function CSPL(){}

CSPL._gaussJ = {};
CSPL._gaussJ.solve = function(A, x)	// in Matrix, out solutions
{
    var m = A.length;
    for(var k=0; k<m; k++)	// column
{
        // pivot for column
        var i_max = 0; var vali = Number.NEGATIVE_INFINITY;
        for(var i=k; i<m; i++) if(A[i][k]>vali) { i_max = i; vali = A[i][k];}
        CSPL._gaussJ.swapRows(A, k, i_max);

        if(A[i_max][k] === 0) console.log("matrix is singular!");

        // for all rows below pivot
        for(var i=k+1; i<m; i++)
        {
            for(var j=k+1; j<m+1; j++)
                A[i][j] = A[i][j] - A[k][j] * (A[i][k] / A[k][k]);
            A[i][k] = 0;
        }
    }

    for(var i=m-1; i>=0; i--)	// rows = columns
    {
        var v = A[i][m] / A[i][i];
        x[i] = v;
        for(var j=i-1; j>=0; j--)	// rows
        {
            A[j][m] -= A[j][i] * v;
            A[j][i] = 0;
        }
    }
};

CSPL._gaussJ.zerosMat = function(r,c) {var A = []; for(var i=0; i<r; i++) {A.push([]); for(var j=0; j<c; j++) A[i].push(0);} return A;};
CSPL._gaussJ.printMat = function(A){ for(var i=0; i<A.length; i++) console.log(A[i]); };
CSPL._gaussJ.swapRows = function(m, k, l) {var p = m[k]; m[k] = m[l]; m[l] = p;};


CSPL.getNaturalKs = function(xs, ys, ks)	// in x values, in y values, out k values
{
    var n = xs.length-1,
        A = CSPL._gaussJ.zerosMat(n+1, n+2);

    for(var i=1; i<n; i++)	// rows
    {
        A[i][i-1] = 1/(xs[i] - xs[i-1]);

        A[i][i  ] = 2 * (1/(xs[i] - xs[i-1]) + 1/(xs[i+1] - xs[i])) ;

        A[i][i+1] = 1/(xs[i+1] - xs[i]);

        A[i][n+1] = 3*( (ys[i]-ys[i-1])/((xs[i] - xs[i-1])*(xs[i] - xs[i-1]))  +  (ys[i+1]-ys[i])/ ((xs[i+1] - xs[i])*(xs[i+1] - xs[i])) );
    }

    A[0][0  ] = 2/(xs[1] - xs[0]);
    A[0][1  ] = 1/(xs[1] - xs[0]);
    A[0][n+1] = 3 * (ys[1] - ys[0]) / ((xs[1]-xs[0])*(xs[1]-xs[0]));

    A[n][n-1] = 1/(xs[n] - xs[n-1]);
    A[n][n  ] = 2/(xs[n] - xs[n-1]);
    A[n][n+1] = 3 * (ys[n] - ys[n-1]) / ((xs[n]-xs[n-1])*(xs[n]-xs[n-1]));

    CSPL._gaussJ.solve(A, ks);		
};

CSPL.evalSpline = function(x, xs, ys, ks)
{
    var i = 1;
    while(xs[i]<x) i++;

    var t = (x - xs[i-1]) / (xs[i] - xs[i-1]),

        a =  ks[i-1]*(xs[i]-xs[i-1]) - (ys[i]-ys[i-1]),
        b = -ks[i  ]*(xs[i]-xs[i-1]) + (ys[i]-ys[i-1]),

        q = (1-t)*ys[i-1] + t*ys[i] + t*(1-t)*(a*(1-t)+b*t);
    return q;
};

(function()
{
    'use strict';
    
    var name_section = document.getElementById('name_section'),
        w            = name_section.offsetWidth,
        me           = document.getElementById('me'),
        links        = document.getElementsByTagName('a'),
        nav          = document.getElementById('linkHolder'),
        curve        = {xs: [], ys: [], ks: []},
        lStep        = 0;
    
    for (var i = 0; i < links.length; i++)
    {
        var split = links[i].href.split('#');
        
        if (split.length === 2)
        {
            links[i].onclick = (function(e)
            {
                e.preventDefault();
                
                var el = document.getElementById(this.href.split('#')[1]);
                
                document.getElementById('menu').checked = false;
                
                scrollTo(el.winOffsetY - 180);
            });
        }
    }

    window.onscroll = (function()
    {
        var s = window.scrollY;
        
        if (w < 780)
        {
            var h1s = document.getElementsByTagName('h1'),
                last = null;
            
            for (var i = 0; i < h1s.length; i++)
            {
                if (h1s[i].winOffsetY - 200 > s)
                {
                    if (last)
                        document.getElementById('sectionTitle').innerText = last.innerText;
                    break;
                }
                
                last = h1s[i];
            }
            
            s = 0;
        }
        
        // LINKS
        var lOffset     = lStep * s;
        nav.style.right = lOffset + 'px';
        
        // Section Chevron
        nav.parentElement.style.backgroundPositionX =
            CSPL.evalSpline(s, curve.xs, curve.ys, curve.ks) - lOffset + 'px';
        
        // Nightline Logo
        var vSection    = document.getElementById('volunteering_section'),
            nl          = document.getElementById('nl_logo');
        nl.style.bottom = Math.max(-100, (s - vSection.offsetTop) * 0.2) + 'px';
        
        // SUSU Footer
        var susu_footer = document.getElementById('susu_footer'),
            susu_bg     = document.getElementById('susu_bg');
        
        if (s + window.innerHeight > susu_bg.offsetTop + susu_bg.offsetHeight - 5)
        {
            susu_footer.style.position = '';
            susu_footer.style.bottom   = '';
        }
        else
        {
            susu_footer.style.position = 'fixed';
            susu_footer.style.bottom   = Math.min(0, s + window.innerHeight - susu_bg.offsetTop - 30) + 'px';
        }
        
        // Me Icon
        
        if (s === 0) return;
        
        me.style.position = 'fixed';
        
        if (s < window.innerHeight - 200)
        {
            var step       = (63 - me.top) / (window.innerHeight - 200),
                newWidth   = 280 - (180 * (s / (window.innerHeight - 200)));
            me.style.top   = me.top + (s * step) + 'px';
            me.style.width = newWidth + 'px';
            me.style.left  = ((w - newWidth) / 2) + 'px';
        }
        else
        {
            me.style.top   = '63px';
            me.style.width = '100px';
            me.style.left  = ((w - 100) / 2) + 'px';
        }
    });
    
    window.onresize = window.onload = (function()
    {
        var innerH = document.getElementsByClassName('inner')[0].offsetHeight;
        w          = name_section.offsetWidth;
        me.top     = (name_section.offsetHeight - innerH - 150) / 2 + 120;
        
        var links  = nav.children,
            linkW  = 0;
        curve      = {xs: [], ys: [], ks: []};
        
        for (var i = 0; i < links.length; i++)
        {
            var el = document.getElementById(links[i].href.split('#')[1]),
                x  = -130;
        
            do
            {
                x += el.offsetTop;
                el = el.offsetParent;
            }
            while (el);
            
            var y  = 0;
            el     = links[i];
            linkW += el.offsetWidth;
            
            do
            {
                y += el.offsetLeft;
                el = el.offsetParent;
            }
            while (el);
            
            curve.xs.push(x);
            curve.ys.push(y);
        }
        
        curve.ys.push(linkW);
        curve.xs.push(document.body.offsetHeight - window.innerHeight);
        
        window.CSPL.getNaturalKs(curve.xs, curve.ys, curve.ks);
        
        for (var i in curve.ks)
        {
            curve.ks[i] = Math.max(0, curve.ks[i]);
        }
        
        window._curve = curve;
        
        var over = Math.max(0, linkW - w + 40);
        
        if (window.matchMedia('(max-width: 1115px)').matches)
        {
            over += 100;
        }
        
        lStep    = over / (document.body.offsetHeight - window.innerHeight);
        
        window.scrollBy(0, 1);
    });
    
    function scrollTo(y, duration)
    {
        if (!duration) duration = 1;
        var start     = window.scrollY,
            diff      = y - start,
            startTime = Date.now();
        duration      *= 1000;
        
        function doScroll()
        {
            var time     = (Date.now() - startTime) / duration,
                easeTime = (Math.cos(time * Math.PI - Math.PI) + 1) / 2;
            
            window.scrollTo(0, start + easeTime * diff);
            
            if (time < 1)
                window.requestAnimationFrame(doScroll);
        }
        
        doScroll();
    }
    
    window.console.niceLog = (function(msg, size)
    {
        if (!size) size = 40;
        
        console.log
        (
            '%c ' + msg + ' ',
              'color: white;'
            + 'font-size: ' + size + 'px;'
            + 'background: #2b64b3;'
            + 'font-family: "Comic Sans MS", cursive, sans-serif;'
        );
    });
    
    console.niceLog('Hi(re me), I\'m Emily.');
})();

window.Em = window.Em || { };

(function(e)
{
    'use strict';
    
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
        this.wCutOff   = config.wCutOff   || 0;
    });
    
    e.Parallax.prototype.doParallax = (function(s)
    {
        s       = s || window.scrollY;
        var els = document.getElementsByClassName(this.className);
        
        if (document.body.offsetWidth < this.wCutOff)
        {
            s = 0;
        }
        
        for (var i = 0; i < els.length; i++)
        {
            var vPos  = els[i].winOffsetY;
            
            // Check whether this object is in view
            // (If not, rendering it is a waste of time)
            if (s + window.innerHeight < vPos || s > vPos + els[i].offsetHeight)
            {
                continue;
            }
            
            var style = this.elData(els[i], 'style'),
                scale = this.elData(els[i], 'scale');
            
            if (style !== 'backgroundPositionY' && style !== 'backgroundPositionX')
            {
                els[i].style[style] = s * scale + 'px';
            }
            else
            {
                var cStyle  = window.getComputedStyle(els[i]),
                    bg      = cStyle.backgroundImage,
                    size    = cStyle.backgroundSize,
                    img     = new Image();
                
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

                var start  = (els[i].offsetHeight - img.height) / 2,
                    midP   = vPos + els[i].offsetHeight / 2,
                    offset = (s + window.innerHeight / 2 - midP) * scale;

                els[i].style[style] = start + offset + 'px';
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
        var el    = this,
            total = 0;

        do
        {
            total += el.offsetTop;
            el     = el.offsetParent;
        }
        while (el);

        return total;
    }));
    
    String.prototype.ucfirst = (function()
    {
        return this.charAt(0).toUpperCase() + this.slice(1);
    });
    
    function processCover(img, el)
    {
        var wDiff = img.width - el.offsetWidth,
            hDiff = img.height - el.offsetHeight;

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
        var wDiff = img.width - el.offsetWidth,
            hDiff = img.height - el.offsetHeight;

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