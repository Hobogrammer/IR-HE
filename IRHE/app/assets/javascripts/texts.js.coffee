# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  setRange = (event) ->
    if document.caretPositionFromPoint
      #range = document.caretPositionFromPoint(event.pageX, event.pageY)
      #textNode = range.offsetNode
      #offset = range.offset
    else if document.caretRangeFromPoint
      range = document.caretRangeFromPoint(event.pageX, event.pageY)
      textNode = range.startContainer
      offset = range.startOffset
      endset = offset+10
      range.setStart(textNode, offset)
      range.setEnd(textNode, endset)
      test = range.toString()
      new_end = ajax_request(test)
       
      console.log("#{new_end}")
      if new_end != 0
        new_end = new_end + offset
        range.setEnd(textNode, new_end)
        #sel = window.getSelection()
        #sel.removeAllRanges()
        #sel.addRange(range)
      
     
      

  ajax_request = (text) ->
    $.ajax
      url: '/search',
      data: { query: text },
      type: "POST",
      success: (resp) ->
        if resp.code == 0
          console.log("Nothing found")
          return 0
        else if resp.code == 2
          test = resp.offset_add
          console.log("Highlighted: #{resp.query}   Additional Offset: #{resp.offset_add}   Definition: #{resp.def}")
          return test 
    
    
  element = document.getElementById("content")
  element.addEventListener('mousemove', setRange, true) 


 

  getTextNodes = (node) ->
    textNodes = []
    if node.nodeType ==3
      textNodes.push(node)
    else
      children = node.childNodes
      for child, i in children by 1
        textNodes.push.call(textNodes, getTextNodes(child))
        




