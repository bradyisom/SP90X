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

# Security Rules
```
{
    "rules": {
        "users": {
            "$user_id": {
                ".read": "auth != null && auth.uid == $user_id",
                ".write": "(auth != null && auth.uid == $user_id) || !data.exists()",
                ".validate": "newData.hasChildren(['firstName', 'lastName', 'email'])",
                "firstName": {
                    ".validate": "newData.isString()"    
                },
                "lastName": {
                    ".validate": "newData.isString()"    
                },
                "email": {
                    ".validate": "newData.isString()"    
                },
                "schedules": {
                    "$schedule_id": {
                        ".validate": "root.child('schedules/' + $user_id).hasChild($schedule_id) && newData.isBoolean()"
                    }
                },
                "groups": {
                    "$group_id": {
                        ".validate": "root.child('groups').hasChild($group_id) && newData.isBoolean()"
                    }
                }
            }
        },
        "groups": {
            ".read": true,
            "$group_id": {
                ".write": "newData.exists() && auth != null && ((data.exists() && data.owner == auth.uid) || (!data.exists() && newData.owner == auth.uid))",
                ".validate": "newData.hasChildren(['name', 'owner', 'startDate', 'endDate', 'program'])",
                "name": {
                    ".validate": "newData.isString()"    
                },
                "description": {
                    ".validate": "newData.isString()"    
                },
                "owner": {
                    ".validate": "newData.isString()"    
                },
                "program": {
                    ".validate": "root.child('programs/' + newData.val()).exists()"    
                },
                "startDate": {
                    ".validate": "newData.isString()"    
                },
                "endDate": {
                    ".validate": "newData.isString()"    
                },
                "users": {
                    "$user_id": {
                        ".write": "auth != null && $user_id == auth.uid",
                        ".validate": "newData.hasChildren(['firstName', 'lastName', 'email', 'schedule'])",
                        "firstName": {
                            ".validate": "newData.isString()"    
                        },
                        "lastName": {
                            ".validate": "newData.isString()"    
                        },
                        "email": {
                            ".validate": "newData.isString()"    
                        },
                        "points": {
                            ".validate": "newData.isNumber()"    
                        }
                    }
                }
            }
        },
        "tasks": {
            ".read": true,
            "$task_id": {
                ".write": "auth != null && root.child('users').child(auth.uid).child('isAdmin').val() === true",
                "title": {
                    ".validate": "newData.isString()"    
                },
                "description": {
                    ".validate": "newData.isString()"    
                },
                "points": {
                    ".validate": "newData.isNumber()"    
                },
                "defaultInterval": {
                    ".validate": "newData.val().matches(/^(daily|weekly|monthly|(Mo|Tu|We|Th|Fr|Sa|Su)+)$/)"
                }
            }
        },
        "programs": {
            ".read": true,
            "$program_id": {
                ".write": "auth != null && root.child('users').child(auth.uid).child('isAdmin').val() === true",
                "title": {
                    ".validate": "newData.isString()"    
                },
                "description": {
                    ".validate": "newData.isString()"    
                },
                "tasks": {
                    "$task_id": {
                        ".validate": "root.child('tasks').hasChild($task_id) && newData.val().matches(/^(daily|weekly|monthly|(Mo|Tu|We|Th|Fr|Sa|Su)+)$/)"
                    }
                }
            }
        },
        "schedules": {
            "$user_id": {
                ".read": "auth != null && $user_id == auth.uid",
                ".write": "auth != null && $user_id == auth.uid",
                "$schedule_id": {
                    ".validate": "newData.hasChildren(['programTitle', 'startDate', 'endDate', 'tasks'])",
                    "programTitle": {
                        ".validate": "newData.isString()"    
                    },
                    "startDate": {
                        ".validate": "newData.isString()"    
                    },
                    "endDate": {
                        ".validate": "newData.isString()"    
                    },
                    "group": {
                        ".validate": "root.child('groups/' + newData.val()).exists()"
                    },
                    "points": {
                        ".validate": "newData.isNumber()"    
                    },
                    "tasks": {
                        ".validate": "root.child('tasks/' + newData.val()).exists()",
                        "$task_id": {
                            ".validate": "newData.val().matches(/^(daily|weekly|monthly|(Mo|Tu|We|Th|Fr|Sa|Su)+)$/)"
                        }
                    },
                    "entries": {
                        "daily": {
                            "$date": {
                                "$task_id": {
                                    ".validate": "newData.isBoolean()"
                                }
                            }
                        },
                        "weekly": {
                            "$date": {
                                "$task_id": {
                                    ".validate": "newData.isBoolean()"
                                }
                            }
                        },
                        "monthly": {
                            "$date": {
                                "$task_id": {
                                    ".validate": "newData.isBoolean()"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
```