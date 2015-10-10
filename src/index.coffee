Cache = require './cache'
NoCache = require './no-cache'

init = ->
  window.addEventListener 'cortex-ready', ->
    window.Cortex.app.getConfig()
      .then (config) ->
        cache = config['cortex.idt.cache']
        view = if cache == "true" then Cache else NoCache
        window.CortexView = new view
        window.Cortex.scheduler.onPrepare window.CortexView.prepare

      .catch (e) ->
        console.error 'Failed to initialize the application.', e
        throw e

module.exports = init()
