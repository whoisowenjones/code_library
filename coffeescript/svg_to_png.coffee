$ ->
  if !Modernizr.svg
    imgs = document.getElementsByTagName('img')
    for img, i in imgs
      if /.*\.svg$/.test(imgs[i].src)
        imgs[i].src = imgs[i].src.slice(0, -3) + 'png'
