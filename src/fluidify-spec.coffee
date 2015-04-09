expect = require('chai').expect
sinon = require('sinon')

fluidify = require('./fluidify')

describe 'fluidify', ->
  describe 'no named args', ->
    it 'should allow calling as a normal function', ->
      callback = sinon.spy()
      fluent = fluidify callback
      fluent()
      expect(callback.calledOnce).to.be.true

    it 'should pass on the top level args and add an empty hash', ->
      callback = sinon.spy()
      fluent = fluidify callback
      fluent(1, 2)
      expect(callback.firstCall.args).to.deep.equal [1, 2, {}]

  describe 'one named arg', ->
    callback = null
    fluent = null

    beforeEach ->
      callback = sinon.spy()
      fluent = fluidify 'foo', callback

    it 'should not call the function when initialized', ->
      fluent(1)
      expect(callback.notCalled).to.be.true

    it 'should call the function when initialized and the named arg is used', ->
      fluent(1).foo(2)
      expect(callback.calledOnce).to.be.true

    it 'should call the function with correct parameters', ->
      fluent(1).foo(2)
      expect(callback.firstCall.args).to.deep.equal [1, {foo: [2]}]

    it 'should call the function with correct parameters when multiple arguments are used for the named arg', ->
      fluent(1).foo(2, 3)
      expect(callback.firstCall.args).to.deep.equal [1, {foo: [2, 3]}]

    it 'should call the function with correct parameters when there are multiple top level arguments', ->
      fluent(1, 2).foo(3)
      expect(callback.firstCall.args).to.deep.equal [1, 2, {foo: [3]}]

  describe 'two named args', ->
    callback = null
    fluent = null

    beforeEach ->
      callback = sinon.spy()
      fluent = fluidify 'foo', 'bar', callback

    it 'should not call the function when initialized', ->
      fluent(1)
      expect(callback.notCalled).to.be.true

    it 'should not call the function when initialized and one named arg is called', ->
      fluent(1).foo(2)
      expect(callback.notCalled).to.be.true

    it 'should not call the function when initialized and the other named arg is called', ->
      fluent(1).bar(2)
      expect(callback.notCalled).to.be.true

    it 'should call the function when both named args are called', ->
      fluent(1).bar(2).foo(3)
      expect(callback.calledOnce).to.be.true

    it 'should call the function when both named args are called in the other order', ->
      fluent(1).foo(3).bar(2)
      expect(callback.calledOnce).to.be.true

    it 'should call the function with correct parameters', ->
      fluent(1).foo(2).bar(3)
      expect(callback.firstCall.args).to.deep.equal [1, {foo: [2], bar: [3]}]

    it 'should call the function with correct parameters when called in the other order', ->
      fluent(1).bar(3).foo(2)
      expect(callback.firstCall.args).to.deep.equal [1, {foo: [2], bar: [3]}]

    it 'should call the function with correct parameters when multiple arguments are used', ->
      fluent(1, 2).foo(3, 4).bar(5, 6)
      expect(callback.firstCall.args).to.deep.equal [1, 2, {foo: [3, 4], bar: [5, 6]} ]

    it 'should not allow calling the same named arg twice', ->
      intermediary = fluent(1).foo(2)
      expect(intermediary).to.not.have.property 'foo'

    it 'should allow to continue two chains from a common point without them conflicting', ->
      start = fluent()
      intermediary = start.foo(3)
      start.foo(4).bar(8)
      intermediary.bar(9)
      expect(callback.secondCall.args).to.deep.equal [{foo: [3], bar: [9]}]