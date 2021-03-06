chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'glink', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/glink')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/graphme (.*)/)

  it 'registers a respond listener for teachme', ->
    expect(@robot.respond).to.have.been.calledWith(/teachme(\s.*)?/)

  it 'registers a respond listener for alias', ->
    expect(@robot.respond).to.have.been.calledWith(/alias (.*) as (.*)/)

  it 'registers a respond listener for aliases', ->
    expect(@robot.respond).to.have.been.calledWith(/aliases/)
