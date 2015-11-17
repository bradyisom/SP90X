angular.module('sp90x').controller 'LoginCtrl', class LoginCtrl
    constructor: (@appData, @$mdDialog, @$location)->

    login: (form)->
        return if not form.$valid
        @appData.login(@email, @password).then (userData)=>
            @$location.path '/'
        .catch (error)=>
            @$mdDialog.show(
                @$mdDialog.alert()
                    .title 'Unable to login'
                    .content error?.message or 'Unknown error'
                    .theme 'dialog'
                    .ok 'Close'
            )

    register: (form)->
        return if not form.$valid
        @appData.createUser(@email, @password,
            firstName: @firstName
            lastName: @lastName
        ).then (userData)=>
            @$mdDialog.show(
                @$mdDialog.alert()
                    .content 'Successfully Registered'
                    .ok 'OK'
            ).finally =>
                @$location.path '/login'
        .catch (error)=>
            @$mdDialog.show(
                @$mdDialog.alert()
                    .title 'Unable to register'
                    .content error?.message or 'Unknown error'
                    .ok 'Close'
            )

.directive 'compareTo', ->
    require: 'ngModel'
    scope:
        otherModelValue: '=compareTo'
    link: (scope, element, attrs, ngModel)->
        ngModel.$validators.compareTo = (modelValue)->
            modelValue == scope.otherModelValue

        scope.$watch 'otherModelValue', ->
            ngModel.$validate()