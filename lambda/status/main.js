'use strict';

exports.status = function (event, context, callback) {

    var body = {
      'status': 'online'
    }

    var response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json; charset=utf-8',
        },
        body: JSON.stringify(body),
    };
    callback(null, response);
};
