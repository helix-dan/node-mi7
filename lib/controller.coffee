path = require 'path'
fs   = require 'fs'
yaml = require 'js-yaml'
_    = require 'underscore'
EventEmitter = require("events").EventEmitter

class Controller extends EventEmitter
  
  constructor: (@params, @response) ->
    @actionName = @params.scr
    @beforeFiltersChain = []
    @contentType = 'text/plain'
    @actions = {}
    
  beforeFilters: ()->
    @beforeFilterStatus = true
    _.each @beforeFiltersChain, (options)=>
      all = (options.type == 'all')
      only = (options.type == 'only' && options.actions.indexOf(@actionName) != -1)
      except = (options.type == 'except' && options.actions.indexOf(@actionName) == -1)
      if all || only || except
        @excuteBeforeFilterSet options.filters
    @beforeFilterStatus
  
  excuteBeforeFilterSet: (filters)->
    _.each filters, (filter)=>
      if @beforeFilterStatus
        @[filter]()
    
  action: (actionName, callback)=>
    @actions[actionName] = callback
    @on actionName, callback
    
  callAction: ()->
    return unless @beforeFilters()
    @emit @actionName, @params, @response
  
  setBeforeFilters: (options)->
    @beforeFiltersChain.push(options)
    
  render: (object)->
    @beforeFilterStatus = false
    @response.set('Content-Type', @contentType);
    if typeof(object) == 'string'
      @response.body = object
    else
      @response.body = JSON.stringify(object)
    @response.send()

    
module.exports = Controller