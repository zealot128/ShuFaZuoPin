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
      ctx.moveTo(width, 0)
      ctx.lineTo(width, dimension['height'])
      ctx.stroke()
      ctx.moveTo(0, height)
      ctx.lineTo(dimension['width'], height)
      ctx.stroke()
      ctx.moveTo(0, 0)
      ctx.lineTo(dimension['width'], dimension['height'])
      ctx.stroke()
      ctx.moveTo(dimension['width'], 0)
      ctx.lineTo(0, dimension['height'])
      ctx.stroke()

jQuery ->
  $('#hanzi-canvas').scratchpad {
    'borderWidth': 3,
    'borderRadius': 10,
    'width': dimension['width'],
    'height': dimension['height']
  }
  $('#hanzi-canvas').bind 'click', ->  window.draw()

  if document.location.pathname.match(/exercises\/1/)
    window.setTimeout("window.draw()",200)

    $('#solve').click ->
      $('.solve').fadeIn()
      hanzi = $('#hanzi-solution').text().trim()
      $('.placeholder').html(hanzi).addClass("highlighted")
      false
    $(document).bind 'keypress', (x) ->
      key=x.charCode
      switch key
        when 119 then $('#solve').addClass("highlighted").click()
        when 97 then $('#wrong').addClass("highlighted").click()
        when 115 then $('#mamahuhu').addClass("highlighted").click()
        when 100 then $('#right').addClass("highlighted").click()

      window.setTimeout '$("#buttons .highlighted").removeClass("highlighted")', 500
      false
    #$(document).bind 'keypress', 'a', ->
      #$('#right').addClass("highlighted")
      #$('#right').click()
      #false
    #$(document).bind 'keypress', 'd', ->
      #$('#wrong').addClass("highlighted")
      #$('#wrong').click()
      #false
    #$(document).bind 'keypress', 's', ->
      #$('#mamhuhu').addClass("highlighted")
      #$('#mamhuhu').click()
      #false
