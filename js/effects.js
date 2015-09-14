
window.onload = (function()
{
    var name_section  = document.getElementById('name_section');
    var h             = name_section.offsetHeight;
    var w             = name_section.offsetWidth;
    var meTop;
    var static        = (h - 1500) / 2;
    var name_inner    = document.getElementsByClassName('inner')[0];
    var me            = document.getElementById('me');
    var me_holder     = document.getElementById('meHolder');
    var intro_section      = document.getElementById('intro_section');
    var experience_section = document.getElementById('experience_section');
    var volunteering_section = document.getElementById('volunteering_section');
    var soton_bg  = document.getElementById('soton');
    var leys_bg  = document.getElementById('theleys');
    var links              = document.getElementsByTagName('a');
    var nav = document.getElementById('linkHolder');
    var nl_bg = document.getElementById('nl_bg');
    var susu_bg = document.getElementById('susu_bg');
    var nl_logo              = document.getElementById('nl_logo');
    var susu_footer = document.getElementById('susu_footer');
    var curve    = {xs: [], ys: [], ks: []};
    var linkOverlap = 0;
    me.style.zIndex   = 4;
    name_section.style.backgroundAttachment = '';
    
    for (var i = 0; i < links.length; i++)
    {
        if (links[i].href.split('#').length === 2)
        {
            links[i].onclick = doClick;
        }
    }
    
    function doClick(e)
    {
        e.preventDefault();
        
        var id = this.href.split('#')[1];
        var el = document.getElementById(id);
        var offset = 0;
        
        do
        {
            offset += el.offsetTop;
            el      = el.offsetParent;
        }
        while (el);
        
        scrollTo(offset - 180);
    }
    
    window.onbeforeprint = (function()
    {
        nl_logo.src = '/images/nl_print_logo.png';
        me.style.position = '';
    });
    
    window.onafterprint = (function()
    {
        nl_logo.src = '/images/nightline.png';
        onscroll();
    });

    var onscroll = window.onscroll = (function()
    {
        if (window.matchMedia('(max-width: 780px)').matches) return;
        
        var s = window.scrollY;
        
        var linkOffset = 0;
        var lStep      = linkOverlap / (document.body.offsetHeight - h);
        linkOffset     = lStep * s;
        nav.style.right = linkOffset + 'px';
        
        nav.parentElement.style.backgroundPositionX = CSPL.evalSpline(s, curve.xs, curve.ys, curve.ks) - linkOffset + 'px';
        
        me.style.position = 'fixed';
        
        experience_section.style.backgroundPositionY = (500 + s * 0.6) + 'px';
        soton_bg.style.backgroundPositionY = (s * 0.9) + 'px';
        leys_bg.style.backgroundPositionY = (s * 0.9) + 'px';
        nl_bg.style.backgroundPositionY = (s * 0.8) + 'px';
        susu_bg.style.backgroundPositionY = (s * 0.8) + 'px';
        nl_logo.style.bottom = Math.max(-100, (s - volunteering_section.offsetTop) * 0.2) + 'px';
        
        if (s < experience_section.offsetTop - 200)
        {
            name_section.style.backgroundPositionY = (static + s * 0.8) + 'px';
            name_inner.style.top = (s * 0.5) + 'px';
        }
        
        if (s + h > susu_bg.offsetTop + susu_bg.offsetHeight)
        {
            susu_footer.style.position = '';
            susu_footer.style.bottom   = '';
        }
        else
        {
            susu_footer.style.position = 'fixed';
            susu_footer.style.bottom   = Math.min(0, s + h - susu_bg.offsetTop - 30) + 'px';
        }
        
        if (s < intro_section.offsetTop - 200)
        {
            var step       = (63 - meTop) / (intro_section.offsetTop - 200);
            var newWidth   = 280 - (180 * (s / (intro_section.offsetTop - 200)));
            me.style.top   = meTop + (s * step) + 'px';
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
    
    window.onresize = (function()
    {
        h = name_section.offsetHeight;
        w = name_section.offsetWidth;
        meTop = ((document.getElementById('name_section').offsetHeight - document.getElementsByClassName('inner')[0].offsetHeight - 150) / 2) + 120;
        
        var links = nav.children;
        var linkWidth = 0;
        curve     = {xs: [], ys: [], ks: []};
        
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
            
            var y = 0;
            el    = links[i];
            linkWidth += el.offsetWidth;
            
            do
            {
                y += el.offsetLeft;
                el = el.offsetParent;
            }
            while (el);
            
            curve.xs.push(x);
            curve.ys.push(y);
        }
        
        curve.ys.push(linkWidth);
        curve.xs.push(document.body.offsetHeight - h);
        
        window.CSPL.getNaturalKs(curve.xs, curve.ys, curve.ks);
        
        linkOverlap = Math.max(0, linkWidth - w + 40);
        
        onscroll();
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
    window.onresize();
});