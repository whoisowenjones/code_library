if (Element.prototype) {
  Element.prototype.addClass = function(new_class) {
    var i,n=0;
    new_class=new_class.split(",");
    for(i=0;i<new_class.length;i++){
      if((" "+this.className+" ").indexOf(" "+new_class[i]+" ") === -1){
        this.className+=" "+new_class[i];
        n++;
      }
  }
  return n;
  };
}

var ua = window.navigator.userAgent.toLowerCase();
if (ua.indexOf("msie") > -1) {
  document.documentElement.addClass("ie");
  var ieVersionRE = /msie (\d+)/;
  var match = ua.match(ieVersionRE);
  if (match) {
    v = match[1];
    if (v >= 9) { document.documentElement.addClass("ie"+v); }
    else if (v < 9) { document.documentElement.addClass("ie-8,lt-ie9"); }
  }
}
