path = require "path"
fs   = require "fs" 
SubApplication = require path.join(__dirname, "../lib/sub_application")
yaml = require "js-yaml"
assert = require "assert"
require "should"

describe "SubApplication", ()=>
  describe "#constructor", ()=>
    it "should create a SubApplication instance", (done)=>
      subApplication = new SubApplication(path.join(__dirname, "sub_apps/example"))
      assert.equal typeof(subApplication.buildController()), "function"
      assert.equal subApplication.config.redis.master.host, 'localhost'
      subApplication.redis('master').set 'test_key01', 'test_val01', (err, res)=>
        subApplication.redis('master').get 'test_key01', (err, res)=>
          res.should.equal('test_val01')
          done()
      