chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
contextHelp = require('../lib/contextHelp')

getDescriptions = contextHelp.getDescriptions
buildHelp = contextHelp.buildHelp

expect = chai.expect
assert = chai.assert

config = ->
  template: 'stats.project.request.!!#controller#!!.!!#action#!!.!!#type#!!',
  templateDefaults: [
    '!!#controller#!!===users',
    '!!#action#!!===index',
    '!!#type#!!==={mean,median,upper_95}'
  ],
  paramsDefaults: {
    from: '-1week'
  }


describe 'getDescriptions', ->

  it 'correctly calculates the templateKey', ->
    description = getDescriptions(config())
    expected = [
      'controller',
      'action',
      'type'
    ]
    assert.equal(description.templateKey, '!!#')

  it 'pulls template variable names correctly', ->
    expected = [
      'controller',
      'action',
      'type'
    ]
    description = getDescriptions(config())
    assert.deepEqual(description.templateVariables, expected)

  it 'pulls template variable names correctly with different length substitution expressions', ->
    c = config()
    c.templateDefaults = [
      '##controller##===users',
      '##action##===index',
      '##type##==={mean,median,upper_95}'
    ]
    description = getDescriptions(c)
    expected = [
      'controller',
      'action',
      'type'
    ]
    assert.deepEqual(description.templateVariables, expected)

  it 'pulls template variable defaults correctly', ->
    expected = [
      'users',
      'index',
      '{mean,median,upper_95}'
    ]
    description = getDescriptions(config())
    assert.deepEqual(description.templateDefaults, expected)

describe 'buildHelp', ->

  it 'returns example template args correctly', ->
    result = buildHelp(config())
    assert.equal(!!result.match(/graphme \[controller\] \[action\] \[type\]/), true)

  it 'returns default args correctly', ->
    result = buildHelp(config())
    assert.equal(!!result.match(/graphme users index {mean,median,upper_95}/), true)

