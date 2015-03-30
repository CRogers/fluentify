var fluentify,
  slice = [].slice;

fluentify = (function() {
  var extendWith;
  extendWith = function(oldObj, key, value) {
    var k, newObj, v;
    newObj = {};
    for (k in oldObj) {
      v = oldObj[k];
      newObj[k] = v;
    }
    newObj[key] = value;
    return newObj;
  };
  return function(namedArgs, currentArgs, topArgs, callback) {
    var ret;
    if (namedArgs.length === 0) {
      return callback.apply(null, slice.call(topArgs).concat([currentArgs]));
    }
    ret = {};
    namedArgs.forEach(function(nameArg) {
      return ret[nameArg] = function() {
        var inArgs, newCurrentArgs, unusedNamedArgs;
        inArgs = 1 <= arguments.length ? slice.call(arguments, 0) : [];
        newCurrentArgs = extendWith(currentArgs, nameArg, inArgs);
        unusedNamedArgs = namedArgs.filter(function(x) {
          return x !== nameArg;
        });
        return fluentify(unusedNamedArgs, newCurrentArgs, topArgs, callback);
      };
    });
    return ret;
  };
})();

if (((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) && this.module !== module) {
  module.exports = function() {
    var callback, i, namedArgs;
    namedArgs = 2 <= arguments.length ? slice.call(arguments, 0, i = arguments.length - 1) : (i = 0, []), callback = arguments[i++];
    return function() {
      var topArgs;
      topArgs = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      return fluentify(namedArgs, {}, topArgs, callback);
    };
  };
}
