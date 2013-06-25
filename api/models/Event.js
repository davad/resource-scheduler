/*---------------------
	:: Event
	-> model
---------------------*/
module.exports = {

	attributes	: {

		// Simple attribute:
		// name: 'STRING',

		// Or for more flexibility:
		// phoneNumber: {
		//	type: 'STRING',
		//	defaultValue: '555-555-5555'
		// }

    title: {
      type: 'STRING'
    },

    body: {
      type: 'STRING'
    },

    start: {
      type: 'DATE'
    },

    end: {
      type: 'DATE'
    },

    _resource: {
      type: 'STRING'
    },

    allDay: {
      type: 'INTEGER'
    }
		
	}

};
