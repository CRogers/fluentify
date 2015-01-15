expect = require('chai').expect
sinon = require('sinon')

fluentify = require('./fluentify')

describe 'fluentify', ->
  it 'should allow calling as a normal function', ->
    callback = sinon.spy()
    fluent = fluentify callback
    fluent()
    expect(callback.calledOnce).to.be.true

  it 'should return the same function if no named args are given', ->
    callback = sinon.spy()
    fluent = fluentify callback
    fluent(1, 2)
    expect(callback.firstCall.args).to.deep.equal [1, 2]

  it 'should not call the function when initialized where there is one named arg', ->
    callback = sinon.spy()
    fluent = fluentify 'x', callback
    fluent(1)
    expect(callback.notCalled).to.be.true

  it 'should call the function when initialized and the named arg is used when there is one named arg', ->
    callback = sinon.spy()
    fluent = fluentify 'foo', callback
    fluent(1).foo(2)
    expect(callback.calledOnce).to.be.true