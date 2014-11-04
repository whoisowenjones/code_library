if ( !window.SVGElement ) {
  var imgs = document.getElementsByTagName('img'),
    i = imgs.length,
    img;
  while (i--) {
    img = imgs[i];
    if (/.*\.svg$/.test(img.src)) {
      img.src = img.src.slice(0, -3) + 'png';
    }
  }
}
