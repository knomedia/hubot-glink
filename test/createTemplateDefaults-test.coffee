chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
createTemplateDefaults = require '../lib/createTemplateDefaults'

expect = chai.expect
assert = chai.assert

describe 'createTemplateDefaults', ->

  it 'returns an empty array when no HUBOT_GLINK_<appname>_TEMPLATE_DEFAULTS', ->
    assert.deepEqual(createTemplateDefaults({}, 'UNKNOWN'), [])

  it 'returns correct template defaults when availabe in env', ->
    env  = {HUBOT_GLINK_MYAPP_TEMPLATE_DEFAULTS: '!!#controller===users#!!, #!!action===index#!!'}
    assert.deepEqual(createTemplateDefaults(env, 'MYAPP'), ['!!#controller===users#!!', '#!!action===index#!!'])
