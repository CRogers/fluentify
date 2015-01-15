fluentify = (namedArgs, currentArgs, topArgs, callback) ->
  if namedArgs.length == 0
    return callback(topArgs..., currentArgs)

  ret = {}
  namedArgs.forEach (nameArg) ->
    ret[nameArg] = (inArgs...) ->
      currentArgs[nameArg] = inArgs
      callback(topArgs..., currentArgs) if namedArgs.length == 1
  return ret

module.exports = (namedArgs..., callback) ->
  return (topArgs...) -> fluentify(namedArgs, {}, topArgs, callback)