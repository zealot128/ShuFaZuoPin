# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.removeFlash = ->
  $("#flash .message").fadeOut "slow", ->
    $(this).css("position","relative").css("left","-2000px")

jQuery ->
  window.setTimeout("window.removeFlash()", 4000)
