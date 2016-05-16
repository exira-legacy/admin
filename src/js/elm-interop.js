'use strict';

var lock = new Auth0Lock('CIikEka4ppyhBX9akgoFCaNU74ApCKUH', 'exira.eu.auth0.com');

var main = Elm.Main.fullscreen();

main.ports.showLock.subscribe(function (opts) {
    lock.show(opts);
});

main.ports.logout.subscribe(function () {
    window.localStorage.removeItem('id_token');
    lock.logout({ returnTo: 'https://exira.com' });
});

function passTokenToElm(token) {
    lock.getProfile(token, function (err, profile) {
        var result = { err: null, ok: null };

        if (!err) {
            result.ok = { profile: profile, token: token };
        } else {
            result.err = err.details;
        }

        main.ports.authResult.send(result);
    });
}

function checkAuthentication() {
    var id_token = window.localStorage.getItem('id_token');
    if (id_token) {
        passTokenToElm(id_token);
        return;
    }

    var result = lock.parseHash(window.location.hash);
    if (result) {
        window.location.hash = ' ';
        if (result.error) {
            // error logging in
            // todo: let elm know, result.error - result.error_description
        } else {
            window.localStorage.setItem('id_token', result.id_token);
            passTokenToElm(result.id_token);
        }
    }
}

setTimeout(function() { checkAuthentication(); }, 0)
