angular.module('sp90x', ['ngMaterial', 'firebase'])
.run (appData)->
    console.log 'app started', appData.ref