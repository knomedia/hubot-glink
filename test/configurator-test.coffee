chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
configurator = require '../lib/configurator'

expect = chai.expect
assert = chai.assert

describe 'configurator', ->

  it 'doesnt blow up witout env vars', ->
    expected = {
      hostname: 'graphite.example.com',
      template: 'template.not.set',
      templateDefaults: [],
      paramsDefaults: {},
      absoluteTimes: false
    }
    assert.deepEqual(configurator({}).config, expected)

  it 'gives out appropriate config given appropriate env', ->
    env = {
      HUBOT_GLINK_TEMPLATE: 'some.template.value.##!one!##.##!two!##',
      HUBOT_GLINK_TEMPLATE_DEFAULTS: '##!one!##===users, ##!two!##===index',
      HUBOT_GLINK_HOSTNAME: 'graphite.example.com',
      HUBOT_GLINK_DEFAULT_PARAMS: 'from:-3months, width:450, height:250',
    }
    expected = {
      hostname: 'graphite.example.com',
      template: 'some.template.value.##!one!##.##!two!##',
      templateDefaults: [
        '##!one!##===users'
        '##!two!##===index'
      ],
      paramsDefaults: {
        from: '-3months',
        width: '450',
        height: '250'
      },
      absoluteTimes: false
    }
    assert.deepEqual(configurator(env).config, expected)

  it 'includes optional params when they exist', ->
    env = {
      HUBOT_GLINK_TEMPLATE: 'some.template.value.##!one!##.##!two!##',
      HUBOT_GLINK_TEMPLATE_DEFAULTS: '##!one!##===users, ##!two!##===index',
      HUBOT_GLINK_HOSTNAME: 'graphite.example.com',
      HUBOT_GLINK_DEFAULT_PARAMS: 'from:-3months, width:450, height:250',
      HUBOT_GLINK_PROTOCOL: 'http',
      HUBOT_GLINK_PORT: '8001',
      HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER: '***'
    }
    expected = {
      hostname: 'graphite.example.com',
      port: '8001',
      protocol: 'http',
      template: 'some.template.value.##!one!##.##!two!##',
      templateDefaults: [
        '##!one!##===users',
        '##!two!##===index'
      ],
      templateDefaultDelimiter: '***',
      paramsDefaults: {
        from: '-3months',
        width: '450',
        height: '250'
      },
      absoluteTimes: false
    }
    assert.deepEqual(configurator(env).config, expected)

  it 'creates authdConfig when HUBOT_GLINK_CREDS is present', ->
    env = {
      HUBOT_GLINK_TEMPLATE: 'some.template.value.##!one!##.##!two!##',
      HUBOT_GLINK_TEMPLATE_DEFAULTS: '##!one!##===users, ##!two!##===index',
      HUBOT_GLINK_HOSTNAME: 'graphite.example.com',
      HUBOT_GLINK_DEFAULT_PARAMS: 'from:-3months, width:450, height:250',
      HUBOT_GLINK_CREDS: 'user:password'
    }
    expected = {
      hostname: 'user:password@graphite.example.com',
      template: 'some.template.value.##!one!##.##!two!##',
      templateDefaults: [
        '##!one!##===users'
        '##!two!##===index'
      ],
      paramsDefaults: {
        from: '-3months',
        width: '450',
        height: '250'
      },
      absoluteTimes: false
    }
    assert.deepEqual(configurator(env).authdConfig, expected)

  it 'creates credless authdConfig when no HUBOT_GLINK_CREDS present', ->
    env = {
      HUBOT_GLINK_TEMPLATE: 'some.template.value.##!one!##.##!two!##',
      HUBOT_GLINK_TEMPLATE_DEFAULTS: '##!one!##===users, ##!two!##===index',
      HUBOT_GLINK_HOSTNAME: 'graphite.example.com',
      HUBOT_GLINK_DEFAULT_PARAMS: 'from:-3months, width:450, height:250',
    }
    expected = {
      hostname: 'graphite.example.com',
      template: 'some.template.value.##!one!##.##!two!##',
      templateDefaults: [
        '##!one!##===users'
        '##!two!##===index'
      ],
      paramsDefaults: {
        from: '-3months',
        width: '450',
        height: '250'
      },
      absoluteTimes: false
    }
    assert.deepEqual(configurator(env).authdConfig, expected)
