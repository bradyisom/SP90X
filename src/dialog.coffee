angular.module('sp90x').controller 'DialogCtrl', class DialogCtrl
    constructor: (@$scope, @$mdDialog)->

    hide: ->
        @$mdDialog.hide()

    cancel: ->
        @$mdDialog.cancel()

    answer: (answer)->
        @$mdDialog.hide answer

