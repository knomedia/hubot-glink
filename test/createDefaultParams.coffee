chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
createDefaultParams = require '../lib/createDefaultParams'

expect = chai.expect
assert = chai.assert

describe 'createDefaultParams', ->

  it 'returns an empty array when no HUBOT_GLINK_DEFAULT_PARAMS', ->
    assert.deepEqual(createDefaultParams({}), {})

  it 'splits out params from comma delimted string', ->
    env = {HUBOT_GLINK_DEFAULT_PARAMS: 'from:-1week, width: 800'}
    expected = {from: '-1week', width: '800'}
    result = createDefaultParams(env)
    assert.deepEqual(expected, result)

  it 'handles graphite value lists', ->
    env = {HUBOT_GLINK_DEFAULT_PARAMS: 'from:-1week, type:{mean,median,upper_95}'}
    expected = {from: '-1week', type: '{mean,median,upper_95}'}
    result = createDefaultParams(env)
    assert.deepEqual(expected, result)
