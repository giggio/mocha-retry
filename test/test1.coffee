Q = require 'q'
chai = require 'chai'
chai.should()
#debugger
times = 0
describe 'a non retry suite', ->
  it 'works with a normal, non retry test', -> true
  it 'works with a normal, async, non retry test', (done) -> done()
describe 'a retry suite', ->
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
describe 'some non retry suite with before', ->
  valueAll = valueEach = undefined
  before -> valueAll = true
  beforeEach -> valueEach = true
  after -> valueAll = false
  afterEach -> valueEach = false
  it 'works with a normal, non retry test', ->
    valueEach.should.be.true
    valueAll.should.be.true
  it 'works with a normal, async, non retry test', (done) ->
    valueEach.should.be.true
    valueAll.should.be.true
    done()
describe 'some retry suite with before', ->
  valueAll = valueEach = undefined
  before -> valueAll = true
  beforeEach -> valueEach = true
  after -> valueAll = false
  afterEach -> valueEach = false
  it 2, 'works with a retried test not async', ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    if times % 2 is 0 then throw new Error "not even"
  it 2, 'works with a retried test with a promise', ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    Q.fcall -> if times % 2 is 0 then throw new Error "not even"
  it 2, 'works with a retried test with callback', (done) ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    if times % 2 is 0
      return done new Error "not even"
    done()
