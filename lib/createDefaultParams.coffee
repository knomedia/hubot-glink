module.exports = (env) ->
  paramsString = env.HUBOT_GLINK_DEFAULT_PARAMS
  params = {}
  if paramsString
    all = paramsString.split(', ')
    all.forEach (pair) ->
      parts = pair.split(':')
      params[parts[0].trim()] = parts[1].trim()
  params
