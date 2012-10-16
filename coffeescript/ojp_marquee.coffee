module = (name) ->
  window[name] = window[name] or {}

module "OJP"

OJP.Marquee = class Marquee

  SIZES: [1000, 1324, 1680]

  constructor: (container) ->
    if (window.navigator.userAgent.indexOf("MSIE 8.0") > -1)
      @.ie8 = true
    @$container = container
    if @$container.attr("data-fade-interval")
      @fade_interval = parseInt(@$container.attr("data-fade-interval"), 10)
    else
      @fade_interval = 4000
    @fade_speed = parseInt(@$container.attr("data-fade-speed"), 10) || 600
    @nav = @$container.attr("data-nav") unless typeof @$container.attr("data-nav") == "undefined" ||
      @$container.attr("data-nav") == "false"
    @pager = @$container.attr("data-pager") unless typeof @$container.attr("data-pager") == "undefined" ||
      @$container.attr("data-pager") == "false"
    @ratio = @$container.attr("data-ratio")
    @max_width = @$container.attr("data-max-width")
    @min_width = @$container.attr("data-min-width")
    @$divs = @$container.children("div")
    @$imgs = @$divs.children("img")
    if @$divs.length == 1
      @nav = false
      @pager = false
    @auto_advance = true if @fade_interval > 0 && @$divs.length > 1
    @cycling = true if @auto_advance
    @cur_width = @$container.width()
    @cur_img_width = 0
    @cur_fading_index = 0
    @fade_amt = 0
    @advance_timeout = 0
    @init()

  init: ->
    @$divs.each ->
      $(this).css("display", "none")
    @init_current()
    if @nav
      @init_nav()
    else
      @$container.addClass("no-nav")
    if @pager
      @init_pager()
    else
      @$container.addClass("no-pager")
    @init_events()
  
  init_events: ->
    $(window).resize => @resize()
    
    if @pager
      marquee = @
      $lis = $("ul.ojp-marquee-nav li", @$container)
      if @nav
        $lis.splice($lis.length-1, 1)
        $lis.splice(0, 1)
      $lis.each ->
        index = parseInt($(this).text(), 10) - 1
        $(this).click =>
          marquee.pager_clicked index

  init_current: ->
    @$container.height(@get_height())
    if @$imgs.length > 0
      @cur_img_width = @best_img_size()
      @source_images()
    else
      @fade_in()

  source_images: ->
    @loaded = []
    for img in @$imgs
      new_source = "#{$(img).attr('data-path')}#{@cur_img_width}/#{$(img).attr('data-filename')}"
      # new source
      if img.src.indexOf(new_source) == -1
        window.clearTimeout(@advance_timeout)
        img.src = new_source

        #don't wait for load signal if IE8 - this seems to be enough to force cached load callback
        if @.ie8
          @$imgs.css("height", @$container.height())

        $(img).load (e) =>
          @loaded.push e.target.src
          if @loaded.length == 1
            #@$container.height(@get_height())
            if @.ie8
              @$imgs.css("height", @$container.height())

          if @loaded.length == @$imgs.length
            @fade_in()

  best_img_size: ->
    best_width = @SIZES[0]
    for size,i in @SIZES
      if size <= @cur_width
        best_width = size
    best_width

  resize: ->
    @cur_width = document.documentElement.offsetWidth
    @cur_img_width = @best_img_size()
    @$container.height(@get_height())
    if @.ie8
      @$imgs.css("height", @$container.height())
    @source_images()

  get_height: ->
    if @cur_width >= @max_width
      height = Math.floor(@max_width * @ratio) - 6 # not necessary if not bottom aligning
    else if @cur_width <= @min_width
      height = Math.floor(@min_width * @ratio)
    else
      height = Math.floor(@cur_width * @ratio) - 6 # not necessary if not bottom aligning
    height

  fade_in: ->
    if @auto_advance
      $(@$divs[@cur_fading_index]).fadeIn(@fade_speed, => @advance_timeout = window.setTimeout(@advance, @fade_interval))
    else
      window.clearTimeout(@advance_timeout)
      $(@$divs[@cur_fading_index]).fadeIn(@fade_speed)
    if @pager
      $("ul.ojp-marquee-nav li.current", @$container).removeClass("current")
      if @nav
        $($("ul.ojp-marquee-nav li", @$container)[@cur_fading_index + 1]).addClass("current")
      else
        $($("ul.ojp-marquee-nav li", @$container)[@cur_fading_index]).addClass("current")

  advance: =>
    window.clearTimeout(@advance_timeout)
    @hide()
    if @cur_fading_index < @$divs.length - 1
      @cur_fading_index++
    else
      @cur_fading_index = 0
    @fade_in()

  retreat: ->
    window.clearTimeout(@advance_timeout)
    @hide()
    if @cur_fading_index == 0
      @cur_fading_index = @$divs.length - 1
    else
      @cur_fading_index--
    @fade_in()

  manual_advance: (e, dir) =>
    return if $(e.target).hasClass("disabled")
    unless @cycling
      if $(e.target).hasClass("next")
        $(".ojp-marquee-nav li.prev").removeClass("disabled")
        if (@cur_fading_index + 2) == @$divs.length
          $(e.target).addClass("disabled")
      else
        $(".ojp-marquee-nav li.next").removeClass("disabled")
        if (@cur_fading_index - 1) == 0
          $(e.target).addClass("disabled")
    window.clearTimeout(@advance_timeout)
    @auto_advance = false
    if dir == 1 then @advance() else @retreat()

  pager_clicked: (index) ->
    window.clearTimeout(@advance_timeout)
    @auto_advance = false
    return if index == @cur_fading_index
    @hide()
    @cur_fading_index = index - 1
    @advance()

  hide: =>
    $(@$divs[@cur_fading_index]).fadeOut(@fade_speed)

  init_nav: ->
    @$container.append("<ul class='ojp-marquee-nav'><li class='prev'>Previous</li><li class='next'>Next</li>")
    $prev = $(".ojp-marquee-nav li.prev", @$container)
    unless @cycling
      $prev.addClass("disabled")
    $prev.click (e) => @manual_advance(e, -1)
    $(".ojp-marquee-nav li.next", @$container).click (e) => @manual_advance(e, 1)

  init_pager: ->
    unless @nav
      pager = "<ul class='ojp-marquee-nav'>"
    for div, i in @$divs
      if i == 0
        if @nav
          pager = "<li class='current'>#{i + 1}</li>"
        else
          pager += "<li class='current'>#{i + 1}</li>"
      else
        pager += "<li>#{i + 1}</li>"
    if @nav
      # insert into existing list
      $nav_next = $('.ojp-marquee-nav li.next', @$container)
      # change this - insert before doesnt take 2nd param
      next = $('.ojp-marquee-nav li.next', @$container)
      $(pager).insertBefore(next)
    else
      pager += "</ul>"
      @$container.append(pager)
