path = require "path"
TokenBuilder = require path.join(__dirname, "../lib/tokenBuilder")
assert = require "assert"
require "should"

describe 'TokenBuilder', ()=>
  describe '#new', ()=>
    it "should return a attributesString", ()=>
      obj = {a: 1, b: 2, d: 1, c: 5}
      tokenBuilder = new TokenBuilder(obj)
      tokenBuilder.attributesString.should.equal('a=1&b=2&c=5&d=1')
      tokenBuilder.token.should.equal('577e9c8046f4871de9df6069be1745f5')