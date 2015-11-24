angular.module('sp90x').service 'appData', class DataService
    constructor: (@$firebaseAuth, @$firebaseObject, @$firebaseArray, @$location, @$rootScope)->
        @URL = 'https://sp90x.firebaseio.com'
        @auth = @$firebaseAuth(new Firebase(@URL))
        
        @auth.$onAuth (authData)=>
            console.log 'onAuth', authData?.uid
            if authData
                @user = @$firebaseObject(new Firebase("#{@URL}/users/#{authData.uid}"))
                @user.$bindTo(@$rootScope, 'user').then =>
                    console.log @$rootScope.user
            else if @user
                @user.$destroy()
                @$rootScope.user = null

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

    listTasks: ->
        @$firebaseArray(new Firebase("#{@URL}/tasks"))

    listSubTasks: (taskId)->
        @$firebaseArray(new Firebase("#{@URL}/subTasks/#{taskId}"))

    listPrograms: ->
        @$firebaseArray(new Firebase("#{@URL}/programs"))
