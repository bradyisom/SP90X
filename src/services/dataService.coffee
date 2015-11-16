class DataService
    constructor: ->
        @ref = new Firebase('https://sp90x.firebaseio.com')

    

angular.module('sp90x').service 'appData', DataService