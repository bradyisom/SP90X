angular.module('sp90x').controller 'ScheduleListCtrl', class ScheduleListCtrl
    constructor: (@$scope, @appData, @$location, @$mdDialog)->
        @schedules = @appData.listSchedules()

    addButtonClick: ->
        @$location.path '/schedule/new'

    editButtonClick: (schedule)->
        @$location.path "/schedule/#{schedule.$id}"

    deleteButtonClick: (schedule, ev)->
        @$mdDialog.show( @$mdDialog.confirm()
            .title 'Are you sure?'
            .content "Do you want to delete the '#{schedule.programTitle}' schedule?"
            .targetEvent ev
            .ok 'Delete It'
            .cancel 'Keep It'
        ).then =>
            @schedules.$remove schedule
