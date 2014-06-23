Q = require 'q'
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

describe 'After all using global default retry', ->
  global.DEFAULT_RETRY = 2
  describe 'inner suite (needed to apply global retry)', ->
    valueAll = 0
    after ->
      valueAll++
      if valueAll isnt 2 then throw new Error "at least 2"
    it 'verifies the value', -> valueAll.should.equal 0
    it 'verifies the value again', -> valueAll.should.equal 0
delete global.DEFAULT_RETRY

describe 'After all With global default retry but overriding it', ->
  global.DEFAULT_RETRY = 2
  before -> times = 0
  describe 'inner suite with specific retry (needed to apply global retry)', ->
    valueAll = 0
    after 3, ->
      valueAll++
      if valueAll isnt 3 then throw new Error "at least 3"
    it 'verifies the value', -> valueAll.should.equal 0
    it 'verifies the value again', -> valueAll.should.equal 0
delete global.DEFAULT_RETRY

describe 'After each using global default retry', ->
  global.DEFAULT_RETRY = 2
  describe 'inner suite (needed to apply global retry)', ->
    valueEach = 0
    afterEach ->
      valueEach++
      if valueEach % 2 isnt 0 then throw new Error "isnt even"
    it 'verifies the value once', -> valueEach.should.equal 0
    it 'verifies the value twice', -> valueEach.should.equal 2
delete global.DEFAULT_RETRY

describe 'After each With global default retry but overriding it', ->
  global.DEFAULT_RETRY = 2
  before -> times = 0
  describe 'inner suite with specific retry (needed to apply global retry)', ->
    valueEach = 0
    afterEach 3, ->
      valueEach++
      if valueEach % 3 isnt 0 then throw new Error "isnt three"
    it 'verifies the value once', -> valueEach.should.equal 0
    it 'verifies the value three times', -> valueEach.should.equal 3
delete global.DEFAULT_RETRY
