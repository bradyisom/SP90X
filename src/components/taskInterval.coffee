angular.module('sp90x').directive 'taskInterval', ->
    restrict: 'E'
    require: 'ngModel'
    scope: true 
    templateUrl: 'components/taskInterval.html'
    link: (scope, el, attr, ngModel)->
        scope.ui = {}
            # intervalType: 'daily'
            # days: {}

        ngModel.$render = ->
            val = ngModel.$viewValue or 'daily'
            switch val
                when 'daily', 'weekly', 'monthly'
                    scope.ui.intervalType = val
                else
                    scope.ui.intervalType = 'custom'
                    scope.ui.days = _.reduce(val.split(','), (memo, day)->
                        memo[day] = true
                        memo
                    , {})

        updateModel = ->
            val = scope.ui.intervalType
            if val == 'custom'
                val = _.transform(scope.ui.days, (memo, v, key)->
                    if v
                        memo.push key
                    memo
                []).join ','
            ngModel.$setViewValue val

        scope.$watch ->
            ngModel.$viewValue
        , (viewValue)->
            if not viewValue
                scope.ui.intervalType = 'daily'
                scope.ui.days = {}

        scope.$watch 'ui', (intervalType)->
            updateModel intervalType
        , true

        updateModel()

