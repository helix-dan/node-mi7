express       = require "express"
fs            = require "fs"
path          = require "path"
https         = require "https"
http          = require "http"
crypto        = require "crypto"
_             = require "underscore"
tokenBuilder = require "./tokenBuilder"
Params        = require path.join(__dirname, 'params')


class Application
  
  constructor: (@config)->
    @app = express()
    # 将所有的/mi7下的请求导向对应的subApp
    @app.all "/mi7/:sub_app", (req, res)=>
      # 根据该request创建基于该request的Params对象
      params = Params.build(req)
      token = new tokenBuilder(params)
      
      res.send JSON.stringify(token['token'])
  
  initSubApplications: ->
    @subApps = {}
  
  run: ->
    # 开始监听配置文件中指定的端口号启动服务
    #config = {
    #  .....
    #  port: 3000
    #  ssl: true|false         <= true为开启https
    #  ssl_key: "example.key"  <= ssl_key的文件名,该文件应该放置在config文件夹下
    #  .....
    #}
    if @config.ssl
      # 如果配置文件中ssl为true则启动为https服务器      
      https.createServer(@config.ssl_config, @app).listen(@config.port)
      console.info("HTTPS Port #{@config.port} now listening... ")
    else
      # 反之使用http服务器
      https.createServer(@app).listen(@config.port)
      console.info("HTTP Port #{@config.port} now listening... ")
  
  addSubApplication: (dirname) ->
    
  subApplicationDirs: ()->
    @sadirs = []
    sub_apps_dir = @config.sub_apps_dir
    dirs = fs.readdirSync(sub_apps_dir)
    _.each dirs, (name) =>
      stats = fs.statSync(path.join(sub_apps_dir, name))
      if stats.isDirectory()
        @sadirs.push(path.join(sub_apps_dir, name))
    @sadirs
    
module.exports = Application