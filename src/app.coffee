angular.module('sp90x', ['ngMaterial', 'firebase'])
.config ($mdThemingProvider, $mdIconProvider)->
    $mdThemingProvider.theme('default')
        .primaryPalette('grey')
        .accentPalette('deep-orange')
        .dark()

    $mdIconProvider
        .icon 'menu', './icons/menu-black.svg'

.run (appData)->
    console.log 'app started', appData.ref

