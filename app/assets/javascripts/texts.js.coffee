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
        $.ajax
          url: '/search',
          data: { query: words },
          type: "POST",
          success: (resp) ->
            if resp.code == 0
              console.log("Nothing found")
              return 0
            else if resp.code == 2
              test = resp.offset_add
              console.log("Highlighted: #{resp.query}   Additional Offset: #{resp.offset_add}   Definition: #{resp.def}")
              return highlight(range,resp)
            
       
    #  $('#content').popover('title', "test")
     
    highlight = (range, response) ->
      if response.offset_add != 0                             
        new_end = response.offset_add + offset 
        range.setEnd(textNode, new_end)
        sel = window.getSelection()
        sel.removeAllRanges()
        sel.addRange(range)
      
     
      

    
    
  element = document.getElementById("content")
  element.addEventListener('mousemove', setRange, true) 


