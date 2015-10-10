promise = require 'promise'

class Cache
  constructor: ->
    @_idx = 1
    @_prev = undefined

  prepare: (offer) =>
    container = document.getElementById('container')
    if @_idx > 6
      @_idx = 1

    @_getOrCreateNode @_idx
      .then (imgId) =>
        offer (done) =>
          if @_prev?
            prev = document.getElementById @_prev
            if prev?
              container.removeChild prev
            @_prev = undefined

          img = document.getElementById imgId
          if img?
            img.style.setProperty 'z-index', 9999
            end = =>
              @_prev = imgId
              done()
            setTimeout end, 5000
          else
            done()
      .catch (e) ->
        console.error e
        offer()

    @_idx += 1

  _getOrCreateNode: (id) ->
    new promise (resolve, reject) ->
      nid = "img-#{id}"
      img = document.getElementById nid
      if img?
        return resolve nid

      img = new Image()
      img.style.setProperty 'z-index', -9999
      img.id = nid
      img.onload = ->
        resolve nid
      img.onerror = reject
      img.src = "images/#{id}.jpg"
      container.appendChild img

module.exports = Cache
