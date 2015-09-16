
(function()
{
    var name_section = document.getElementById('name_section');
    var w            = name_section.offsetWidth;
    var me           = document.getElementById('me');
    var links        = document.getElementsByTagName('a');
    var nav          = document.getElementById('linkHolder');
    var curve        = {xs: [], ys: [], ks: []};
    var lStep        = 0;
    
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
            var h1s = document.getElementsByTagName('h1');
            var last = null;
            
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
        var vSection    = document.getElementById('volunteering_section');
        var nl          = document.getElementById('nl_logo');
        nl.style.bottom = Math.max(-100, (s - vSection.offsetTop) * 0.2) + 'px';
        
        // SUSU Footer
        var susu_footer = document.getElementById('susu_footer');
        var susu_bg     = document.getElementById('susu_bg');
        
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
            var step       = (63 - me.top) / (window.innerHeight - 200);
            var newWidth   = 280 - (180 * (s / (window.innerHeight - 200)));
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
        
        var links  = nav.children;
        var linkW  = 0;
        curve      = {xs: [], ys: [], ks: []};
        
        for (var i = 0; i < links.length; i++)
        {
            var el = document.getElementById(links[i].href.split('#')[1]);
            var x  = -130;
        
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
        var start     = window.scrollY;
        var diff      = y - start;
        var startTime = Date.now();
        duration      *= 1000;
        
        function doScroll()
        {
            var time     = (Date.now() - startTime) / duration;
            var easeTime = (Math.cos(time * Math.PI - Math.PI) + 1) / 2;
            
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