require('../src/jquery.turbolinks.coffee')

chai      = require('chai')
sinon     = require('sinon')
sinonChai = require('sinon-chai')
jQuery    = require('jquery')

chai.should()
chai.use(sinonChai)

describe 'jQuery Turbolinks', ->

  it '''
       should trigger callbacks passed to
       `jQuery()` and `jQuery.ready()` when page:change
       event fired
     ''', ->
       jQuery(callback1 = sinon.spy())
       jQuery(callback2 = sinon.spy())

       jQuery(document).trigger('page:change')

       callback1.should.have.been.calledTwice
       callback2.should.have.been.calledTwice
