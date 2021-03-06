(function() {
  var TypecastArray, isArguments, isArray, isFunction, typecast,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  isArray = require("lodash/lang/isArray");

  isArguments = require("lodash/lang/isArguments");

  isFunction = require("lodash/lang/isFunction");

  typecast = function(p_array, p_type, p_transform) {
    var value, _i, _len, _results;
    if (p_array == null) {
      return;
    }
    if (!isArguments(p_array) && !isArray(p_array)) {
      p_array = [p_array];
    }
    _results = [];
    for (_i = 0, _len = p_array.length; _i < _len; _i++) {
      value = p_array[_i];
      if (value instanceof p_type) {
        _results.push(value);
      } else {
        if (p_transform != null) {
          value = p_transform(value);
        }
        _results.push(new p_type(value));
      }
    }
    return _results;
  };

  TypecastArray = (function(_super) {
    __extends(TypecastArray, _super);

    function TypecastArray(p_type, p_transform, p_array) {
      if (!isFunction(p_type)) {
        throw new Error("The `type` parameter is required to create a TypecastArray");
      }
      if (isArray(p_transform)) {
        p_array = p_transform;
      }
      if (!isFunction(p_transform)) {
        p_transform = void 0;
      }
      this.transform = p_transform;
      this.type = p_type;
      this.fromArray = this.from;
      this.toArray = this.to;
      this.from(p_array);
    }

    TypecastArray.prototype.from = function(p_array) {
      var array, value, _i, _len, _ref;
      if (p_array == null) {
        return;
      }
      try {
        array = (_ref = TypecastArray.__super__.from) != null ? _ref.apply(this, arguments) : void 0;
        if (array != null) {
          p_array = array;
        }
      } catch (_error) {}
      if (!isArray(p_array)) {
        throw new Error("The `array` parameter can only be an Array");
      }
      this.length = 0;
      for (_i = 0, _len = p_array.length; _i < _len; _i++) {
        value = p_array[_i];
        this.push(value);
      }
      return this;
    };

    TypecastArray.prototype.to = function() {
      var item, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = this.length; _i < _len; _i++) {
        item = this[_i];
        _results.push(item);
      }
      return _results;
    };

    TypecastArray.prototype.add = function() {
      return this.push.apply(this, arguments);
    };

    TypecastArray.prototype.remove = function() {
      var index, value, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = arguments.length; _i < _len; _i++) {
        value = arguments[_i];
        index = this.indexOf(value);
        if (index === -1) {
          continue;
        }
        _results.push(this.splice(index, 1));
      }
      return _results;
    };

    TypecastArray.prototype.push = function() {
      var args;
      args = typecast(arguments, this.type, this.transform);
      TypecastArray.__super__.push.apply(this, args);
      if (args.length === 1) {
        return args[0];
      }
      return args;
    };

    TypecastArray.prototype.splice = function() {
      var args, argument;
      args = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = arguments.length; _i < _len; _i++) {
          argument = arguments[_i];
          _results.push(argument);
        }
        return _results;
      }).apply(this, arguments);
      return TypecastArray.__super__.splice.apply(this, args.slice(0, 2).concat(typecast(args.slice(2), this.type, this.transform)));
    };

    TypecastArray.prototype.unshift = function() {
      return TypecastArray.__super__.unshift.apply(this, typecast(arguments, this.type, this.transform));
    };

    return TypecastArray;

  })(Array);

  module.exports = TypecastArray;

}).call(this);
