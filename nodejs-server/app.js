var express = require('express');
var app = express();

app.set('port', 8080);
app.set('ip', "127.0.0.1");

var server = require('http').Server(app);
var io = require('socket.io')(server);

app.use(express.static('static'));
server.listen(app.get('port') ,app.get('ip'));
app.use(express.static('public/site'));

app.get('/', function(req, res) {
    res.sendFile(__dirname + '/public/site/Login.html');
});

app.get('/login', function(req, res) {
    res.sendFile(__dirname + '/public/site/Login.html');
});

io.on('connection', function(socket) {
    console.log('Client connected');
    socket.on('login', function(msg) {
        console.log(msg.user);
    });
});