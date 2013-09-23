# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  oldOffset = 0

  mechAjax = (mecabResp) ->
      $.ajax
        url: '/dic',
        data: { query: mecabResp.word },
        type: "POST",
        success: (mechResp) ->
          if mechResp.code == 0
            console.log("nothing from yahoo")
            return 0
          else
            $('.popover-content').replaceWith(mechResp.def)
            console.log("Word: #{mechResp.word}   Definition: #{mechResp.def}")


  highlight = (range, mecabresponse) ->
      if mecabresponse.offset_add != 0                             
        new_end = mecabresponse.offset_add + range.startOffset 
        range.setEnd(range.startContainer, new_end)
        sel = window.getSelection()
        sel.removeAllRanges()
        sel.addRange(range)
        return mechAjax(mecabresponse)

  mecabAjax = (event, range) ->
    $('#content').popover('destroy')
    word = range.toString()
    $('#content').popover(placement: 'mouse', coorX: event.pageX, coorY: event.pageY, html: true, title: 'test', content: "<img src='/assets/ajax-loader.gif'>", trigger: 'focus').popover('show')
    $.ajax
      url: '/search',
      data: { query: word  },
      type: "POST",
      success: (mecabResp) ->
        if mecabResp.word == false
          console.log("negative from mecab")
          return 0
        else
          return highlight(range, mecabResp)
  
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
        mecabAjax(event,range)

            
       
    #  $('#content').popover('title', "test")
    
           
      

    
    
  element = document.getElementById("content")
  element.addEventListener('mousemove', setRange, true) 


