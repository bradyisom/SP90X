angular.module('sp90x').controller 'AdminCtrl', class AdminCtrl
    constructor: (@appData, @$mdDialog)->

        @tasks = @appData.listTasks()

    addTask: ->
        @$mdDialog.show(
            templateUrl: 'admin/addTask.html'
            controller: 'DialogCtrl'
            controllerAs: 'ctrl'
        ).then (task)=>
            return if not task
            @tasks.$add task
