module = (name) ->
  window[name] = window[name] or {}

module "OJP"
module "Insitu"

$ ->
  new OJP.Utils()
  new Insitu.Events()

  $(".ojp-marquee").each ->
    new OJP.Marquee($(this))


Insitu.Events = class Events
  
  constructor: ->
    @initNav()
    @timeoutInterval = 100
    @initVideos()

  initNav: ->
    _events = this

    $("#alt-nav").each ->
      $(this).change ->
        select = $(this)[0]
        location.href = select.options[select.selectedIndex].value

    $("nav#primary li").each ->
      # disable clicks for touch
      if OJP.Utils.browser.is_mobile
        $("a", $(this)).attr("href", "")
        $("a", $(this)).click -> return false

      nav_id = $(this).attr("id").substr(4)

      $(this).hover(
        ->
          window.clearTimeout(_events.timeout)
          _events.clearHoverStates()
          $("#subnav-" + nav_id).show()
          $(this).addClass("hover")
        ->
          _events.timeout = window.setTimeout _events.hideCallback, _events.timeoutInterval, nav_id
      )
      
    $("nav#secondary div.wrap").hover(
      ->
        window.clearTimeout(_events.timeout)
        _events.subnav_over = true
      ->
        _events.subnav_over = false
        nav_id = $(this).attr("id").substr(7)
        _events.hideCallback(nav_id)
    )

    # close buttons for touch
    $('.nav-close-btn').each ->
      id = $(this).parent().parent()[0].id.substr(3)
      $(this).bind('touchstart', (e) ->
        e.cancelBubble = true
        e.stopPropagation()
        $("#"+id).removeClass("hover")
        $(this).parent().parent().css("display", "none")
      )

    # print buttons
    $('.print-button button').click =>
        window.print()

    # regions
    $("#subnav-regions").each ->
      $("#nav-regions-list h3 a").each ->
        $(this).hover(
          -> overRegionsList($(this)),
          -> outRegionsList($(this))
        )

      overRegionsList = ($el) ->
        class_name = $el.attr("class")
        $("#regions-map div." + class_name + " a").addClass("hover")

      outRegionsList = ($el) ->
        class_name = $el.attr("class")
        $("#regions-map div." + class_name + " a").removeClass("hover")

      $("#regions-map div").each ->
        $(this).hover(
          -> overRegionMap($(this)),
          -> outRegionMap($(this))
        )

      overRegionMap = ($el) ->
        class_name = getClassName($el)
        $('#nav-regions-list a.' + class_name).addClass("hover")

      outRegionMap = ($el) ->
        class_name = getClassName($el)
        $('#nav-regions-list a.' + class_name).removeClass("hover")

      getClassName = ($el) ->
        re = /nav-region-(\S+)/
        class_name = $el.attr("class")
        match = class_name.match(re)
        if match
          class_name = match[0]

  hideCallback: (nav_id) ->
    unless @subnav_over
      $subnav_el = $("#subnav-" + nav_id)
      $nav_el = $("#nav-" + nav_id)
      $subnav_el.hide()
      $nav_el.removeClass("hover")

  clearHoverStates: ->
    $("nav#primary li").each(-> $(this).removeClass("hover"))
    $("nav#secondary div.wrap").each(-> $(this).css("display", "none"))

  resize: =>
    $('.video').each ->
      @cur_width = $(this).width()
      @max_width = $(this).attr("data-max-width")
      @ratio = $(this).attr("data-ratio")
      @height = Math.floor(Math.min(@cur_width, @max_width) * @ratio)
      $(this).height(@height)

  initVideos: ->
    if ($('.video').length > 0)
      $(window).resize => @resize()
      @resize()


OJP.Utils = class Utils

  @get_browser: ->
    b = {}
    if navigator.userAgent.toLowerCase().indexOf("mobile") > -1
      b.is_mobile = true
    if b.is_mobile && navigator.userAgent.toLowerCase().indexOf("applewebkit") > -1
      b.is_ios = true
    if navigator.userAgent.toLowerCase().indexOf("phone") > -1
      b.is_phone = true
    if navigator.userAgent.toLowerCase().indexOf("ipad") > -1
      b.is_ipad = true
    return b

  @browser: @get_browser()

  constructor: ->
    @site_utils()
    if OJP.Utils.browser.is_mobile
      $('body').addClass("is_mobile")

  site_utils: ->
    $(".placeholder").each ->
      $this = $(this)
      input = document.createElement('input')
      unless 'placeholder' in input
        defaultTxt = $this.attr("placeholder")
        $this.val(defaultTxt)
        $this.addClass("blurred")
        $this.focus ->
          if $this.val() == defaultTxt
            $this.val('')
            $this.removeClass("blurred")
        $this.blur ->
          if $this.val() == ""
            $this.val(defaultTxt)
            $this.addClass("blurred")

    $("a.tel").each(->
      if Utils.browser.is_phone
        num = $(this).text()
        num = num.replace(/(\.|-|\)|\(|\s)/g, "")
        if num.indexOf("+") > -1
          href = "tel://#{num}"
        else
          href = "tel://1-#{num}"
        $(this).attr("href", href)
    )

    # file type icons
    $("a.file").each(->
      filetypes =
        pdf: ["pdf"],
        doc: ["doc", "docx"],
        xls: ["xls", "xlsx"],
        txt: ["txt"],
        zip: ["zip"]
      href = $(this)[0].href
      ext = href.match(/(?!\.)[a-zA-Z]{3,4}$/)
      if ext
        ext = ext[0]
        for k, v of filetypes
          $(this).addClass(k) if ext in v
    )
