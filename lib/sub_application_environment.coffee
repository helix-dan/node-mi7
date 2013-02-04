_ = require 'underscore'
redis = require 'redis'

class SubApplicationEnviroment
  
  # 本controller主要用于储存subapplication需要使用的mi1服务器地址,数据库连接等运行controller要使用到的环境对象
  
  constructor: (@config)->
    @setRedises()
    
  setRedises: ->
    unless @config.redis == undefined
      @redises = {}
      _.each @config.redis, (val, key)=>
        @redises[key] = redis.createClient(val)
    
  setDatabases: ->
    # todo: 暂时不需要实现
    
  setRouter: ->
    @router = @config.router
    
  redis: (connection='slave')->
    @redises[connection]
    
module.exports = SubApplicationEnviroment

    