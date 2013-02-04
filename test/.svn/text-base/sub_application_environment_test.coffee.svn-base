path = require "path"
fs   = require "fs" 
SubApplicationEnvironment = require path.join(__dirname, "../lib/sub_application_environment")
yaml = require "js-yaml"
assert = require "assert"
require "should"

describe 'SubApplicationEnvironment', () =>
  describe '#constructor', () =>
    it "should create a new env", (done)=>
      config = yaml.load(fs.readFileSync(path.join(__dirname, 'sub_apps/example/config.yml'), 'utf8'))
      console.log subenv.redis()
      subenv.redis().set 'keytest', 'valtest', (err, res)=>
        subenv.redis().get 'keytest', (err, res)=>
          res.should.equal('valtest')
          done()
    
    