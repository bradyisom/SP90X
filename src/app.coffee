angular.module('sp90x', ['ngMaterial', 'firebase', 'ngRoute', 'ngMessages'])
.config ($mdThemingProvider, $mdIconProvider, $routeProvider)->
    $mdThemingProvider.theme('default')
        .primaryPalette('grey',
            'default': '900'
        )
        .accentPalette('deep-orange')
        .dark()

    $mdThemingProvider.theme('dialog')
        .primaryPalette('grey')
        .accentPalette('deep-orange')

    $mdIconProvider
        .icon 'menu', './icons/menu-black.svg'

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

.run (appData)->
