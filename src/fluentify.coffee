fluentify = do ->

  extendWith = (oldObj, key, value) ->
    newObj = {}
    for k, v of oldObj
      newObj[k] = v
    newObj[key] = value
    return newObj

  fullFluentify = (namedArgs, currentArgs, topArgs, callback) ->
    if namedArgs.length == 0
      return callback(topArgs..., currentArgs)

    ret = {}
    namedArgs.forEach (nameArg) ->
      ret[nameArg] = (inArgs...) ->
        newCurrentArgs = extendWith(currentArgs, nameArg, inArgs)
        unusedNamedArgs = namedArgs.filter (x) -> x != nameArg
        fullFluentify(unusedNamedArgs, newCurrentArgs, topArgs, callback)
    return ret

  return (namedArgs..., callback) ->
    return (topArgs...) -> fullFluentify(namedArgs, {}, topArgs, callback)

if module?.exports? and @module != module
  module.exports = fluentify