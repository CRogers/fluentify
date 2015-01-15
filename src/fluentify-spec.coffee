expect = require('chai').expect
sinon = require('sinon')

fluentify = require('./fluentify')

describe 'fluentify', ->
  it 'should allow calling as a normal function', ->
    callback = sinon.spy()
    fluent = fluentify callback
    fluent()
    expect(callback.calledOnce).to.be.true