var socket = io('http://127.0.0.1:8080');

function user_isValid(username) {
    return username.match(/^[a-z0-9A-Z_-]{4,20}$/);
}

$(document).ready(function() {

    $('#login-button').click(function () {
        let login_val = $('#Login').val();
        if (user_isValid(login_val)) {
            socket.emit('login', {user: login_val});
        }
        else {
            alert('Invalid username!');
        }
    });
});