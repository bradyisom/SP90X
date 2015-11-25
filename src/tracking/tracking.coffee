angular.module('sp90x').controller 'TrackingCtrl', class TrackingCtrl
    constructor: (@$scope, @appData, @$location, @$routeParams)->
        @schedules = @appData.listSchedules()
        @taskList = @appData.listTasks()

        @currentDate = new Date()
        @schedules.$loaded =>
            @taskList.$loaded =>
                @loadCurrentSchedule()

    loadCurrentSchedule: =>
        ordered = _.sortBy @schedules, 'startDate'
        @schedule = _.find ordered, (schedule)=>
            start = moment(schedule.startDate)
            end = moment(schedule.endDate).endOf('day')
            (start.isBefore(@currentDate) or start.isSame(@currentDate)) and
                (end.isAfter(@currentDate or end.isSame(@currentDate)))
        @tasks = 
            daily: []
            weekly: []
            monthly: []
        if @schedule
            @startDate = moment(@schedule.startDate).toDate()
            @endDate = moment(@schedule.endDate).toDate()
            @day = Math.ceil(moment.duration(new Date() - @startDate).asDays())

            @dayOfWeek = moment().format('dd')
            for taskId,val of @schedule.tasks
                task = @taskList.$getRecord taskId
                continue if not task
                switch val
                    when 'daily'
                        @tasks.daily.push task
                    when 'weekly'
                        @tasks.weekly.push task
                    when 'monthly'
                        @tasks.monthly.push task
                    else
                        if @dayOfWeek in val.split(',')
                            @tasks.daily.push task

                


