var isCrop = false;
var md = null;
var c1 = new Array(0, 0);
var c2 = new Array(0, 0);

function initCrop(divID)
{
    var cd = document.getElementById(divID);
    if (!(/#text/i.test(cd.firstChild.nodeName))) return;
    cd.cropped = true;
    cd.onclick = function(e)
    {
        var event = e ? e : window.event;
        var target = event.target ? event.target : (event.srcElement ? event.srcElement : null);
        if (!target) return;
        if (md == null && !isCrop)
        {
            tp = getElPos(target);
            c1[0] = event.clientX - tp[0];
            c1[1] = event.clientY - tp[1];
            md = document.createElement('div');
            md.id = "md";
            target.parentNode.appendChild(md);
            md.style.left = c1[0] + 'px';
            md.style.top = c1[1] + 'px';
            md.style.width = '0px';
            md.style.height = '0px';
            isCrop = true;
        }
        else
        {
            if (isCrop)
            {
                alert('Selected area:\nTop corner: ' + (c1[0] < c2[0] ? c1[0] : c2[0]) + ':' + (c1[1] < c2[1] ? c1[1] : c2[1]) + '\nSize: ' + (Math.abs(c1[0] - c2[0])) + ':' + (Math.abs(c1[1] - c2[1])));
                isCrop = false;
                md.parentNode.removeChild(md);
                md = null;
            }
            else
            {
                md.parentNode.removeChild(md);
                md = null;
            }
        }
    };
    cd.onmousemove = function(e)
    {
        if (!isCrop) return;
        var event = e ? e : window.event;
        var target = event.target ? event.target : (event.srcElement ? event.srcElement : null);
        if (!target) return;
        if (!target.cropped) target = target.parentNode;
        tp = getElPos(target);
        c2[0] = event.clientX - tp[0];
        c2[1] = event.clientY - tp[1];
        md.style.left = (c1[0] < c2[0] ? c1[0] : c2[0]) + 'px';
        md.style.top = (c1[1] < c2[1] ? c1[1] : c2[1]) + 'px';
        md.style.width = (Math.abs(c1[0] - c2[0])) + 'px';
        md.style.height = (Math.abs(c1[1] - c2[1])) + 'px';

    };
}


function getElPos(el)
{
    x = el.offsetLeft;
    y = el.offsetTop;
    elp = el.offsetParent;
    while (elp != null)
    {
        x += elp.offsetLeft;
        y += elp.offsetTop;
        elp = elp.offsetParent;
    }
    return new Array(x, y);
}

