
angular.module('sp90x')
.controller 'Menu', class MenuCtrl
    constructor: (@$mdSidenav)->

    toggleSidenav: (menuId)->
        @$mdSidenav(menuId).toggle()
