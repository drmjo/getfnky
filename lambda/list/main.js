'use strict';

exports.list = function (event, context, callback) {

    var body = {
      'packages': [
        'function-1',
        'function-2',
        'function-3',
        'function-4',
        'function-5',
      ]
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
