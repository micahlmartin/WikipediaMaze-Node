repository = require '../lib/mongo-repository'

exports.findPuzzleById = (test) ->
	test.expect 2
	repository.getPuzzleById 2, (puzzle) ->
		test.ok puzzle
		test.equal 2, puzzle.id
		test.done()

exports.getPuzzleByTopicNames = (test) ->
	test.expect 4
	repository.getPuzzleByTopicNames 'kevin_bacon', 'Canadian_bacon', (puzzle) ->
		test.ok puzzle
		test.equal 2, puzzle.id
		test.equal 'Kevin_Bacon', puzzle.startTopic
		test.equal 'Canadian_Bacon', puzzle.endTopic
		test.done()

exports.getPuzzlesByUserId = (test) ->
	test.expect 1
	repository.getPuzzlesByUserId 16, null, 0, 50, (puzzles) ->
		test.equal 2, puzzles.length
		test.done()

exports.getPuzzlesByUserId_paging = (test) ->
	test.expect 2
	repository.getPuzzlesByUserId 16, null, 1, 1, (puzzles) ->
		test.equal 1, puzzles.length
		test.equal 2, puzzles[0].id
		test.done()

exports.getPuzzlesByUserId_paging_handlesNulls = (test) ->
	test.expect 2
	repository.getPuzzlesByUserId 16, null, null, null, (puzzles) ->
		test.equal 2, puzzles.length
		test.equal 7, puzzles[0].id
		test.done()

exports.getPuzzlesByUserId_sorting = (test) ->
	test.expect 3
	repository.getPuzzlesByUserId 16, 'newest', 0, 50, (puzzles) ->
		test.equal 2, puzzles.length
		test.equal 7, puzzles[0].id
		test.equal 2, puzzles[1].id
		test.done()




