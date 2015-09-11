
window.onload = (function()
{
    var name_section  = document.getElementById('name_section');
    var h             = name_section.offsetHeight;
    var w             = name_section.offsetWidth;
    var static        = (h - 1500) / 2;
    var name_inner    = document.getElementsByClassName('inner')[0];
    var me            = document.getElementById('me');
    var intro_section      = document.getElementById('intro_section');
    var intro_href    = document.getElementById('intro_href');
    var experience_section = document.getElementById('experience_section');
    var experience_href    = document.getElementById('experience_href');
    me.style.zIndex   = 4;
    name_section.style.backgroundAttachment = '';
    
    experience_href.onclick =
    intro_href.onclick      =
    (function(e)
    {
        e.preventDefault();
        
        var id = this.href.split('#')[1];
        
        scrollTo(document.getElementById(id).parentElement.offsetTop - 150);
    });

    var onscroll = window.onscroll = (function()
    {
        var s = window.scrollY;
        
        me.style.position = 'fixed';
        
        experience_section.style.backgroundPositionY = (500 + s * 0.6) + 'px';
        
        if (s < 600)
        {
            name_section.style.backgroundPositionY = (static + s * 0.8) + 'px';
            name_inner.style.top = (s * 0.5) + 'px';
        }
        
        if (s > experience_section.offsetTop - 200)
        {
            intro_href.className      = '';
            experience_href.className = 'active';
            
        }
        else if (s > intro_section.offsetTop - 200)
        {
            intro_href.className      = 'active';
            experience_href.className = '';
        }
        else
        {
            intro_href.className      = '';
            experience_href.className = '';
        }
        
        if (s < 500)
        {
            var newWidth   = 280 - (180 * (s / 500));
            me.style.top   = (120 - s * 0.115) + 'px';
            me.style.width = newWidth + 'px';
            me.style.left  = ((w - newWidth) / 2) + 'px';
        }
        else
        {
            me.style.top   = '62.5px';
            me.style.width = '100px';
            me.style.left  = ((w - 100) / 2) + 'px';
        }
    });
    
    window.onresize = (function()
    {
        h = name_section.offsetHeight;
        w = name_section.offsetWidth;
        
        onscroll();
    });
    
    function scrollTo(y, duration)
    {
        if (!duration) duration = 1;
        var start     = window.scrollY;
        var diff      = y - start;
        var startTime = Date.now();
        duration      *= 1000;
        
        console.log(start);console.log(diff);console.log(startTime);
        
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
});