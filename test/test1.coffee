Q = require 'q'
chai = require 'chai'
chai.should()
#debugger
times = 0
describe 'a retry suite', ->
  it 'works with a normal, non retry test', -> true
  it 'works with a normal, async, non retry test', (done) -> done()
  it 2, 'works with a retried test not async', ->
    times++
    if times % 2 is 0 then throw new Error "not even"
  it 2, 'works with a retried test with a promise', ->
    times++
    Q.fcall -> if times % 2 is 0 then throw new Error "not even"
  it 2, 'works with a retried test with callback', (done) ->
    times++
    if times % 2 is 0
      return done new Error "not even"
    done()
