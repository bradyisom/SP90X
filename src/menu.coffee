
angular.module('sp90x')
.controller 'Menu', class MenuCtrl
    constructor: (@$location, @$mdSidenav, @appData)->

    toggleSidenav: (menuId)->
        @$mdSidenav(menuId).toggle()

    go: (path)->
        @$location.path path

    logout: ->
        @appData.logout()
