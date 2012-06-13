
var DS = require('config').datasource;

console.log(DS.db)

var http = require("http"),
    url = require("url");


http.createServer(function(request, response) {
//    console.log('req:', request);
    console.log('url:', url.parse(request.url))
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("Hello World");
    response.end();
}).listen(8888);
