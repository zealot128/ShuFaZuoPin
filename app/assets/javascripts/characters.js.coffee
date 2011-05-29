# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



window.autocomplete = () ->
  jQuery ->
    $('#selection_search').autocomplete {
      source: "/characters.json",
      selectFirst: true,
      minLength: 3,
      focus: (event,ui ) ->
          $( "#selection_search").val( ui.item.label )
          false
      select: (event,ui ) ->
          $( "#selection_search" ).val( ui.item.label )
          $( "#selection_character_id" ).val( ui.item.value )
          false
    }
