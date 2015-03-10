chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
createTemplateDefaults = require '../lib/createTemplateDefaults'

expect = chai.expect
assert = chai.assert

describe 'createTemplateDefaults', ->

  it 'returns an empty array when no HUBOT_GLINK_TEMPLATE_DEFAULTS', ->
    assert.deepEqual(createTemplateDefaults({}), [])

  it 'returns correct template defaults when availabe in env', ->
    env  = {HUBOT_GLINK_TEMPLATE_DEFAULTS: '!!#controller===users#!!, #!!action===index#!!'}
    assert.deepEqual(createTemplateDefaults(env), ['!!#controller===users#!!', '#!!action===index#!!'])
