# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  oldOffset = 0
  lastCall = Date.now()
  delay = 850

  formFill = (range, term, def) ->
    $('#word_term').val(term) 
    $('#word_definition').val(def)
    
    new_start = range.startOffset- 40
    if new_start < 0
      new_start = 0
    startNode = range.startContainer
    range.setStart(startNode, new_start)
    # startNode = range.startContainer.prevSibling
    # console.log startNode + "yes"
    # new_start = range.startOffset - 40
    new_end = range.startOffset + 60
    if new_end > startNode.length
      new_end =  startNode.length
    range.setEnd(startNode, new_end)
    range.setEndAfter(startNode) 
    sentences = range.toString()
    console.log(sentences)
    $('#word_sentence').val(sentences)
    # sentReg = /(.*?(。|？|！))/g
    # sentMatch = sentences.match(sentReg)
    # console.log(sentMatch[0])
    # console.log(sentMatch[1])
    # console.log(sentMatch[2])

  mechAjax = (mecabResp,range) ->
      $.ajax
        url: '/dic',
        data: { query: mecabResp.word },
        type: "POST",
        success: (mechResp) ->
          if mechResp.code == 0
            console.log("nothing from yahoo")
            return 0
          else
            $('h3.popover-title').html(mechResp.query)
            $('.popover-content').replaceWith(mechResp.def + 
              " <div id='footer'> <a href='#wordModal' data-toggle='modal' id='wordSave'>test</a></div>")
            console.log("Word: #{mechResp.word}   Definition: #{mechResp.def}")
            formFill(range, mechResp.query, mechResp.def) #i wonder how much this costs...


  highlight = (range, mecabresponse) ->
      if mecabresponse.offset_add != 0                             
        new_end = mecabresponse.offset_add + range.startOffset 
        range.setEnd(range.startContainer, new_end)
        sel = window.getSelection()
        sel.removeAllRanges()
        sel.addRange(range)
        return mechAjax(mecabresponse, range)

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
  
  setRange = (event) ->
    if document.caretPositionFromPoint
      #range = document.caretPositionFromPoint(event.pageX, event.pageY)
      #textNode = range.offsetNode
      #offset = range.offset
    else if document.caretRangeFromPoint
      console.log("oldOffset: #{oldOffset}")
      console.log event.pageX
      range = document.caretRangeFromPoint(event.pageX, event.pageY)
      textNode = range.startContainer  
      offset = range.startOffset
      if offset != oldOffset
        oldOffset = offset
        endset = offset+10
        range.setStart(textNode, offset)
        range.setEnd(textNode, endset)
        mecabAjax(event,range)


  throttleListener = (event) ->
    console.log (event.target).nextSibling
    now = Date.now()
    diff = now-lastCall
    if diff >= delay
      lastCall = now
      setRange(event)
    else
      return false


  element = document.getElementById("content") 
  element.addEventListener('mousemove', throttleListener , true)
  