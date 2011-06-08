# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#


dimension = {'height' : 320, 'width' : 320}

window.draw = ->
    ctx = document.getElementsByTagName("canvas")[0].getContext("2d")
    if (ctx)
      ctx.lineWidth = 1
      ctx.strokeStyle = "#ccc"
      ctx.beginPath()
      width = parseInt(dimension['width'] / 2)
      height = parseInt(dimension['height'] / 2)
      for i in [0...window.size]
          do ->
            x = dimension['width'] * i
            # middle vertical line
            ctx.moveTo(width + x, 0)
            ctx.lineTo(width + x, dimension['height'])
            ctx.stroke()

            # middle horizontal line
            ctx.moveTo(0 + x, height)
            ctx.lineTo(dimension['width'] + x, height)
            ctx.stroke()

            # left bottom to right upper
            ctx.moveTo(0 + x, 0)
            ctx.lineTo(dimension['width'] + x, dimension['height'])
            ctx.stroke()

            # left top to right bottom
            ctx.moveTo(dimension['width'] + x, 0)
            ctx.lineTo(0 + x, dimension['height'])
            ctx.stroke()

            # inner box
            margin = 40
            margin_lux = x + margin
            margin_luy = margin
            margin_rux = dimension['width'] + x - margin
            margin_ruy = margin
            margin_lbx = x + margin
            margin_lby = dimension['height'] - margin
            margin_rbx = dimension['width'] + x - margin
            margin_rby = dimension['height'] - margin
            ctx.moveTo(margin_lux, margin_luy)
            ctx.lineTo(margin_rux, margin_ruy)
            ctx.stroke()
            ctx.moveTo(margin_lux, margin_luy)
            ctx.lineTo(margin_lbx, margin_lby)
            ctx.stroke()
            ctx.moveTo(margin_lbx, margin_lby)
            ctx.lineTo(margin_rbx, margin_rby)
            ctx.stroke()
            ctx.moveTo(margin_rux, margin_ruy)
            ctx.lineTo(margin_rbx, margin_rby)
            ctx.stroke()

            # seperator
            ctx.moveTo(dimension['width'] + x, 0)
            ctx.lineTo(dimension['width'] + x, dimension['height'])
            ctx.stroke()


jQuery ->

  if document.location.pathname.match(/exercises\/\d/)
    if document.location.pathname.match(/exercises\/1/)
      window.size = $('#hanzi-canvas').data("size") || 1
      $('#hanzi-canvas').scratchpad {
        'borderWidth': 3,
        'borderRadius': 10,
        'width': dimension['width'] * window.size,
        'height': dimension['height']
      }
      window.setTimeout("window.draw()",200)
      $('#hanzi-canvas input').bind 'click', ->  window.draw()
    if document.location.pathname.match(/exercises\/2/)
      hanzi = $('#hanzi').text().trim()
      $('.placeholder').html(hanzi).addClass("highlighted").removeClass("placeholder")


    $('.tooltip').qtip {
      content: 'Translating...',
      style: {
        tip: true,
        name: 'light'
      },
      api: {
        onRender: ->
          me = this
          hanzi = $(me.elements.target).text().trim()
          return false if hanzi=="_"
          link = "/exercises/tooltip"
          $.get link, "q=#{hanzi}", (data)->
            me.updateContent(data)
        }
      }


    $('#solve').click ->
      $('.unsolve').hide()
      $('.solve').fadeIn()
      hanzi = $('#hanzi-solution').text().trim()
      $('.placeholder').html(hanzi).addClass("highlighted") if hanzi?
      $('#hanzi').each ->
        tone = $(this).data('tone')
        $(this).addClass("hanzi-tone-#{tone}") if tone?
      $(document).bind 'keypress', (x) ->
        return true if $('#facebox').is(":visible")
        key=x.charCode
        switch key
          when 97 then $('#wrong').addClass("highlighted").click()
          when 115 then $('#mamahuhu').addClass("highlighted").click()
          when 100 then $('#right').addClass("highlighted").click()
        true
    $(document).bind "keypress", (x) ->
      return true if $('#facebox').is(":visible")
      if 119 == x.charCode
        $('#solve').addClass("highlighted").click()
      true



      window.setTimeout '$("#buttons .highlighted").removeClass("highlighted")', 500
      false
