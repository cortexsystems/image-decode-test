class NoCache
  constructor: ->
    @_idx = 1

  prepare: (offer) =>
    container = document.getElementById('container')
    if @_idx > 6
      @_idx = 1

    url = "images/#{@_idx}.jpg"
    @_idx += 1

    img = new Image()
    img.onload = ->
      offer (done) ->
        while container.firstChild?
          container.removeChild container.firstChild

        container.appendChild img
        setTimeout done, 5000

    img.onerror = ->
      offer()

    img.src = url

module.exports = NoCache
