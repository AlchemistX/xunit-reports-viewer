Handlebars = require '../node_modules/hbs/node_modules/handlebars/lib/index'
entities = require 'entities'

class MochaXUnitTestCase
  constructor: (testCase) ->
    @className = testCase.$.classname || '(root)'
    @name = testCase.$.name
    @time = parseFloat testCase.$.time
    @skipped = !!testCase.skipped

    @failure = null
    if testCase.failure
      failure = testCase.failure

      if typeof failure != 'string'
        failure = testCase.failure[0]['_']

      @failure = entities.decodeHTML failure
      @failure = @failure.trim()
      @failure = new Handlebars.SafeString @failure

    @system_out = null
    if testCase['system-out']
      system_out = testCase['system-out']
      @system_out = entities.decodeHTML system_out[0]
      @system_out = @system_out.trim()
      @system_out = new Handlebars.SafeString @system_out

    if @skipped then @type = 'info'
    else if @failure != null then @type = 'danger'
    else @type = 'success'

module.exports = MochaXUnitTestCase
