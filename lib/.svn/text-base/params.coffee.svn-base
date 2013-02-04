_ = require "underscore"

class Params

  @build: (request)->
    paramters = {} 
    # 将request中的多个上传参数merge到@paramters中
    _.extend paramters, request.params, request.body, request.query
    paramters

module.exports = Params