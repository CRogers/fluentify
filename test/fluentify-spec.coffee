expect = require('chai').expect

fluentify = require('./fluentify')

describe 'foo', ->
  it 'should work', ->
    expect(fluentify).to.equal 10
