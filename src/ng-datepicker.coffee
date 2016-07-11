'use strict'

angular
  .module 'fk.eternicode-datepicker', []
  .provider 'datepickerDefaults', ->
    defaultOptions = {}

    setDefaultOptions: (options) ->
      defaultOptions = options
    $get: ->
      defaultOptions

  .directive 'datepicker', [
    '$timeout', 'datepickerDefaults',($timeout, datepickerDefaults) ->
      restrict: 'A'
      require: 'ngModel'
      scope:
        ngModel: '='
        dpOptions: '='
      link: (scope, elem, attrs, ngModel) ->
        if elem.is('input')
          throw 'You can not add the datepicker directive to an input field'

        # Detect element to apply datepicker
        hasClass = elem.hasClass 'date'
        hasInput = elem.has('input').length > 0
        if hasInput and not hasClass
          # Text Input
          dpElem = elem.children('input').first()
        else
          # Component and Embedded / Inline
          dpElem = elem

        # Initialize datepicker
        dpOptions = $.extend true, {}, datepickerDefaults, scope.dpOptions
        dpElem.datepicker dpOptions
          .on 'changeDate', ->
            # Write selected date as UTC to ngModel
            date = dpElem.datepicker 'getUTCDate'
            date.setUTCHours 0, 0, 0, 0, 0

            $timeout ->
              scope.$apply ->
                scope.ngModel = date

          .on 'clearDate', ->
            $timeout ->
              scope.$apply ->
                scope.ngModel = null

        isFocused = ->
          dpElem.is(':focus') or dpElem.children('input').first().is(':focus')

        scope.$watch 'ngModel', (newValue) ->
          # ngModel changed. Pass change to datepicker but only if the user
          # isn't entering something right now
          if newValue? and not isFocused()
            newDate = new Date newValue
            oldDate = dpElem.datepicker 'getUTCDate'
            if not oldDate? or newDate.getTime() isnt oldDate.getTime()
              dpElem.datepicker 'setUTCDate', newDate
  ]
