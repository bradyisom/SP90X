angular.module('sp90x').controller 'AdminCtrl', class AdminCtrl
    constructor: (@$scope, @appData, @$mdDialog)->

        @tasks = @appData.listTasks()

    addButtonClick: (ev)->
        switch @selectedTab
            when 'tasks' 
                @addTask ev

    deleteButtonClick: (record, ev)->
        switch @selectedTab
            when 'tasks' 
                @deleteTask record, ev

    editButtonClick: (record, ev)->
        switch @selectedTab
            when 'tasks' 
                @editTask record, ev

    addTask: (ev)->
        @task = {}
        @$mdDialog.show(
            templateUrl: 'admin/addTask.html'
            controller: 'DialogCtrl'
            controllerAs: 'dlg'
            scope: @$scope
            preserveScope: true
            targetEvent: ev
        ).then (task)=>
            return if not task
            @tasks.$add task

    editTask: (task, ev)->
        @isEditing = true
        @task = angular.copy(task)
        @$mdDialog.show(
            templateUrl: 'admin/addTask.html'
            controller: 'DialogCtrl'
            controllerAs: 'dlg'
            scope: @$scope
            preserveScope: true
            targetEvent: ev
        ).then (newTask)=>
            return if not newTask
            angular.extend(task, newTask)
            @tasks.$save task
        .finally =>
            @isEditing = false


    deleteTask: (task, ev)->
        @$mdDialog.show( @$mdDialog.confirm()
            .title 'Are you sure?'
            .content "Do you want to delete the '#{task.title}' task?"
            .targetEvent ev
            .ok 'Delete It'
            .cancel 'Keep It'
        ).then =>
            @tasks.$remove task
