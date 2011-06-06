function toggleClass(elem, className1, className2)

{
    elem.className = (elem.className == className1) ? className2 : className1;
}
function setClass(elem, className1)

{
    elem.className = className1;
}

function roundNumber(num, dec) {
	var x = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	return x;
}
   