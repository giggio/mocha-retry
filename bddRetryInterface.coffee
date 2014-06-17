interfaces = require('mocha').interfaces
RetryTest = require './retryTest'
module.exports = interfaces.bddretry = (suite) ->
  bdd = interfaces.bdd
  bdd suite
  suite.on 'pre-require', (context, file, mocha) ->
    context.it = context.itretry = (times, title, fn) ->
      unless fn?
        [title, fn] = [times, title]
        times = 1
      fn = null if suite.pending
      test = new RetryTest times, title, fn
      test.file = file
      suite.addTest test
      test
