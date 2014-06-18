Q = require 'q'
chai = require 'chai'
chai.should()
#debugger
times = 0
describe 'A non retry suite', ->
  it 'works with a normal, non retry test', -> true
  it 'works with a normal, async, non retry test', (done) -> done()
describe 'A suite with tests with retry', ->
  it 2, 'works with a retried test not async', ->
    times++
    if times % 2 isnt 0 then throw new Error "not even"
  it 2, 'works with a retried test with a promise', ->
    times++
    Q.fcall -> if times % 2 isnt 0 then throw new Error "not even"
  it 2, 'works with a retried test with callback', (done) ->
    times++
    if times % 2 isnt 0
      return done new Error "not even"
    done()
  it.skip 3, 'a test that will not run', ->
  it.skip 'another test that will not run', ->
  #it.only 'some only test', -> true
  #it.only 2, 'an only test', ->
    #times++
    #if times % 2 isnt 0 then throw new Error "not even"

describe 'Some non retry suite with before', ->
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

describe 'Some retry suite with before with retry on tests', ->
  valueAll = valueEach = undefined
  before -> valueAll = true
  beforeEach -> valueEach = true
  after -> valueAll = false
  afterEach -> valueEach = false
  it 2, 'works with a retried test not async', ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    if times % 2 isnt 0 then throw new Error "not even"
  it 2, 'works with a retried test with a promise', ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    Q.fcall -> if times % 2 isnt 0 then throw new Error "not even"
  it 2, 'works with a retried test with callback', (done) ->
    valueEach.should.be.true
    valueAll.should.be.true
    times++
    if times % 2 isnt 0
      return done new Error "not even"
    done()
