_.mixin(s.exports());

angular.module('sp90x', ['ngMaterial', 'firebase', 'ngRoute', 'ngMessages', 'ui.gravatar'])
.config ($mdThemingProvider, $mdIconProvider, $routeProvider, gravatarServiceProvider)->
    $mdThemingProvider.theme('default')
        .primaryPalette('grey',
            'default': '900'
        )
        .accentPalette('deep-orange')
        .dark()

    # $mdThemingProvider.theme('dialog')
    #     .primaryPalette('grey')
    #     .accentPalette('deep-orange')

    $mdIconProvider
        .icon 'menu', './icons/menu-black.svg'
        .icon 'add', './icons/add.svg'
        .icon 'delete', './icons/delete.svg'
        .icon 'edit', './icons/edit.svg'
        .icon 'save', './icons/save.svg'
        .icon 'back', './icons/back.svg'

    gravatarServiceProvider.defaults =
        size: 48
        default: 'retro'

    $routeProvider
        .when '/',
            templateUrl: 'main.html'
        .when '/login',
            templateUrl: 'authentication/login.html'
            controller: 'LoginCtrl'
            controllerAs: 'ctrl'
        .when '/register',
            templateUrl: 'authentication/register.html'
            controller: 'LoginCtrl'
            controllerAs: 'ctrl'
        .when '/admin',
            templateUrl: 'admin/admin.html'
            controller: 'AdminCtrl'
            controllerAs: 'ctrl'
        .when '/schedule',
            templateUrl: 'schedule/list.html'
            controller: 'ScheduleListCtrl'
            controllerAs: 'ctrl'
        .when '/schedule/:scheduleId',
            templateUrl: 'schedule/edit.html'
            controller: 'ScheduleCtrl'
            controllerAs: 'ctrl'
        .when '/tracking',
            templateUrl: 'tracking/tracking.html'
            controller: 'TrackingCtrl'
            controllerAs: 'ctrl'
        .otherwise '/'


.run (appData)->
