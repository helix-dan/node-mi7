_ = require 'underscore'
crypto = require 'crypto'

class TokenBuilder
	
  constructor: (@object) ->
    @attributes = _.map @object, (val, key)=>
      "#{key}=#{val}"
    @attributes = _.sortBy @attributes, (pair)=>
      pair
    @attributesString = @attributes.join("&")  
    md5 = crypto.createHash('md5')
    @token = md5.update(@attributesString, 'utf8').digest("hex")
    
module.exports = TokenBuilder