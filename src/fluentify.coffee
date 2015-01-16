extendWith = (oldObj, key, value) ->
  newObj = {}
  for k, v of oldObj
    newObj[k] = v
  newObj[key] = value
  return newObj

fluentify = (namedArgs, currentArgs, topArgs, callback) ->
  if namedArgs.length == 0
    return callback(topArgs..., currentArgs)

  ret = {}
  namedArgs.forEach (nameArg) ->
    ret[nameArg] = (inArgs...) ->
      newCurrentArgs = extendWith(currentArgs, nameArg, inArgs)
      unusedNamedArgs = namedArgs.filter (x) -> x != nameArg
      fluentify(unusedNamedArgs, newCurrentArgs, topArgs, callback)
  return ret

module.exports = (namedArgs..., callback) ->
  return (topArgs...) -> fluentify(namedArgs, {}, topArgs, callback)