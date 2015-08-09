isArray = require "lodash/lang/isArray"
isArguments = require "lodash/lang/isArguments"
isFunction = require "lodash/lang/isFunction"

typecast = (p_array, p_type, p_transform) ->
	if not p_array?
		return

	if not isArguments(p_array) and not isArray p_array
		p_array = [p_array]

	for value in p_array
		if value instanceof p_type
			value
		else
			if p_transform?
				value = p_transform value

			new p_type value

class TypecastArray extends Array
	constructor: (p_type, p_transform, p_array) ->
		if not isFunction p_type
			throw new Error "The `type` parameter is required to create a TypecastArray"

		if isArray p_transform
			p_array = p_transform

		if not isFunction p_transform
			p_transform = undefined

		@transform = p_transform
		@type = p_type

		# Alias methods
		@fromArray = @from
		@toArray = @to

		@from p_array

	from: (p_array) ->
		if not p_array?
			return

		# Array.from() may not be available on all browsers
		try
			array = TypecastArray.__super__.from?.apply @, arguments
			if array?
				p_array = array

		if not isArray p_array
			throw new Error "The `array` parameter can only be an Array"

		# Empty the current TypecastArray
		@length = 0

		@push value for value in p_array

		return @

	to: ->
		for item in @
			item

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
	# 	TypecastArray.__super__.concat.apply @, @_create args

	# TODO: Return a new TypecastArray instance
	# filter: ->

	# TODO: Wrap this experimental call
	# fill: ->

	# TODO: Wrap this experimental call
	# of: ->

	push: ->
		args = typecast arguments, @type, @transform
		TypecastArray.__super__.push.apply @, args

		if args.length is 1
			return args[0]

		return args

	splice: ->
		# Convert the `arguments` to an Array
		args = (argument for argument in arguments)

		TypecastArray.__super__.splice.apply @, args.slice(0, 2).concat typecast args.slice(2), @type, @transform

	unshift: ->
		TypecastArray.__super__.unshift.apply @, typecast arguments, @type, @transform

module.exports = TypecastArray
