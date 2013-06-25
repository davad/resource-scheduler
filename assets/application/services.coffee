'use strict'

### Sevices ###

angular.module('app.services', ['ngResource'])
#.factory 'version', -> "0.1"
.factory 'Event', ($resource) ->
  $resource(
    'event/:eventId'
    {eventId: '@id'}
    {
      'save': {method: 'PUT'}
    }
  )

