// const axios = require('axios')
// const url = 'http://checkip.amazonaws.com/';
let response;

/**
 *
 * Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format
 * @param {Object} event - API Gateway Lambda Proxy Input Format
 *
 * Context doc: https://docs.aws.amazon.com/lambda/latest/dg/nodejs-prog-model-context.html
 * @param {Object} context
 *
 * Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
 * @returns {Object} object - API Gateway Lambda Proxy Output Format
 *
 */

exports.lambdaHandler = async (event, context) => {
  let path = event.path;
  let method = event.httpMethod;
  let body = JSON.parse(event.body);
  let param = event.queryStringParameters;

  try {
    if (path === '/hello' && method === 'GET') {
      return myResponseFunction(200, myGetFunction());
    } else if (path === '/hello' && method === 'POST') {
      return myResponseFunction(200, myPostFunction(body));
    } else if (path === '/hello/random' && method === 'GET') {
      return myResponseFunction(200, { random: myRandFunction(param.min, param.max) });
    } else {
      return myResponseFunction(200, {
        message: 'other conditions'
      });
    }
  } catch (err) {
    console.error(err);
    return myResponseFunction(404, {
      error: err
    });
  }
};

function myResponseFunction(code, obj) {
  return (response = {
    statusCode: code,
    body: JSON.stringify(obj)
  });
}

function myGetFunction() {
  return {
    message: 'Hello World!'
  };
}

function myPostFunction(bdy) {
  return bdy;
}

function myRandFunction(min = 0, max = 10) {
  return Math.random(min, max);
}
