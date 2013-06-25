'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
])

.controller('EventListCtrl', [
  '$scope'
  'Event'

($scope, Event) ->
   $scope.events = Event.query()
])

.controller('CalendarCtrl', [
  '$scope'
  'Event'

($scope, Event) ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  $scope.events = Event.query()

  # alert on Click.
  $scope.alertEventOnClick = (date, allDay, jsEvent, view) ->
    $scope.$apply ->
      $scope.alertMessage = ("Day Clicked " + date)

  # alert on Drop 
  $scope.alertOnDrop = (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) ->
    $scope.$apply ->
      updateEvent = Event.get eventId: event.id, ->
        updateEvent.start = event.start
        updateEvent.end = event.end
        updateEvent.allDay = event.allDay
        updateEvent.$save()
        $scope.alertMessage = ("Event: \n" + JSON.stringify(event) + "\ndayDelta: " + JSON.stringify(dayDelta) + "\nminuteDelta: " + minuteDelta + "\nallDay: " + JSON.stringify(allDay) + "\n\nupdateEvent: " + JSON.stringify(updateEvent))



  # alert on Resize 
  $scope.alertOnResize = (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) ->
    $scope.$apply ->
      updateEvent = Event.get eventId: event.id, ->
        updateEvent.start = event.start
        updateEvent.end = event.end
        updateEvent.allDay = event.allDay
        updateEvent.$save()
        $scope.alertMessage = ("Event: \n" + JSON.stringify(event) + "\ndayDelta: " + JSON.stringify(dayDelta) + "\nminuteDelta: " + minuteDelta + "\nallDay: " + JSON.stringify(allDay) + "\n\nupdateEvent: " + JSON.stringify(updateEvent))

  # add and removes an event source of choice 
  $scope.addRemoveEventSource = (sources, source) ->
    canAdd = 0
    angular.forEach sources, (value, key) ->
      if sources[key] is source
        sources.splice key, 1
        canAdd = 1

    sources.push source  if canAdd is 0


  # add custom event
  $scope.addEvent = ->
    $scope.events.push
      title: "Open Sesame"
      start: new Date(y, m, 28)
      end: new Date(y, m, 29)
      className: ["openSesame"]

  # remove event 
  $scope.remove = (index) ->
    $scope.events.splice index, 1

  # Change View 
  $scope.changeView = (view) ->
    $scope.myCalendar.fullCalendar "changeView", view

  # config object 
  $scope.uiConfig = calendar:
    height: 450
    editable: true
    header:
      left: "month basicWeek basicDay agendaWeek agendaDay"
      center: "title"
      right: "today prev,next"

    dayClick: $scope.alertEventOnClick
    eventDrop: $scope.alertOnDrop
    eventResize: $scope.alertOnResize

  # event sources array
  $scope.eventSources = [$scope.events, $scope.eventSource]
])

.controller('TodoCtrl', [
  '$scope'

($scope) ->

  $scope.todos = [
    text: "learn angular"
    done: true
  ,
    text: "build an angular app"
    done: false
  ]

  $scope.addTodo = ->
    $scope.todos.push
      text: $scope.todoText
      done: false

    $scope.todoText = ""

  $scope.remaining = ->
    count = 0
    angular.forEach $scope.todos, (todo) ->
      count += (if todo.done then 0 else 1)

    count

  $scope.archive = ->
    oldTodos = $scope.todos
    $scope.todos = []
    angular.forEach oldTodos, (todo) ->
      $scope.todos.push todo  unless todo.done

])

