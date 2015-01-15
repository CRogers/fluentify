expect = require('chai').expect
sinon = require('sinon')

fluentify = require('./fluentify')

describe 'fluentify', ->
  describe 'no named args', ->
    it 'should allow calling as a normal function', ->
      callback = sinon.spy()
      fluent = fluentify callback
      fluent()
      expect(callback.calledOnce).to.be.true

    it 'should pass on the top level args and add an empty hash', ->
      callback = sinon.spy()
      fluent = fluentify callback
      fluent(1, 2)
      expect(callback.firstCall.args).to.deep.equal [1, 2, {}]

  describe 'one named arg', ->
    it 'should not call the function when initialized', ->
      callback = sinon.spy()
      fluent = fluentify 'x', callback
      fluent(1)
      expect(callback.notCalled).to.be.true

    it 'should call the function when initialized and the named arg is used', ->
      callback = sinon.spy()
      fluent = fluentify 'foo', callback
      fluent(1).foo(2)
      expect(callback.calledOnce).to.be.true

    it 'should call the function with correct parameters', ->
      callback = sinon.spy()
      fluent = fluentify 'foo', callback
      fluent(1).foo(2)
      expect(callback.firstCall.args).to.deep.equal [1, {foo: [2]}]

    it 'should call the function with correct parameters when multiple arguments are used for the named arg', ->
      callback = sinon.spy()
      fluent = fluentify 'foo', callback
      fluent(1).foo(2, 3)
      expect(callback.firstCall.args).to.deep.equal [1, {foo: [2, 3]}]

    it 'should call the function with correct parameters when there are multiple top level arguments', ->
      callback = sinon.spy()
      fluent = fluentify 'foo', callback
      fluent(1, 2).foo(3)
      expect(callback.firstCall.args).to.deep.equal [1, 2, {foo: [3]}]