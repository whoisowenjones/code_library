(function($) {
  var ua = window.navigator.userAgent.toLowerCase();
  if (ua.indexOf("msie") > -1) {
    var ieVersionRE = /msie (\d+)/;
    var match = ua.match(ieVersionRE);
    if (match) {
      v = match[1];
      if (v >= 9) { $(document.documentElement).addClass("ie"+v); }
      else if (v < 9) { $(document.documentElement).addClass("lt-ie9"); }
    }
  }
})(jQuery);