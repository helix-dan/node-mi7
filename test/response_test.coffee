path = require "path"
_    = require "underscore"
Response = require path.join(__dirname, "../lib/response")
assert = require "assert"
require "should"

describe 'Response', ()=>
  
  describe '#constructor()', ()=>