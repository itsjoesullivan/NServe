should = require 'should'
sinon = require 'sinon'

dataTransfer = require '../lib/data-transfer'

describe 'data-transfer', ->
    describe '#getActualRate', ->
        it 'should return "5" if the transferer is created with 5 Bps', ->
            transferer = dataTransfer.create 5
            transferer.getActualRate().should.eql '5'
        it 'should return "100K" if the transferer is created with 100K Bps', ->
            transferer = dataTransfer.create '100K'
            transferer.getActualRate().should.eql '100K'
        it 'should return "5M" if the transferer is created with 5M Bps', ->
            transferer = dataTransfer.create '5M'
            transferer.getActualRate().should.eql '5M'
        it 'should return "unlimited" if the transferer is created without any rate specified', ->
            transferer = dataTransfer.create()
            transferer.getActualRate().should.eql 'unlimited'
        it 'should return "unlimited" if the transferer is created with invalid rate', ->
            transferer = dataTransfer.create 'invalid_rate'
            transferer.getActualRate().should.eql 'unlimited'

    describe '#getBufferLength', ->
        it 'should return 5 if the transferer is created with 5 Bps', ->
            transferer = dataTransfer.create 5
            transferer.getBufferLength().should.eql 5
        it 'should return 100x1024 if the transferer is created with 100K Bps', ->
            transferer = dataTransfer.create '100K'
            transferer.getBufferLength().should.eql 100*1024
        it 'should return 5x1024x1024 if the transferer is created with 5M Bps', ->
            transferer = dataTransfer.create '5M'
            transferer.getBufferLength().should.eql 5*1024*1024
        it 'should return 0 if the transferer is created without any rate specified', ->
            transferer = dataTransfer.create()
            transferer.getBufferLength().should.eql 0
        it 'should return 0 if the transferer is created with invalid rate', ->
            transferer = dataTransfer.create 'invalid_rate'
            transferer.getBufferLength().should.eql 0

    describe '#transfer', ->
        testData = "This is a test!!!"
        testDataSize = testData.length # 17 byts

        describe 'if the transferer has unlimited rate', ->
            it 'should emit "complete" event once with complete data', ->
                transferer = dataTransfer.create()

                transferer.on 'complete', (data) ->
                    data.should.eql testData

                transferer.transfer testData, testDataSize

        describe 'if the transferer has limited rate', ->
            it 'shuld emit n times "transfer" events and one "complete" event in the end with chunk data', () ->
                transferer = dataTransfer.create 5
                ticks = Math.ceil(testDataSize/5)
                callback = sinon.spy()
                clock = sinon.useFakeTimers()

                transferer.on 'transfer', (chunk) ->
                    callback chunk

                transferer.on 'complete', (chunk) ->
                    callback chunk

                transferer.transfer testData, testDataSize

                clock.tick ticks*1000+100
                clock.restore()

                # assertions
                callback.callCount.should.eql ticks

                call0 = callback.getCall 0
                call0.calledWithExactly('This ').should.be.true

                call1 = callback.getCall 1
                call1.calledWithExactly('is a ').should.be.true

                call2 = callback.getCall 2
                call2.calledWithExactly('test!').should.be.true

                call3 = callback.getCall 3
                call3.calledWithExactly('!!').should.be.true
