'use strict'

angular
  .module 'fk.eternicode-datepicker', []
  .directive 'datepicker', ['$timeout', ($timeout) ->
    restrict: 'A'
    require: 'ngModel'
    scope:
      ngModel: '='
      dpOptions: '='
    link: (scope, elem, attrs, ngModel) ->
      if elem.is('input')
        throw 'You can not add the datepicker directive to an input field'

      dpOptions = scope.dpOptions || {}

      hasClass = elem.hasClass 'date'
      hasInput = elem.has('input').length > 0
      if hasInput and not hasClass
        # Text Input
        dpElem = elem.children('input').first()
      else
        # Component and Embedded / Inline
        dpElem = elem

      dpElem.datepicker scope.dpOptions
        .on 'changeDate', ->
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
        if newValue? and not isFocused()
          newDate = new Date newValue
          oldDate = dpElem.datepicker 'getUTCDate'
          if not oldDate? or newDate.getTime() isnt oldDate.getTime()
            dpElem.datepicker 'setUTCDate', newDate
  ]
