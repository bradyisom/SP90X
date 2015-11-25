angular.module('sp90x').service 'appData', class DataService
    constructor: (@$firebaseAuth, @$firebaseObject, @$firebaseArray, @$location, @$rootScope)->
        @URL = 'https://sp90x.firebaseio.com'
        @auth = @$firebaseAuth(new Firebase(@URL))


        updateAuthData = (authData)=>
            # console.log 'onAuth', authData
            if authData
                @$rootScope.user = @user = authData
                user = @$firebaseObject(new Firebase("#{@URL}/users/#{authData.uid}"))
                user.$bindTo(@$rootScope, 'user').then =>
                    @user = user
                    # console.log @$rootScope.user
            else if @user
                @user.$destroy()
                @$rootScope.user = null

        updateAuthData @auth.$getAuth()
        
        @auth.$onAuth (authData)=>
            updateAuthData authData

    login: (email, password)->
        @auth.$authWithPassword(
            email: email
            password: password
        )

    logout: ->
        @auth.$unauth()
        @$location.path '/login'

    createUser: (email, password, info)->
        @auth.$createUser(
            email: email
            password: password
        ).then (userData)=>
            user = @$firebaseObject(new Firebase("#{@URL}/users/#{userData.uid}"))
            user.uid = userData.uid
            user.email = email
            angular.extend(user, info)
            user.$save()

    getRandomId: ->
        Math.round(Math.random() * 10000000000)
        
    listTasks: ->
        @$firebaseArray(new Firebase("#{@URL}/tasks"))

    listSubTasks: (taskId)->
        @$firebaseArray(new Firebase("#{@URL}/subTasks/#{taskId}"))

    listPrograms: ->
        @$firebaseArray(new Firebase("#{@URL}/programs"))

    listSchedules: ->
        @$firebaseArray(new Firebase("#{@URL}/schedules/#{@user.uid}"))

    loadSchedule: (scheduleId)->
        @$firebaseObject(new Firebase("#{@URL}/schedules/#{@user.uid}/#{scheduleId}"))

    loadScheduleTasks: (scheduleId)->
        @$firebaseObject(new Firebase("#{@URL}/schedules/#{@user.uid}/#{scheduleId}/tasks"))

