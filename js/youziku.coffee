class FontLoader
  constructor: (@font_klass, @guid)->

  load: ->
    @chars_string = @get_chars_string @font_klass
    @md5 = jQuery.md5("#{@guid}#{@font_klass}#{@chars_string}")

    @check_font_generated {
      success: =>
        console.log 'success'
        @load_css()

      failure: =>
        console.log 'failure'
        @request_generate_font()

    }


  # 获取网页上应用了指定字体的所有字符组成的一个字符串
  # 用来向云服务请求生成字体
  get_chars_string: ->
    result_str = jQuery(".#{@font_klass}").text()
    result_str = Trim result_str
    result_str = SelectWord result_str


  # 检查字体是否生成
  check_font_generated: (options)->
    jQuery.getJSON "http://www.youziku.com/webfont/CSSPOST?jsoncallback=?", {
      'id': @md5
      'guid': @guid
      'type': '5'
    }, (json)->
      if json.result is 0
        options.failure()
      else
        options.success()


  # 请求云服务创建字库
  request_generate_font: ->
    jQuery.post 'http://www.youziku.com/webfont/PostCorsCreateFont', {
      'name': @font_klass
      'gid': @guid
      'type': '5'
      'text': @chars_string
    }, (json) =>
      @load()


  # 字库已经创建，加载 css
  load_css: ->
    # jQuery.get "http://www.youziku.com/webfont/css?id=#{@md5}&guid=#{@guid}&type=5", (res)=>
    #   console.log res

    loadExtentFile "http://www.youziku.com/webfont/css?id=#{@md5}&guid=#{@guid}&type=5"
    console.log "http://www.youziku.com/webfont/css?id=#{@md5}&guid=#{@guid}&type=5"
    jQuery(".#{@font_klass}")
      .animate
        'opacity': 1


jQuery ->
  # new FontLoader('minijianyingbikaishu', 'bad5fd4fc46844c4a586cb60cadf8e54').load()
  # new FontLoader('ygytljt', '314051d25b5f44a29225e086ea5c375e').load()
  new FontLoader('cyjlaosong', '1430f17463f747ae962a57fab6cb1985').load()
  # new FontLoader('AnJingCheng-Xing', '1280a17683f54a3f8d4784de3030d654').load()