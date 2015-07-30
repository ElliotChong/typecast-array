isArray = require "lodash/lang/isArray"
isArguments = require "lodash/lang/isArguments"
isFunction = require "lodash/lang/isFunction"

typecast = (p_array, p_type) ->
	if not p_array?
		return

	if not isArguments(p_array) and not isArray p_array
		p_array = [p_array]

	for value in p_array
		if value instanceof p_type
			value
		else
			new p_type value

class TypedArray extends Array
	constructor: (p_type, p_array) ->
		if not isFunction p_type
			throw new Error "The `type` parameter is required to create a TypedArray"

		@type = p_type

		@from p_array

	from: (p_array) ->
		if not p_array?
			return

		# Array.from() may not be available on all browsers
		try
			array = TypedArray.__super__.from?.apply @, arguments
			if array?
				p_array = array

		if not isArray p_array
			throw new Error "The `array` parameter can only be an Array"

		# Empty the current TypedArray
		@length = 0

		@push value for value in p_array

		return @

	add: ->
		@push.apply @, arguments

	remove: ->
		for value in arguments
			index = @indexOf value

			if index is -1
				continue

			@splice index, 1

	# TODO: Implement testing to validate
	# concat: ->
	# 	args = for value in arguments
	# 		if isArray(value) and not value.type?
	# 			@_create.apply @, value
	# 		else
	# 			value
	#
	# 	TypedArray.__super__.concat.apply @, @_create args

	# TODO: Return a new TypedArray instance
	# filter: ->

	# TODO: Wrap this experimental call
	# fill: ->

	# TODO: Wrap this experimental call
	# of: ->

	push: ->
		args = typecast arguments, @type
		TypedArray.__super__.push.apply @, args

		if args.length is 1
			return args[0]

		return args

	splice: ->
		# Convert the `arguments` to an Array
		args = (argument for argument in arguments)

		TypedArray.__super__.splice.apply @, args.slice(0, 2).concat typecast args.slice(2), @type

	unshift: ->
		TypedArray.__super__.unshift.apply @, typecast arguments, @type

module.exports = TypedArray
