// Once an iframe has a height, we can insert a link tag to the iframe's head.
// This example requires jquery, but it should be easy to remove the dependency.

<script>
  
  $(function() {

    var iframeContainer = $('#widgetTargetDiv');
  
    // run timer to establish when iframe has loaded
    var t = setInterval(function(){
      if ( iframeContainer.height() > 100) {// 100 is an arbitrary height and may need to be tweaked.

        clearInterval(t);

        // this can be safely removed, but it's a nice hook for changing styles when the iframe has loaded.
        $('body').addClass('iframe-load-complete');

        // restyle the iframe
        var frame = $("iframe", iframeContainer)[0].contentDocument;
        var iframeHead = frame.getElementsByTagName("head")[0];
        var link = frame.createElement("link");
        link.setAttribute("rel", "stylesheet");
        link.setAttribute("type", "text/css");
        link.setAttribute("href", "/css/style.css?v=2.17");
        iframeHead.appendChild(link);
      }
    },1000);

  });

</script>