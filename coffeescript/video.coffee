# 2. Description
# OJP.Video loads a video when a static image is clicked. The video replaces the image.

# 2. Sample usage

# .ojp-video-slide.flex-video.widescreen{:"data-type" => "vimeo", :"data-embed-id" => "38548629", :"data-width" => "100%", :"data-height" => "534", :class => "current"}
#   %img.poster{:src => '/images/about/video-showdonttell.jpg', :alt => 'Owen Mural Video'}

# 3.  Can be styled with:
#   .ojp-video, .ojp-video-slide {

#     img.poster {
#       width: 100%;
#       position: absolute;
#     }

#     .overlay {

#       position: absolute;
#       z-index: 2;
#       width: 100%;
#       height: 100%;
#       text-align: center;
#       cursor: pointer;

#       &:before {
#         content: '';
#         height: 92%;
#         display: inline-block;
#         vertical-align: middle;
#       }

#       .video-play-button {
#         display: inline-block;
#         vertical-align: middle;
#         width: 100px;
#         height: 100px;
#         @include opacity(.8);
#         @include transition(opacity);
#       }
#     }
    
#     &.state-poster {
      
#       &:hover {
#         .video-play-button {
#           @include opacity(1);
#           @include transition(opacity);
#         }
#       }
#     }
#   }

# 4. Flex Video comes from foundation:
# .flex-video {
#   position: relative;
#   padding-top: 25px;
#   padding-bottom: 67.5%;
#   height: 0;
#   margin-bottom: 16px;
#   overflow: hidden;

#   &.widescreen { padding-bottom: 57.25%; }
#   &.vimeo { padding-top: 0; }

#   iframe, object, embed, video { position: absolute; top: 0; #{$defaultFloat}: 0; width: 100%; height: 100%; }

# }


OJP.Video = class Video

  @$container = null
  @type = null
  @embedID = null
  @src = null
  @width = null
  @height = null
  @markup = null
  @playButtonMarkup = null

  constructor: (div) ->

    @$container = $(div)
    @type = @$container.attr "data-type" || "youtube"
    @embedID = @$container.attr "data-embed-id"

    @youtube = "http://www.youtube.com/embed/"
    @vimeo = "http://player.vimeo.com/video/"

    if (@$container.attr('data-button-style') == 'dark')
      imgSrc = '/images/icons/video-play-icon-dark.png'
    else 
      imgSrc = '/images/icons/video-play-icon.png'

    @playButtonMarkup = "<div class='overlay'><div class='video-play-button'><img src='" + imgSrc + "'></div></div>"

    
   
    switch @type 
      when "youtube" then @srcURL = @youtube
      when "vimeo" then @srcURL = @vimeo
      else @srcURL = @youtube

    @src =  @srcURL + @embedID + "?hd=1&autoplay=1"

    @width = @$container.attr "data-width"
    @height = @$container.attr "data-height"  

    @markup = "<div class='video-holder'>
                <iframe allowfullscreen='1' webkitAllowFullScreen='1' mozallowfullscreen='1' frameborder='0' height='" + @height + "' width='" + @width + "' src='" + @src + "' />
              </div>";

    @$container.click =>
      @$container.html @markup

    @$container.append @playButtonMarkup
    
    @$container.addClass 'state-poster'

    @posterHTML = $('img',@$container)

  stopPlayback: ->
    $('.video-holder').detach()
    
    @$container.append @playButtonMarkup
    
    @$container.append @posterHTML
    @$container.addClass 'state-poster'

  

$ ->
  $(".ojp-video").each ->
    ojpVideo = new OJP.Video @



# <iframe src="http://player.vimeo.com/video/38548629" width="500" height="281" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe> 
   
  
