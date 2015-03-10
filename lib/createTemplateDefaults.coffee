module.exports = (env) ->
  defaults = []
  if env.HUBOT_GLINK_TEMPLATE_DEFAULTS
    values = env.HUBOT_GLINK_TEMPLATE_DEFAULTS.split(', ')
    values.forEach (value) ->
      defaults.push value.trim()
  defaults
