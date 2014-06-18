Q = require 'q'
chai = require 'chai'
chai.should()
#debugger
times = 0

#describe.only 'Some only retry suite', ->
  #it 'tests', -> true

#describe.only 2, 'The only retry suite', ->
  #it 'works with a retried test not async', ->
    #times++
    #if times % 2 isnt 0 then throw new Error "not even"
  #it 'works with a retried test with a promise', ->
    #times++
    #Q.fcall -> if times % 2 isnt 0 then throw new Error "not even"
  #it 'works with a retried test with callback', (done) ->
    #times++
    #if times % 2 isnt 0
      #return done new Error "not even"
    #done()

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

describe.skip 2, 'A skipped retry suite', ->
  it 'a test that will not run', ->
describe.skip 'A skipped non retry suite', ->
  it 'another test that will not run', ->

describe 2, 'A retry suite with a sub suite', ->
  describe 'A sub suite without retry defined', ->
    before -> times = 0
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
  describe 3, 'A sub suite with retry redefined', ->
    before -> times = 0
    it 'works with a retried test not async', ->
      times++
      if times % 3 isnt 0 then throw new Error "not divisible by 3"
    it 'works with a retried test with a promise', ->
      times++
      Q.fcall -> if times % 3 isnt 0 then throw new Error "not divisible by 3"
    it 'works with a retried test with callback', (done) ->
      times++
      if times % 3 isnt 0
        return done new Error "not divisible by 3"
      done()
