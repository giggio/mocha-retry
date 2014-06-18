Q = require 'q'
chai = require 'chai'
chai.should()
times = 0

describe 'Some suite with after and no retry', ->
  valueAll = 0
  after ->
    valueAll++
    if valueAll isnt 1 then throw new Error "has to be 1"
  it 'verifies the value', -> valueAll.should.equal 0
  it 'verifies the value again', -> valueAll.should.equal 0

describe 'Some suite with after and retry', ->
  valueAll = 0
  after 2, ->
    valueAll++
    if valueAll isnt 2 then throw new Error "at least 2"
  it 'verifies the value', -> valueAll.should.equal 0
  it 'verifies the value again', -> valueAll.should.equal 0

describe 'Some suite with afterEach and no retry', ->
  valueEach = 0
  afterEach ->
    valueEach+=2
    if valueEach % 2 isnt 0 then throw new Error "isnt even"
  it 'verifies the value once', -> valueEach.should.equal 0
  it 'verifies the value twice', -> valueEach.should.equal 2

describe 'Some suite with afterEach', ->
  valueEach = 0
  afterEach 2, ->
    valueEach++
    if valueEach % 2 isnt 0 then throw new Error "isnt even"
  it 'verifies the value once', -> valueEach.should.equal 0
  it 'verifies the value twice', -> valueEach.should.equal 2
