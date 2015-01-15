fluentify = (args..., callback) ->
  if args.length == 0
    return (topArgs...) -> callback(topArgs..., {})
  else
    name = args[0]
    return (topArg) ->
      ret = {}
      ret[name] = (inArgs...) ->
        blah = {}
        blah[name] = inArgs
        callback(topArg, blah)
      return ret

module.exports = fluentify