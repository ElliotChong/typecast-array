test = require "tape"
TypedArray = require "../"
isArray = require "lodash/lang/isArray"

class TestClass
	constructor: (@data) ->

test "casts Objects on construct", (p_test) ->
	typedArray = new TypedArray TestClass, [{ foo: "bar" }]

	p_test.ok typedArray[0]?, "`typedArray[0]` exists"
	p_test.ok typedArray[0] instanceof TestClass, "`typedArray[0]` is an instance of `TestClass`"
	p_test.ok typedArray[0].data.foo is "bar", "`typedArray[0]` has a `data.foo` property equal to `bar`"

	p_test.end()

test "is an instance of Array", (p_test) ->
	typedArray = new TypedArray TestClass

	p_test.ok typedArray instanceof Array, "`typedArray` is an instance of an Array"

	p_test.end()

test "requires a type on instantiation", (p_test) ->
	p_test.throws ->
		new TypedArray()
	, /`type` parameter is required/

	p_test.end()

test "add", (p_test) ->
	typedArray = new TypedArray TestClass
	typedArray.add { foo: "bar" }

	p_test.ok typedArray[0]?, "`typedArray[0]` exists"
	p_test.ok typedArray[0] instanceof TestClass, "`typedArray[0]` is an instance of `TestClass`"
	p_test.ok typedArray[0].data.foo is "bar", "`typedArray[0]` has a `data.foo` property equal to `bar`"

	p_test.end()

test "remove", (p_test) ->
	typedArray = new TypedArray TestClass
	object = typedArray.add { foo: "bar" }

	p_test.ok object?, "`object` exists"
	p_test.ok object instanceof TestClass, "`object` is an instance of `TestClass`"
	p_test.ok object.data.foo is "bar", "`object` has a `data.foo` property equal to `bar`"

	typedArray.remove object
	p_test.ok typedArray.length is 0, "`typedArray.length` should be 0"

	p_test.end()

test "push", (p_test) ->
	typedArray = new TypedArray TestClass
	typedArray.push { foo: "bar" }

	p_test.ok typedArray[0]?, "`typedArray[0]` exists"
	p_test.ok typedArray[0] instanceof TestClass, "`typedArray[0]` is an instance of `TestClass`"
	p_test.ok typedArray[0].data.foo is "bar", "`typedArray[0]` has a `data.foo` property equal to `bar`"

	p_test.end()

test "unshift", (p_test) ->
	typedArray = new TypedArray TestClass
	typedArray.unshift { foo: "bar" }

	p_test.ok typedArray[0]?, "`typedArray[0]` exists"
	p_test.ok typedArray[0] instanceof TestClass, "`typedArray[0]` is an instance of `TestClass`"
	p_test.ok typedArray[0].data.foo is "bar", "`typedArray[0]` has a `data.foo` property equal to `bar`"

	p_test.end()

test "splice", (p_test) ->
	typedArray = new TypedArray TestClass, [{ foo: "1" }, { bar: "2" }, { baz: "3" }]
	typedArray.splice 1, 1, { bang: "4" }

	p_test.ok typedArray.length is 3, "`typedArray.length` should be 3"
	p_test.ok typedArray[1]?, "`typedArray[1]` exists"
	p_test.ok typedArray[1] instanceof TestClass, "`typedArray[1]` is an instance of `TestClass`"
	p_test.ok typedArray[1].data.bang is "4", "`typedArray[1]` has a `data.bang` property equal to `4`"

	p_test.end()

test "transform", (p_test) ->
	transform = (p_value) ->
		p_value.index++
		return p_value

	typedArray = new TypedArray TestClass, transform, [{ index: 1 }, { index: 2 }, { index: 3 }]

	p_test.equals typedArray[0].data.index, 2
	p_test.equals typedArray[1].data.index, 3
	p_test.equals typedArray[2].data.index, 4

	p_test.end()

test "to and toArray", (p_test) ->
	typedArray = new TypedArray TestClass, [{ index: 1 }, { index: 2 }, { index: 3 }]

	for method in ["to", "toArray"]
		array = typedArray[method]()

		p_test.true isArray array
		p_test.equals typedArray.length, array.length
		p_test.equals typedArray.length[0], array.length[0]
		p_test.equals typedArray.length[typedArray.length - 1], array.length[array.length - 1]
		p_test.equals array[0].data.index, 1
		p_test.equals array[1].data.index, 2
		p_test.equals array[2].data.index, 3

	p_test.end()
