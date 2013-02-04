path = require "path"
fs = require "fs"
Application = require path.join(__dirname, "../lib/application")
assert = require "assert"
yaml   = require "js-yaml"
require "should"


describe 'Application', ()=>
  describe '#constructor', ()=>
    it "should new a application", ()=>
      config = {
        port: 3000
        sub_apps_dir: path.join(__dirname, 'sub_apps')
        ssl: true
        ssl_key:  "server.key"
        ssl_cert: "server.crt"
        socket:
          port: 8088
          subscribe:
            host: '192.168.2.18'
            port: 6379
            channel: 'lottory1'
      }
      application = new Application(config)
      console.log application.subApplicationDirs()
      application.subApplicationDirs().indexOf(path.join(__dirname, 'sub_apps/example')).should.not.equal(-1)