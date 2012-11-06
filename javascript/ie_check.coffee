$ ->
  ua = window.navigator.userAgent.toLowerCase()
  if ua.indexOf("msie") > -1
    ieVersionRE = /msie (\d+)/
    match = ua.match(ieVersionRE)
    if match
      v = match[1]
      if v >= 9
        $(document.documentElement).addClass("ie"+v)
      else
        $(document.documentElement).addClass("lt-ie9")