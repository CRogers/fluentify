fluentify = (namedArgs, currentArgs, topArgs, callback) ->
  if namedArgs.length == 0
    return callback(topArgs..., currentArgs)
  else
    ret = {}
    namedArgs.forEach (nameArg) ->
      ret[nameArg] = (inArgs...) ->
        blah = {}
        blah[nameArg] = inArgs
        callback(topArgs..., blah) if namedArgs.length == 1
    return ret

module.exports = (namedArgs..., callback) ->
  return (topArgs...) -> fluentify(namedArgs, {}, topArgs, callback)