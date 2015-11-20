angular.module('sp90x').directive 'taskInterval', ->
    restrict: 'E'
    require: 'ngModel'
    scope: true 
    templateUrl: 'components/taskInterval.html'
    link: (scope, el, attr, ngModel)->
        scope.ui = 
            intervalType: 'daily'
            days: {}

        ngModel.$render = ->
            val = ngModel.$viewValue or 'daily'
            switch val
                when 'daily', 'weekly', 'monthly'
                    scope.ui.intervalType = val
                else
                    scope.ui.intervalType = 'custom'
                    scope.ui.days = _.map(val.split(','), (memo, day)->
                        memo[day] = true
                        memo
                    , {})

        updateModel = ->
            val = scope.ui.intervalType
            if val == 'custom'
                val = _.filter(_.keys(scope.ui.days), (key)-> key).join ','
            ngModel.$setViewValue val

        scope.$watch 'ui', (intervalType)->
            updateModel intervalType
        , true

        updateModel()

