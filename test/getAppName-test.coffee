chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
getAppName = require '../lib/getAppName'

expect = chai.expect
assert = chai.assert

describe 'getAppName', ->

  it 'doesnt blow up witout env vars', ->
    env = {}
    args = []
    results = getAppName(env, args)
    assert.equal(getAppName(env, args), '')

  it 'returns HUBOT_GLINK_DEFAULT_APP when no --app arg found', ->
    env = {
      HUBOT_GLINK_DEFAULT_APP: 'THEDEFAULTAPP'
    }
    args = []
    results = getAppName(env, args)
    assert.equal(getAppName(env, args), 'THEDEFAULTAPP')

  it 'returns --app arg when it exists', ->
    env = {
      HUBOT_GLINK_DEFAULT_APP: 'THEDEFAULTAPP'
    }
    args = ['users', 'index', '--app=MYAPP']
    results = getAppName(env, args)
    assert.equal(getAppName(env, args), 'MYAPP')

  it 'returns app names as uppercase', ->
    env = {
      HUBOT_GLINK_DEFAULT_APP: 'thedefaultapp'
    }
    args = []
    results = getAppName(env, args)
    assert.equal(getAppName(env, args), 'THEDEFAULTAPP')
    args = ['users', 'index', '--app=myApp']
    results = getAppName(env, args)
    assert.equal(getAppName(env, args), 'MYAPP')
