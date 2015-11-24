angular.module('sp90x').controller 'AdminCtrl', class AdminCtrl
    constructor: (@$scope, @appData, @$mdDialog, @$firebaseArray)->

        @tasks = @appData.listTasks()
        @programs = @appData.listPrograms()

    addButtonClick: (ev)->
        switch @selectedTab
            when 'tasks' 
                @addTask ev

    deleteButtonClick: (record, ev)->
        switch @selectedTab
            when 'tasks' 
                @deleteTask record, ev

    editButtonClick: (record, ev)->
        switch @selectedTab
            when 'tasks' 
                @editTask record, ev

    addTask: (ev)->
        @task = {}
        @$mdDialog.show(
            templateUrl: 'admin/addTask.html'
            controller: 'DialogCtrl'
            controllerAs: 'dlg'
            scope: @$scope
            preserveScope: true
            targetEvent: ev
        ).then (task)=>
            return if not task
            @tasks.$add task

    editTask: (task, ev)->
        @isEditing = true
        @task = angular.copy(task)
        @$mdDialog.show(
            templateUrl: 'admin/addTask.html'
            controller: 'DialogCtrl'
            controllerAs: 'dlg'
            scope: @$scope
            preserveScope: true
            targetEvent: ev
        ).then (newTask)=>
            return if not newTask
            angular.extend(task, newTask)
            @tasks.$save task
        .finally =>
            @isEditing = false


    deleteTask: (task, ev)->
        @$mdDialog.show( @$mdDialog.confirm()
            .title 'Are you sure?'
            .content "Do you want to delete the '#{task.title}' task?"
            .targetEvent ev
            .ok 'Delete It'
            .cancel 'Keep It'
        ).then =>
            @tasks.$remove task

    loadTasks: ->

        loadTask = (id, task, subTasks)=>
            @tasks.$ref().child(id).set(
                task
            , =>
                subTaskList = @appData.listSubTasks(id)
                subTaskList.$loaded =>
                    for subTask,i in subTaskList
                        subTaskList.$remove i
                    for subTask, i in subTasks or []
                        subTaskList.$add order:i, title:subTask
            )

        loadTask 'PRAY',
            title: 'Meaningful Prayer'
            abbr: 'Pr'
            description: 'Have a meaningful conversation with your Heavenly Father at least morning and night'
            points: 1
            defaultInterval: 'daily'

        loadTask 'PONDER',
            title: 'Pondering'
            abbr: 'Po'
            description: 'Find some time each day to quietly ponder the gospel and your life'
            points: 1
            defaultInterval: 'daily'

        loadTask 'SERVICE',
            title: 'Service'
            abbr: 'S'
            description: 'Perform at least one act of service each day'
            points: 1
            defaultInterval: 'daily'

        loadTask 'JOURNAL',
            title: 'Journal Writing'
            abbr: 'J'
            description: 'Record your progress and how the Lord has blessed your life each day'
            points: 1
            defaultInterval: 'daily'

        loadTask 'DTG',
            title: 'Duty to God'
            abbr: 'DTG'
            description: 'Work on your Duty to God for at least half an hour'
            points: 1
            defaultInterval: 'Su'

        loadTask 'PP',
            title: 'Personal Progress'
            abbr: 'PP'
            description: 'Work on your Personal Progress for at least half an hour'
            points: 1
            defaultInterval: 'Su'

        loadTask 'GC',
            title: 'General Conference Talks'
            abbr: 'GC'
            description: 'Study one talk from the most recent General Conference'
            points: 1
            defaultInterval: 'Mo,Th'

        loadTask 'MAG',
            title: 'Church Magazines'
            abbr: 'MAG'
            description: 'Read an article from a recent issue of the New Era or Ensign'
            points: 1
            defaultInterval: 'Tu,Fr'


        loadTask 'BOFM90',
            title: 'Book of Mormon 90'
            description: 'Read the entire Book of Mormon in 90 days'
            points: 1
            defaultInterval: 'daily'
        , [
            '1 Nephi 1-3', '1 Nephi 4-6', '1 Nephi 7-10', '1 Nephi 11-12', '1 Nephi 13-14', '1 Nephi 15-16', '1 Nephi 17-18'
            '1 Nephi 19-20', '1 Nephi 21-22', '2 Nephi 1-2', '2 Nephi 3-4', '2 Nephi 5-7', '2 Nephi 8-9', '2 Nephi 10-12',
            '2 Nephi 13-18', '2 Nephi 19-23' ,'2 Nephi 24-25', '2 Nephi 26-27', '2 Nephi 28-30', '2 Nephi 31-33', 'Jacob 1-3',
            'Jacob 4-5', 'Jacob 6-7', 'Enos, Jarom, Omni', 'Words of Mormon, Mosiah 1', 'Mosiah 2-3', 'Mosiah 4-5', 'Mosiah 6-9',
            'Mosiah 10-12', 'Mosiah 13-15', 'Mosiah 16-18', 'Mosiah 19-21', 'Mosiah 22-24', 'Mosiah 25-26', 'Mosiah 27-29',
            'Alma 1-2', 'Alma 3-4', 'Alma 5-6', 'Alma 7-9', 'Alma 10-11', 'Alma 12-13', 'Alma 14-15',
            'Alma 16-17', 'Alma 18-19', 'Alma 20-22', 'Alma 23-24', 'Alma 25-27', 'Alma 28-30', 'Alma 31-32',
            'Alma 33-34', 'Alma 35-36', 'Alma 37-39', 'Alma 40-42', 'Alma 43-44', 'Alma 45-46', 'Alma 47-48',
            'Alma 49-50', 'Alma 51-52', 'Alma 53-55', 'Alma 56-57', 'Alma 58-60', 'Alma 61-62', 'Alma 63 - Helaman 2',
            'Helaman 3-4', 'Helaman 5-6', 'Helaman 7-9', 'Helaman 10-11', 'Helaman 12-13', 'Helaman 14-16', '3 Nephi 1-3',
            '3 Nephi 4-6', '3 Nephi 7-9', '3 Nephi 10-11', '3 Nephi 12-15', '3 Nephi 16-18', '3 Nephi 19-20', '3 Nephi 21-23',
            '3 Nephi 24-27', '3 Nephi 28-30', '4 Nephi, Mormon 1-2', 'Mormon 3-5', 'Mormon 6-8', 'Mormon 9, Ether 1', 'Ether 2-5',
            'Ether 6-8', 'Ether 9-11', 'Ether 12-13', 'Ether 14-15, Moroni 1-5', 'Moroni 6-7', 'Moroni 8-10'
        ]

        loadTask 'SM-BOFM',
            title: 'Scripture Mastery: Book of Mormon'
            abbr: 'SM'
            description: 'Memorize the Book of Mormon scripture mastery scriptures'
            points: 1
            defaultInterval: 'We,Sa'
        , [
            '1 Nephi 3:7', '1 Nephi 19:23', '2 Nephi 2:25', '2 Nephi 2:27', '2 Nephi 9:28-29', '2 Nephi 28:7-9',
            '2 Nephi 32:3', '2 Nephi 32:8-9', 'Jacob 2:18-19', 'Mosiah 2:17', 'Mosiah 3:19', 'Mosiah 4:30',
            'Alma 32:21', 'Alma 34:32-34', 'Alma 37:6-7', 'Alma 37:35', 'Alma 41:10', 'Helaman 5:12',
            '3 Nephi 11:29', '3 Nephi 27:27', 'Ether 12:6', 'Ether 12:27', 'Moroni 7:16-17', 'Moroni 7:45',
            'Moroni 10:4-5'
        ]

        pmgTasks = [
            'Chapter 1: What Is My Purpose as a Missionary?'
            'Chapter 2: How Do I Study Effectively and Prepare to Teach?'
            'Chapter 3 (Lesson 1): The Message of the Restoration of the Gospel of Jesus Christ'
            'Chapter 3 (Lesson 2): The Plan of Salvation'
            'Chapter 3 (Lesson 3): The Gospel of Jesus Christ'
            'Chapter 3 (Lesson 4): The Commandments'
            'Chapter 3 (Lesson 5): Laws and Ordinances'
            'Chapter 4: How Do I Recognize and Understand the Spirit?'
            'Chapter 5: What Is the Role of the Book of Mormon?'
            'Chapter 6: How Do I Develop Christlike Attributes?'
            'Chapter 8: How Do I Use Time Wisely?'
            'Chapter 10: How Can I Improve My Teaching Skills?'
            'Chapter 11: How Do I Help People Make and Keep Commitments?'
        ]
        pmgTasks = _.reduce(pmgTasks, (memo, task)->
            for i in [1..7]
                memo.push task
            memo
        [])

        loadTask 'PMG',
            title: 'Topical Study: Preach My Gospel'
            abbr: 'PMG'
            description: 'Study a chapter in Preach My Gospel. Study enough to finish the chapter by the end of the week.'
            points: 1
            defaultInterval: 'daily'
        , pmgTasks

    loadPrograms: ->

        loadProgram = (id, program, tasks)=>
            programRef = @programs.$ref().child(id)
            programRef.set(program, =>
                taskList = @$firebaseArray(programRef.child('tasks'))
                taskList.$loaded =>
                    for task,i in taskList
                        taskList.$remove i
                    for taskId,val of tasks
                        taskList.$ref().child(taskId).set val
            )

        loadProgram 'CLASSIC-M', 
            title: 'SP90X Classic - Men'
            description: 'The original program for men and boys'
        ,
            'BOFM90': 'daily'
            'PMG': 'daily'
            'DTG': 'Su'
            'GC': 'Mo,Th'
            'MAG': 'Tu,Fr'
            'SM-BOFM': 'We,Sa'
            'PRAY': 'daily'
            'PONDER': 'daily'
            'SERVICE': 'daily'
            'JOURNAL': 'daily'

        loadProgram 'CLASSIC-W', 
            title: 'SP90X Classic - Women'
            description: 'The original program for women and girls'
        ,
            'BOFM90': 'daily'
            'PMG': 'daily'
            'PP': 'Su'
            'GC': 'Mo,Th'
            'MAG': 'Tu,Fr'
            'SM-BOFM': 'We,Sa'
            'PRAY': 'daily'
            'PONDER': 'daily'
            'SERVICE': 'daily'
            'JOURNAL': 'daily'

