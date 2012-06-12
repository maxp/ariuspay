
// openssl genrsa -out server-key.pem 1024
// openssl req -new -key server-key.pem -out server-csr.pem
// openssl x509 -req -in server-csr.pem -signkey server-key.pem -out server-cert.pem



var https = require('https');
https.createServer({
        key: fs.readFileSync('server-key.pem'),
        cert: fs.readFileSync('server-cert.pem')
    },
    function (req,res) {
        //...
    });
//


var https = require('https');
var fs = require('fs');

var hskey = fs.readFileSync('hacksparrow-key.pem');
var hscert = fs.readFileSync('hacksparrow-cert.pem')

var options = {
    key: hskey,
    cert: hscert
};

https.createServer(options, function (req, res) {
    res.writeHead(200);
    res.end("Hi from HTTPS");
}).listen(8000);


/*
 http://blog.james-carr.org/2010/07/26/using-an-ssl-certificate-to-make-a-secure-http-request-in-nodejs/
 */

var fs = require('fs'),
    crypto = require('crypto')

fs.readFileSync('./certs/private-key.pem', 'ascii', function(key){
    fs.readFileSync('./certs/public-cert.pem', 'ascii', function(cert){
        var credentials = crypto.createCredentials({key:key, cert:cert})
    })
})

var fs = require('fs'),
    crypto = require('crypto'),
    http = require('http')

fs.readFileSync('./certs/private-key.pem', 'ascii', function(key){
    fs.readFileSync('./certs/public-cert.pem', 'ascii', function(cert){
        var credentials = crypto.createCredentials({key:key, cert:cert})
        var client = http.createClient(443, 'api.paypal.com', true, credentials)

        // make a request like any other request
    })
})


