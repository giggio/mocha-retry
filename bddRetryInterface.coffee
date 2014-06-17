RetryTest = require './retryTest'
Mocha = require 'mocha'
interfaces = Mocha.interfaces
Suite = Mocha.Suite
utils = Mocha.utils

module.exports = interfaces.bddretry = (suite) ->
  suites = [suite]
  suite.on "pre-require", (context, file, mocha) ->
    
    context.before = (name, fn) -> suites[0].beforeAll name, fn
    
    context.after = (name, fn) -> suites[0].afterAll name, fn
    
    context.beforeEach = (name, fn) -> suites[0].beforeEach name, fn
    
    context.afterEach = (name, fn) -> suites[0].afterEach name, fn
    
    context.describe = context.context = (times, title, fn) ->
      unless fn?
        [title, fn] = [times, title]
        times = undefined
      asuite = Suite.create(suites[0], title)
      asuite.times = times
      asuite.file = file
      suites.unshift asuite
      fn.call asuite
      suites.shift()
      asuite

    context.xdescribe = context.xcontext = context.describe.skip = (title, fn) ->
      asuite = Suite.create(suites[0], title)
      asuite.pending = true
      suites.unshift asuite
      fn.call asuite
      suites.shift()

    context.describe.only = (title, fn) ->
      asuite = context.describe title, fn
      mocha.grep asuite.fullTitle()
      asuite

    context.it = context.itretry = (times, title, fn) ->
      asuite = suites[0]
      unless fn?
        [title, fn] = [times, title]
        times = if asuite.times? then asuite.times else 1

      fn = null if asuite.pending
      test = new RetryTest times, title, fn
      test.file = file
      asuite.addTest test
      test
    
    context.it.only = (title, fn) ->
      test = context.it title, fn
      reString = "^" + utils.escapeRegexp(test.fullTitle()) + "$"
      mocha.grep new RegExp(reString)
      test

    context.xit = context.xspecify = context.it.skip = (title) -> context.it title
