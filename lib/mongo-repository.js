(function() {
  var getCollection, mongodb, openDB, settings, utils,
    _this = this;

  mongodb = require('mongodb');

  settings = require('./settings');

  utils = require('./utils');

  openDB = function(callback) {
    var dbConnection, mongoServer;
    mongoServer = new mongodb.Server(settings.mongo.host, settings.mongo.port);
    dbConnection = new mongodb.Db(settings.mongo.db, mongoServer);
    return dbConnection.open(function(err, db) {
      if (err) {
        utils.log('An error ocurred opening the database connection');
        throw err;
      }
      if (settings.mongo.username != null) {
        return db.authenticate(settings.mongo.username, settings.mongo.password, function(err, result) {
          utils.log(err);
          return callback(db);
        });
      } else {
        return callback(db);
      }
    });
  };

  getCollection = function(name, callback) {
    return openDB(function(db) {
      return db.collection(name, function(err, coll) {
        utils.log('Loading collection ' + name);
        return callback(err, coll, db);
      });
    });
  };

  module.exports = {
    openDB: openDB,
    getCollection: getCollection,
    getPuzzleById: function(id, callback) {
      utils.log('Getting puzzle by id');
      return getCollection('puzzles', function(err, coll, db) {
        return coll.findOne({
          "id": id
        }, function(err, doc) {
          db.close();
          return callback(doc);
        });
      });
    },
    getPuzzleByTopicNames: function(startTopicName, endTopicName) {
      utils.log('Getting puzzle by topic names');
      return getCollection('puzzles', function(err, coll, db) {
        return coll.findOne({
          'startTopic': eval('/' + startTopicName + '/i'),
          'endTopic': eval('/' + endTopicName + '/i')
        });
      });
    }
  };

  /*
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
  */

}).call(this);
