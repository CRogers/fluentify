fluentify = (args..., callback) ->
  if args.length == 0
    return (topArgs...) -> callback(topArgs..., {})
  else
    name = args[0]
    return (topArgs...) ->
      ret = {}
      ret[name] = (inArgs...) ->
        blah = {}
        blah[name] = inArgs
        callback(topArgs..., blah)
      return ret

module.exports = fluentify