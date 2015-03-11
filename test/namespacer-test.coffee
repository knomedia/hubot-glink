chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
Namespacer = require '../lib/namespacer'

expect = chai.expect
assert = chai.assert

describe 'namespacer', ->
  beforeEach ->
    @ns = new Namespacer('glink_key_')

  it 'takes a prefix in constructor', ->
    assert.equal(@ns.prefix, 'glink_key_')

  describe 'prepend', ->
    it 'prends the prefix', ->
      assert.equal(@ns.prepend('value'), 'glink_key_value')

  describe 'clear', ->

    it 'clears the prefix', ->
      assert.equal(@ns.clear('glink_key_value'), 'value')

    it 'returns value if prefix isnt found prepended', ->
      assert.equal(@ns.clear('some_value'), 'some_value')

  describe 'inNS', ->
    it 'ensures prefix is found at beginning of value', ->
      expect(@ns.inNS('glink_key_foobar')).to.be.true
      expect(@ns.inNS('foobarglink_key_')).to.be.false
