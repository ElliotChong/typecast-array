# Typecast Array

Automatically cast configuration Objects into complex data types through normal Array operations like push, unshift, and more!

**_WARNING: This is an Alpha release of Typecast Array. Tests and documentation are still in progress._**

## Installation

```bash
$ npm install typecast-array
```

## Usage

```JavaScript
var TypecastArray = require("typecast-array");

// Some complex Class you would instantiate via the `new` operator
var Ractive = require("ractive");

// Test data
var modelConfigs = [{ data: { name: "Elephant" } }, { data: { name: "Monkey" }}];

// Create a TypecastArray and optionally specify an Array to convert
var ractiveModels = new TypecastArray(Ractive, models);

// Add an automatically-typed Object via typical Array methods
ractiveModels.push({ data: { name: "Beluga" } });

// Validate that the configuration objects were turned into Ractive instances
ractiveModels.forEach(function (value, key) {
	console.log(value instanceof Ractive);
});
```

## License

(The MIT License)

Copyright (c) 2015 Elliot Chong &lt;code+typecast-array@elliotjameschong.com&gt;

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	'Software'), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
