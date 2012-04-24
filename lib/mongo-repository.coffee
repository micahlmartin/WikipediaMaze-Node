mongodb = require 'mongodb'
settings = require './settings'
utils = require './utils'

openDB = (callback) ->
	mongoServer = new mongodb.Server settings.mongo.host, settings.mongo.port 
	dbConnection = new mongodb.Db settings.mongo.db, mongoServer
	dbConnection.open (err, db) ->
		if err
			utils.log 'An error ocurred opening the database connection'
			throw err

		if settings.mongo.username?
			db.authenticate settings.mongo.username, settings.mongo.password, (err, result) ->
				utils.log err
				callback db
		else
			callback db

getCollection = (name, callback) ->
	openDB (db) ->
		db.collection name, (err, coll) ->
			utils.log 'Loading collection ' + name 

			callback err, coll, db

module.exports = 

	openDB: openDB

	getCollection: getCollection

	#Puzzles
	getPuzzleById: (id, callback) =>
		utils.log 'Getting puzzle by id'

		getCollection 'puzzles', (err, coll, db) ->
			coll.findOne "id": id, (err, doc) ->
				db.close()
				callback doc

	getPuzzleByTopicNames: (startTopicName, endTopicName) ->
		utils.log 'Getting puzzle by topic names'

		getCollection 'puzzles', (err, coll, db) ->
			coll.findOne 
				'startTopic': eval '/' + startTopicName + '/i'
				'endTopic': eval '/' + endTopicName + '/i'

###
	getAll: (pageNumber, pageCount, callback) ->
		utils.log 'Returning all plants ' + pageNumber + ' ' + pageCount

		pageNumber = Math.max pageNumber || 1
		pageCount = Math.min pageCount || 10

		getCollection 'plants', (err, coll, db) ->
			coll.find().toArray (err, docs) ->
				db.close()
				utils.log docs
				callback err, docs

	getByType: (type, callback) ->
		utils.log 'Search for plants of type ' + type

		getCollection 'plants', (err, coll, db) ->
			coll.find( "type": type).toArray (err, docs) ->
				db.close()
				utils.log docs
				callback err, docs

	getByName: (name, callback) ->
		utils.log 'Find plant by name ' + name

		getCollection 'plants', (err, coll, db) ->
			coll.findOne  name: eval '/' + name + '/i', (err, doc) ->
				db.close()
				utils.log doc
				callback err, doc

	nameSearch: (term, callback) ->
		utils.log 'Search plants by name ' + term

		getCollection 'plants', (err, coll, db) ->
			coll.find( name: eval '/' + term + '/i' ).toArray (err, docs) ->
				db.close()
				utils.log docs
				callback err, docs
