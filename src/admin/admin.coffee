angular.module('sp90x').controller 'AdminCtrl', class AdminCtrl
    constructor: (@appData, @$mdDialog)->

        @tasks = @appData.listTasks()

    addButtonClick: (ev)->
        switch @selectedTab
            when 'tasks' 
                @addTask ev

    deleteButtonClick: (record, ev)->
        switch @selectedTab
            when 'tasks' 
                @deleteTask record, ev

    addTask: (ev)->
        @$mdDialog.show(
            templateUrl: 'admin/addTask.html'
            controller: 'DialogCtrl'
            controllerAs: 'ctrl'
            targetEvent: ev
        ).then (task)=>
            return if not task
            @tasks.$add task

    deleteTask: (task, ev)->
        @$mdDialog.show( @$mdDialog.confirm()
            .title 'Are you sure?'
            .content "Do you want to delete the '#{task.title}' task?"
            .targetEvent ev
            .ok 'Delete It'
            .cancel 'Keep It'
        ).then =>
            @tasks.$remove task
