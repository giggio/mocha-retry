Q = require 'q'
chai = require 'chai'
chai.should()
#debugger
times = 0
describe 2, 'A retry suite', ->
  it 'works with a retried test not async', ->
    times++
    if times % 2 isnt 0 then throw new Error "not even"
  it 'works with a retried test with a promise', ->
    times++
    Q.fcall -> if times % 2 isnt 0 then throw new Error "not even"
  it 'works with a retried test with callback', (done) ->
    times++
    if times % 2 isnt 0
      return done new Error "not even"
    done()

describe 2, 'Some retry suite with before', ->
  valueAll = valueEach = undefined
  before -> valueAll = true
  beforeEach -> valueEach = true
  after -> valueAll = false
  afterEach -> valueEach = false
  it 'works with a retried test not async', ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    if times % 2 isnt 0 then throw new Error "not even"
  it 'works with a retried test with a promise', ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    Q.fcall -> if times % 2 isnt 0 then throw new Error "not even"
  it 'works with a retried test with callback', (done) ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    if times % 2 isnt 0
      return done new Error "not even"
    done()

describe 2, 'A retry suite with tests with retry', ->
  before -> times = 0
  it 4, 'works with a retried test not async', ->
    times++
    if times % 4 isnt 0 then throw new Error "cant divide by 4"
  it 4, 'works with a retried test with a promise', ->
    times++
    Q.fcall -> if times % 4 isnt 0 then throw new Error "cant divide by 4"
  it 4, 'works with a retried test with callback', (done) ->
    times++
    if times % 4 isnt 0
      return done new Error "cant divide by 4"
    done()
