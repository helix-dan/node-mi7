redis   = require('redis')
fs      = require('fs')
yaml    = require('js-yaml')
config  = yaml.load(fs.readFileSync('config/mi7.yml', 'utf8'))
io      = require('socket.io').listen(config.socket.port)
io.sockets.on 'connection', (socket) =>
console.log socket


console.log config.socket.subscribe.channel

redis = redis.createClient(config.socket.subscribe.port, config.socket.subscribe.host)

redis.subscribe config.socket.subscribe.channel

redis.on 'message', (channel, data)  =>
console.log data
io.sockets.send(data)
