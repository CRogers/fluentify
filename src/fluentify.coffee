fluentify = (namedArgs, currentArgs, topArgs, callback) ->
  if namedArgs.length == 0
    return callback(topArgs..., currentArgs)

  ret = {}
  namedArgs.forEach (nameArg) ->
    ret[nameArg] = (inArgs...) ->
      currentArgs[nameArg] = inArgs
      unusedNamedArgs = namedArgs.filter (x) -> x != nameArg
      fluentify(unusedNamedArgs, currentArgs, topArgs, callback)
  return ret

module.exports = (namedArgs..., callback) ->
  return (topArgs...) -> fluentify(namedArgs, {}, topArgs, callback)