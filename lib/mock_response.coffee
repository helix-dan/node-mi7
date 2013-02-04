EventEmitter = require("events").EventEmitter
class MockResponse extends EventEmitter
  
  constructor: ()->
    @header = {}
    @body = null
    
  set: (key, val)->
    @header[key] = val

  get: (key)->
    @header[key]
    
  send: ()->
    @emit 'getResult', @

module.exports = MockResponse
  