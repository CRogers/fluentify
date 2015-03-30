fluentify = do ->

  extendWith = (oldObj, key, value) ->
    newObj = {}
    for k, v of oldObj
      newObj[k] = v
    newObj[key] = value
    return newObj

  fullFluentify = (methodNames, argsCalledForMethods, initialArgs, callback) ->
    if methodNames.length == 0
      return callback(initialArgs..., argsCalledForMethods)

    nextMethods = {}
    methodNames.forEach (methodName) ->
      nextMethods[methodName] = (methodArgs...) ->
        newArgsCalledForMethods = extendWith(argsCalledForMethods, methodName, methodArgs)
        unusedMethodNames = methodNames.filter (x) -> x != methodName
        return fullFluentify(unusedMethodNames, newArgsCalledForMethods, initialArgs, callback)
    return nextMethods

  return (methodNames..., callback) ->
    return (initialArgs...) -> fullFluentify(methodNames, {}, initialArgs, callback)

do ->
  isNodeEnvironment = module?.exports? and @module != module
  if isNodeEnvironment
    module.exports = fluentify