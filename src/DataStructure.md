# Structure

```
{
    users: [
        $user_id: {
            firstName: <string>,
            lastname: <string>,
            email: <string>,
            schedules: {
                $schedule_id: true
            },
            groups: {
                $group_id: true
            }
        }
    ],
    groups: [
        $group_id: {
            name: <string>,
            description: <string>,
            owner: $user_id,
            program: $program_id,
            startDate: <isodate>,
            endDate: <isodate>,
            users: [
                $user_id: 
                    firstName: <string>,
                    lastname: <string>,
                    email: <string>,
                    points: <number>
            ]
        }
    ],
    tasks: [
        $task_id: {
            title: <string>,
            description: <string>,
            points: <number>,
            defaultInterval: 'daily|weekly|monthly|[Mo|Tu|We|Th|Fr|Sa|Su]+'
        }    
    ],
    subTasks: [
        $task_id: [
            order: <number>,
            title: <string>
        ]
    ]
    programs: [
        $program_id: {
            title: <string>,
            description: <string>,
            tasks: [
                $task_id: 'daily|weekly|monthly|[Mo|Tu|We|Th|Fr|Sa|Su]+'
            ]
        }
    ],
    schedules: [
        $user_id: [
            $schedule_id: {
                programTitle: <string>,
                startDate: <isodate>,
                endDate: <isodate>,
                (group: $group_id,)
                points: <number>
                tasks: [
                    $task_id: 'daily|weekly|monthly|[Mo|Tu|We|Th|Fr|Sa|Su]+'
                ],
                entries: {
                    daily: [
                        <isodate>: {
                            $task_id: true
                        }
                    ],
                    weekly: [
                        <isodate>: {
                            $task_id: true
                        }
                    ],
                    monthly: [
                        <isodate>: {
                            $task_id: true
                        }
                    ]
                }
            }
        ]
    ]
}
```

