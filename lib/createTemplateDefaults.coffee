getEnvName = (app) ->
  'HUBOT_GLINK_' + app + '_TEMPLATE_DEFAULTS'

module.exports = (env, app) ->
  env_name = getEnvName(app)
  defaults = []
  if env[env_name]
    values = env[env_name].split(', ')
    values.forEach (value) ->
      defaults.push value.trim()
  defaults
