# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  oldOffset = 0

  setRange = (event, highlight) ->
    if document.caretPositionFromPoint
      #range = document.caretPositionFromPoint(event.pageX, event.pageY)
      #textNode = range.offsetNode
      #offset = range.offset
    else if document.caretRangeFromPoint
      console.log("oldOffset: #{oldOffset}")
      range = document.caretRangeFromPoint(event.pageX, event.pageY)
      textNode = range.startContainer  
      offset = range.startOffset
      if offset != oldOffset
        oldOffset = offset
        endset = offset+10
        range.setStart(textNode, offset)
        range.setEnd(textNode, endset)
        words = range.toString()
            
       
    #  $('#content').popover('title', "test")
     
    highlight = (range, mecabresponse, mechresponse) ->
      if response.offset_add != 0                             
        new_end = response.offset_add + offset 
        range.setEnd(textNode, new_end)
        sel = window.getSelection()
        sel.removeAllRanges()
        sel.addRange(range)
      
    mecabAjax = (range, words) ->
      $.ajax
        url: '/search',
        data: { query: words },
        type: "POST",
        success: (mecabResp) ->
          if mecabResp.word == false
            console.log("negative from mecab")
            return 0
          else
            return mechAjax(range, mecabResp)

    mechAjax = (range, mecabResp) ->
      $.ajax
        url: '/dic',
        data: { query: mecabResp.word },
        type: "POST",
        success: (mechResp) ->
          if mechResp.code == 0
            console.log("nothing from yahoo")
            return 0
          else
            return highlight(range, mecabResp, mechResp) #putting this here still has the problem of waiting on yahoo before highlight,
     
      

    
    
  element = document.getElementById("content")
  element.addEventListener('mousemove', setRange, true) 


