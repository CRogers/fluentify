fluentify = (namedArgs..., callback) ->
  if namedArgs.length == 0
    return (topArgs...) -> callback(topArgs..., {})
  else
    return (topArgs...) ->
      ret = {}
      namedArgs.forEach (nameArg) ->
        ret[nameArg] = (inArgs...) ->
          blah = {}
          blah[nameArg] = inArgs
          callback(topArgs..., blah) if namedArgs.length == 1
      return ret

module.exports = fluentify