yaml = require 'js-yaml'
fs   = require 'fs'
path = require 'path'
redis = require 'redis'
_    = require 'underscore'

class SubApplication
  
  constructor: (@dirname) ->
    @config = yaml.load(fs.readFileSync(path.join(@dirname, 'config.yml'), 'utf8'))
    # @Controller = require(path.join(@dirname, 'controller'))
    @createRedisConns()
    
  buildController: ->
    () ->
      
  redis: (type='slave')->
    @redisConns[type]
    
  createRedisConns: ()->
    @redisConns = {}
    _.each @config.redis, (val, key) =>
      @redisConns[key] = redis.createClient(val)
  
module.exports = SubApplication