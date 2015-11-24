angular.module('sp90x').controller 'ScheduleCtrl', class ScheduleCtrl
    constructor: (@$scope, @appData, @$location, @$routeParams)->
        @programs = @appData.listPrograms()
        @taskList = @appData.listTasks()

        scheduleId = @$routeParams.scheduleId
        if scheduleId == 'new'
            scheduleId = @appData.getRandomId()

        @scheduleObj = @appData.loadSchedule scheduleId
        @schedule = {}
        @scheduleObj.$loaded =>
            @schedule.program = _.find(@programs, title: @scheduleObj.programTitle)?.$id or ''
            @schedule.startDate = moment(@scheduleObj.startDate).toDate()

        @$scope.$watch =>
            @schedule?.program
        , (programId)=>
            @tasks = []
            if programId
                program = _.find(@programs, $id: @schedule.program)
                for taskId,v of program.tasks or {}
                    @tasks.push _.find(@taskList, $id:taskId)

    getTaskInterval: (task)->
        program = _.find(@programs, $id: @schedule.program)
        program.tasks[task.$id]

    saveButtonClick: ->
        start = moment(@schedule.startDate)
        end = moment(start).add(90, 'days')
        program = _.find(@programs, $id: @schedule.program)
        newSchedule = 
            programTitle: program.title
            startDate: start.toISOString()
            endDate: end.toISOString()
            # tasks: @schedule.program.tasks

        angular.extend(@scheduleObj, newSchedule)
        @scheduleObj.$save()
        @$location.path '/schedule'
