var fluentify,
  slice = [].slice;

fluentify = (function() {
  var extend, fullFluentify;
  extend = function(oldObj) {
    return {
      "with": function(key, value) {
        var k, newObj, v;
        newObj = {};
        for (k in oldObj) {
          v = oldObj[k];
          newObj[k] = v;
        }
        newObj[key] = value;
        return newObj;
      }
    };
  };
  fullFluentify = function(methodNames, argsCalledForMethods, initialArgs, callback) {
    var nextMethods;
    if (methodNames.length === 0) {
      return callback.apply(null, slice.call(initialArgs).concat([argsCalledForMethods]));
    }
    nextMethods = {};
    methodNames.forEach(function(methodName) {
      return nextMethods[methodName] = function() {
        var methodArgs, newArgsCalledForMethods, unusedMethodNames;
        methodArgs = 1 <= arguments.length ? slice.call(arguments, 0) : [];
        newArgsCalledForMethods = extend(argsCalledForMethods)["with"](methodName, methodArgs);
        unusedMethodNames = methodNames.filter(function(x) {
          return x !== methodName;
        });
        return fullFluentify(unusedMethodNames, newArgsCalledForMethods, initialArgs, callback);
      };
    });
    return nextMethods;
  };
  return function() {
    var callback, i, methodNames;
    methodNames = 2 <= arguments.length ? slice.call(arguments, 0, i = arguments.length - 1) : (i = 0, []), callback = arguments[i++];
    return function() {
      var initialArgs;
      initialArgs = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      return fullFluentify(methodNames, {}, initialArgs, callback);
    };
  };
})();

(function() {
  var isNodeEnvironment;
  isNodeEnvironment = ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) && this.module !== module;
  if (isNodeEnvironment) {
    return module.exports = fluentify;
  }
})();
