(function() {
  var repository;

  repository = require('../lib/mongo-repository');

  exports.findPuzzleById = function(test) {
    test.expect(2);
    return repository.getPuzzleById(2, function(puzzle) {
      test.ok(puzzle);
      test.equal(2, puzzle.id);
      return test.done();
    });
  };

  exports.getPuzzleByTopicNames = function(test) {
    test.expect(4);
    return repository.getPuzzleByTopicNames('kevin_bacon', 'Canadian_bacon', function(puzzle) {
      test.ok(puzzle);
      test.equal(2, puzzle.id);
      test.equal('Kevin_Bacon', puzzle.startTopic);
      test.equal('Canadian_Bacon', puzzle.endTopic);
      return test.done();
    });
  };

}).call(this);
