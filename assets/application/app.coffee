'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.services'
  'app.controllers'
  'app.directives'
  #  'app.filters'
  'ui.calendar'
])

App.config([
  '$routeProvider'
  '$locationProvider'

  ($routeProvider, $locationProvider, config) ->

    $routeProvider

      .when('/todo', {templateUrl: 'views/partials/todo.html',
      controller: 'TodoCtrl'})

      .when('/view1', {templateUrl: 'views/partials/partial1.html',
      controller: 'AppCtrl'})

      .when('/view2', {templateUrl: 'views/partials/partial2.html',
      controller: 'AppCtrl'})

      .when('/events', {templateUrl: 'views/partials/events.html',
      controller: 'EventListCtrl'})

      .when('/calendar', {templateUrl: 'views/partials/calendar.html',
      controller: 'CalendarCtrl'})

    # Catch all
      .otherwise({redirectTo: '/calendar'})

    # Without server side support html5 must be disabled.
    $locationProvider.html5Mode(true)
])
