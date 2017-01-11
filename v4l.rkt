#!/usr/bin/env racket
#lang racket/base

(require racket/match)

(require (prefix-in cmdline: racket/cmdline))
(require (prefix-in file: racket/file))
(require (prefix-in port: racket/port))
(require (prefix-in url: net/url))

(define (path-from-home-dir path)
  (string-append (path->string (find-system-path 'home-dir)) path))

(define API-ROOT "https://api.alpha.linode.com/v4")
(define parameter-url (make-parameter ""))
(define parameter-method (make-parameter "GET"))
(define parameter-body (make-parameter (string->bytes/utf-8 "")))
(define parameter-headers (make-parameter
                           (list
                            (format "Authorization: token ~a"
                                    (file:file->string (path-from-home-dir ".linode.token"))))))

(define (match-port method body headers)
  (match method
    ["GET" (lambda (url) (url:get-pure-port url headers))]
    ["HEAD" (lambda (url) (url:head-pure-port url headers))]
    ["POST" (lambda (url) (url:post-pure-port url body headers))]
    ["PUT" (lambda (url) (url:put-pure-port url body headers))]
    ["DELETE" (lambda (url) (url:delete-pure-port url headers))]))

(define (request path)
  (let ([url (string-append API-ROOT path)])
    (url:call/input-url (url:string->url url)
                        (match-port (parameter-method) (parameter-body) (parameter-headers))
                        port:port->string)))

(define (main path)
  (let* ([response (request path)])
    (display response)))

(module+ main
  (cmdline:command-line
   #:program "v4l"

   #:once-each
   [("-m" "--method") method
    "HTTP method to use in request"
    (parameter-method method)]

   #:once-each
   [("-d" "--data") body
    "HTTP body to send in request"
    (parameter-body (string->bytes/utf-8 body))]

   #:multi
   [("-H" "--header") header
    "HTTP header to add to request"
    (parameter-headers (cons header (parameter-headers)))]

   #:args (path)
   (main path)))
