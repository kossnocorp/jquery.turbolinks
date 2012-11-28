jsdom = require('jsdom').jsdom

global.document = jsdom()
global.window   = document.createWindow()

require('../src/jquery.turbolinks.coffee')

chai      = require('chai')
sinon     = require('sinon')
sinonChai = require('sinon-chai')
$         = require('jquery')

chai.should()
chai.use(sinonChai)

describe '$ Turbolinks', ->

  callback1 = callback2 = null

  describe "DOM isn't ready", ->

    beforeEach ->
      $.setReadyEvent('page:load')
      $.isReady = false

      $(callback1 = sinon.spy())
      $(callback2 = sinon.spy())

    it '''
         should trigger callbacks passed to
         `$()` and `$.ready()` when page:load
         event fired
       ''', ->
         $(document).trigger('page:load')

         callback1.should.have.been.calledOnce
         callback2.should.have.been.calledOnce

    it 'should pass jQuery object to callbacks', ->
      $(document).trigger('page:load')

      callback1.should.have.been.calledWith($)

    describe '$.setReadyEvent', ->

      beforeEach ->
        $.setReadyEvent('page:load')

      it 'should unbind default (page:load) event', ->
        $.setReadyEvent('random_event_name')

        $(document).trigger('page:load')

        callback1.should.have.not.been.called
        callback2.should.have.not.been.called

      it 'should bind ready to passed function', ->
        $.setReadyEvent('page:change')

        $(document)
          .trigger('page:load')
          .trigger('page:change')

        callback1.should.have.been.calledOnce
        callback2.should.have.been.calledOnce

  describe "DOM is ready", ->

    beforeEach ->
      $.setReadyEvent('page:load')
      $.isReady = true

      $(callback1 = sinon.spy())
      $(callback2 = sinon.spy())

    it 'should call trigger right after add to waiting list', ->
      callback1.should.have.been.calledOnce
      callback2.should.have.been.calledOnce
