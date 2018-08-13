'use strict';

exports.index = function (event, context, callback) {

    var body = "<h1>Getfnky API v0</h1>"

    var response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/html; charset=utf-8',
        },
        body: body,
    };
    callback(null, response);
};
