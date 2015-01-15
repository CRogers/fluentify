fluentify = (args..., callback) ->
  if args.length == 0
    return callback
  else
    ret = {}
    ret[args[0]] = callback
    return -> ret

module.exports = fluentify