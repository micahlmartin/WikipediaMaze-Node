settings = require './settings'

module.exports = 
	log: (message) ->
		if settings.infoLogging?
			console.log message

	logDebug: (message) ->
		if settings.debugLogging?
			console.log message