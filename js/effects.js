
window.onload = (function()
{
    var name_section  = document.getElementById('name_section');
    var h             = name_section.offsetHeight;
    var w             = name_section.offsetWidth;
    var static        = (h - 1500) / 2;
    var name_inner    = document.getElementsByClassName('inner')[0];
    var me            = document.getElementById('me');
    var intro_href    = document.getElementById('intro_href');
    var experience_section = document.getElementById('experience_section');
    me.style.zIndex   = 4;
    name_section.style.backgroundAttachment = '';

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
        
        if (s > 500 && s < 800)
        {
            intro_href.className = 'active';
        }
        else
        {
            intro_href.className = '';
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
});