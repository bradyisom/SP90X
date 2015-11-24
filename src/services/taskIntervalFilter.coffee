angular.module('sp90x').filter 'taskInterval', ()->
    (val)->
        switch val
            when 'daily'
                'Daily'
            when 'weekly'
                'Weekly'
            when 'monthly'
                'Monthly'
            else
                val
