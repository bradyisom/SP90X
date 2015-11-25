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
        return if not program or not start.isValid()
        newSchedule = 
            programTitle: program.title
            startDate: start.toISOString()
            endDate: end.toISOString()
            # tasks: program.tasks

        angular.extend(@scheduleObj, newSchedule)
        @scheduleObj.$save()

        scheduleTasks = @appData.loadScheduleTasks(@scheduleObj.$id)
        scheduleTasks.$loaded =>
            for taskId,val of program.tasks
                scheduleTasks[taskId] = val
            scheduleTasks.$save()

            @$location.path '/schedule'

    backButtonClick: ->
        @$location.path '/schedule'
