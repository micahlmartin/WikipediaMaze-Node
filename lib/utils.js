(function() {
  var settings;

  settings = require('./settings');

  module.exports = {
    log: function(message) {
      if (settings.infoLogging != null) return console.log(message);
    },
    logDebug: function(message) {
      if (settings.debugLogging != null) return console.log(message);
    }
  };

}).call(this);
