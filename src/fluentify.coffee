fluentify = (args..., callback) ->
  if args.length == 0
    return callback
  else
    name = args[0]
    return (topArg) ->
      ret = {}
      ret[name] = (inArg) ->
        blah = {}
        blah[name] = [inArg]
        callback(topArg, blah)
      return ret

module.exports = fluentify