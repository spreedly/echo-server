echo-server
===========

A simple Rack-based echo server

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Usage

This echo server takes an HTTP request and returns the request headers and request body as a text-formatted response:

```console
$ curl http://spreedly-echo.herokuapp.com \
-u 'test:password' \
-H "Content-Type: application/xml" \
-d '<request><element /></request>'

HOST: spreedly-echo.herokuapp.com
CONNECTION: close
AUTHORIZATION: Basic dGVzdDpwYXNzd29yZA==
USER_AGENT: curl/7.30.0
ACCEPT: */*
X_REQUEST_ID: b6765e03-0511-407d-9eca-b77016361ad4
X_FORWARDED_FOR: 65.190.62.114
X_FORWARDED_PROTO: http
X_FORWARDED_PORT: 80
VIA: 1.1 vegur
CONNECT_TIME: 1
X_REQUEST_START: 1407774923595
TOTAL_ROUTE_TIME: 1

<request><element /></request>
```

The format of the response body is:

```
Request header: header value
Request header: header value

Request body
```

## Performance testing

If you are using the echo server for the purpose of performance testing some HTTP round trip, it may be useful to know the processing time of the echo server. There is an `X-Runtime` header returned in the response (as a header, not printed out in the response body) that includes the processing time in seconds.

Use the `-v` flag in curl to see this value:

```console
$ curl -v http://spreedly-echo.herokuapp.com -u 'test:password' -H "Content-Type: application/xml" -d '<request><element /></request>'
* Adding handle: conn: 0x7fda79803a00
...
< X-Runtime: 0.000563
...
```

Here, the request took .563 milliseconds to process.

**Note:** There may be (significant) overhead to this request time depending on your hosting infrastructure for the echo server. For instance, SSL termination will add connection overhead, as will routing through a cloud provider such as Heroku (where 40-50ms is standard for the most performant apps on their development service tier dynos).

To time a request end-to-end use a client-side tool such as the `time` utility:

```console
$ time curl http://spreedly-echo.herokuapp.com \
-u 'test:password' \
-H "Content-Type: application/xml" \
-d '<request><element /></request>'

...
real	0m0.166s
user	0m0.110s
sys	0m0.007s
```

Knowing that a request to the echo server completes its path through the Heroku server environment in ~50ms, and seeing an end to end time here of .166 seconds (166ms) we can conclude an HTTP connection overhead and network latency of about 100ms.
