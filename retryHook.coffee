RetryHook = (times, title, fn) ->
  Runnable.call @, title, fn
  @times = times
  @type = "hook"

RetryHook::error = (err) ->
  if arguments.length is 0
    err = @_error
    @_error = null
    return err
  @_error = err

RetryHook::run = (fn) ->
  finished = emitted = undefined
  runTimes = 1

  # called multiple times
  multiple = (err) =>
    return if emitted
    emitted = true
    @emit "error", err or new Error("done() called multiple times")

  # finished
  done = (err) =>
    return if @timedOut
    return multiple err if finished
    if err? and runTimes isnt @times
      runTimes++
      start = new Date
      return @_run fn, done
    @clearTimeout()
    @duration = new Date - start
    finished = true
    fn err

  start = new Date
  @_run fn, done

RetryHook::_run = (fn, done) ->
  ms = @timeout()
  ctx = @ctx

  ctx.runnable @ if ctx
  
  # for .resetTimeout()
  @callback = done
  
  # explicit async with `done` argument
  if @async
    @resetTimeout()
    try
      @fn.call ctx, (err) ->
        return done(err) if err instanceof Error or toString.call(err) is "[object Error]"
        return done(new Error("done() invoked with non-Error: " + err)) if err?
        done()
    catch err
      done err
    return

  return done(new Error("--async-only option in use without declaring `done()`")) if @asyncOnly

  callFn = (fn) =>
    result = fn.call ctx
    if result and typeof result.then is "function"
      @resetTimeout()
      result.then (-> done()), done
    else
      done()

  # sync or promise-returning
  try
    if @pending
      done()
    else
      callFn @fn
  catch err
    done err

Runnable = require("mocha").Runnable
RetryHook::__proto__ = Runnable::
module.exports = RetryHook
