function save_style_in_cookie_for(name){
        fixed_style = $(name).style.cssText.gsub('opacity: 0.7;','').gsub(';', '---');
    if(fixed_style != ""){
        var exp=new Date();
        var numdays=7;
        exp.setTime(exp.getTime()+(1000*60*60*24*numdays)) ;
        document.cookie="" + name + "_style=" + fixed_style + "; path=; expires="+exp.toGMTString();
        }
}