var https       = require('https');
var fs          = require('fs');
var url         = require('url');
var _           = require('underscore');
var yaml        = require('js-yaml');
var querystring = require('querystring');


var config = yaml.load(fs.readFileSync('config/mi7.yml', 'utf8'));
// console.log(config);


var options = {
  key: fs.readFileSync('config/server.key'),
  cert: fs.readFileSync('config/server.crt')
};
// console.log(options);


// merge the options and return
mergeOptions = function(obj1, obj2){
  var obj3;

  _.each(obj1, function(value, key){
    obj3[key] = value;
  });

  _.each(obj2, function(value, key){
    obj3[key] = value;
  });

  return obj3;
}


// use which server? aws or ali_cloud
whichSite = function(params){
  server = 'slave_server';

  _.each(params, function(value, key){
    if (config.master_flags.key){
      var vals = config.master_flags.key;
      console.log(vals + "====" + value + "====" + key); 
      if (vals.indexOf(val) !== -1){
        return server = 'master_server';
      }
    }
  })
}


// send request
sendHttpsRequest = function(path, data, callback){
  console.log(data);
  var buffer = '';
  var conf = whichSite(data);

  var options = {
    hostname: conf.host,
    port: conf.port,
    method: 'POST',
    path: path,
    headers: {
      'content-length': data.length
    }
  };

  var request = https.request(options, function(response){
    response.on('data', function(chunk){
      return buffer += chunk;
    });

    response.on('end', function(){
      return callback(buffer, null);
    });
  });

  request.write(data);
  request.end();

  request.on('error', function(e){
    return callback(null, e);
  });
};



server = https.createServer(options, function(request, response){
  var buffer = '';
  request.on('data', function(data){
    buffer += data;
    console.log("==" + buffer);
  });

  response.writeHead(200);
  response.end("test mi7");

  request.on('end', function(){
    var params = mergeOptions(querystring.parse(buffer), querystring.parse(url.parse(request.url).query));
    // console.log(params);
    // console.log(url.parse(request.url));
    sendHttpsRequest();
  })

});


server.listen(3104, '127.0.0.1');

console.log("success to start the server");