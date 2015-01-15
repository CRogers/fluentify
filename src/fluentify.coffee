fluentify = (args..., callback) ->
  if args.length == 0
    return (topArgs...) -> callback(topArgs..., {})
  else
    return (topArgs...) ->
      ret = {}
      args.forEach (name) ->
        ret[name] = (inArgs...) ->
          blah = {}
          blah[name] = inArgs
          callback(topArgs..., blah) if args.length == 1
      return ret

module.exports = fluentify