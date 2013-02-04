path = require "path"
_    = require "underscore"
global.Controller = require path.join(__dirname, "../lib/controller")
Controller = _.extend(require(path.join(__dirname, "sub_apps/example/controller")), require(path.join(__dirname, "../lib/action")))
MockResponse = require path.join(__dirname, "../lib/mock_response")
assert = require "assert"
require "should"

describe 'Controller', ()=>
  
  paramters = null 
  controller = null 
  response = null
    
  
  beforeEach (done)=>
    paramters = {test_param01: 'test_params_val01', args01: '1', args02: '2', scr: 'test_action01'}
    response = new MockResponse()
    controller = new Controller(paramters, response)
    controller.action 'test_action01', (params, response)=>
      controller.render(parseInt(params.args01) + parseInt(params.args02))
    controller.action 'test_action02', (params, response)=>
      controller.render(parseInt(params.args02) - parseInt(params.args01))
    controller.action 'test_action03', (params, response)=>
      controller.render(parseInt(params.args02) * parseInt(params.args01))
    done()     
    
  describe 'callAction()', ()=>
    it "should call a be added event", (done)=>
      response.on 'getResult', (response)=>
        response.body.should.equal('3')
        done()
      controller.callAction()
     
      
  describe "#setBeforeFilters(options)", ()=>
    it "should register filter methods to all actions", (done)=>
      options = {
        type: 'all',
        filters: ['filter00', 'filter01']
      }
      controller.filter00 = ()=>
        controller.render({rv: 1})
      controller.filter01 = ()=>
        throw new Error
      controller.setBeforeFilters(options)
      controller.beforeFiltersChain[0].should.equal(options)
      response.on 'getResult', (response)=>
        response.body.should.equal(JSON.stringify({rv: 1}))
        done()
      controller.callAction()
    
    it "should trigger a only filter", (done)=>
      options = {
        type: 'only',
        actions: ['test_action01'],
        filters: ['filter00']
      }
      controller.filter00 = ()=>
        controller.render({rv: 1})
      controller.setBeforeFilters(options)
      response.on 'getResult', (response)=>
        response.body.should.equal(JSON.stringify({rv: 1}))
        done()
      controller.callAction()
      
    it "should not trigger the only filter which did`t point to the action", (done)->
      options = {
        type: 'only',
        actions: ['test_action02'],
        filters: ['filter00']
      }
      controller.filter00 = ()=>
        controller.render({rv: 1})
      controller.setBeforeFilters(options)
      response.on 'getResult', (response)=>
        response.body.should.equal('3')
        done()
      controller.callAction()
      
    it "should trigger the except filter which did`t point to the action be called", (done)->
      options = {
        type: 'except',
        actions: ['test_action02'],
        filters: ['filter00']
      }
      controller.filter00 = ()=>
        controller.render({rv: 1})
      controller.setBeforeFilters(options)
      response.on 'getResult', (response)=>
        response.body.should.equal(JSON.stringify({rv: 1}))
        done()
      controller.callAction()
      
    it "should not trigger the except filter which did`t point to the action be called", (done)->
      options = {
        type: 'except',
        actions: ['test_action01'],
        filters: ['filter00']
      }
      controller.filter00 = ()=>
        controller.render({rv: 1})
      controller.setBeforeFilters(options)
      response.on 'getResult', (response)=>
        response.body.should.equal('3')
        done()
      controller.callAction()

  describe "#render(object)", ()=>
    it "should return a response", (done)=>
      response.on 'getResult', (response)=>
        response.get('Content-Type').should.equal('application/json')
        response.body.should.equal(JSON.stringify({rv: '0', msg: 'test'}))
        done()
      controller.contentType = 'application/json'
      controller.render({rv: '0', msg: 'test'})
      
    # it "should call filter", (done)=>
    #   options = {
    #     type: 'all',
    #     filters: ['filter00']
    #   }
    #   controller.setBeforeFilters(options)
    #   controller.filter00 = ()->
    #     render(null)
    #   done()

      