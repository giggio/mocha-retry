Q = require 'q'
chai = require 'chai'
chai.should()
times = 0

describe 'Some suite with before and no retry', ->
  valueAll = 0
  before ->
    valueAll += 2
    if valueAll isnt 2 then throw new Error "has to be 2"
  it 'verifies the value', -> valueAll.should.equal 2
  it 'verifies the value again', -> valueAll.should.equal 2

describe 'Some suite with before with retry', ->
  valueAll = 0
  before 2, ->
    valueAll++
    if valueAll isnt 2 then throw new Error "at least 2"
  it 'verifies the value', -> valueAll.should.equal 2
  it 'verifies the value again', -> valueAll.should.equal 2

describe 'Some suite with beforeEach and no retry', ->
  valueEach = 0
  beforeEach ->
    valueEach += 2
    if valueEach % 2 isnt 0 then throw new Error "isnt even"
  it 'verifies the value once', -> valueEach.should.equal 2
  it 'verifies the value twice', -> valueEach.should.equal 4

describe 'Some suite with beforeEach with retry', ->
  valueEach = 0
  beforeEach 2, ->
    valueEach++
    if valueEach % 2 isnt 0 then throw new Error "isnt even"
  it 'verifies the value once', -> valueEach.should.equal 2
  it 'verifies the value twice', -> valueEach.should.equal 4
