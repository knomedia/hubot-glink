createDefaultParams = require('./createDefaultParams')
createTemplateDefaults = require('./createTemplateDefaults')

module.exports = (env) ->
  config =
    hostname: env.HUBOT_GLINK_HOSTNAME || 'graphite.example.com',
    template: env.HUBOT_GLINK_TEMPLATE || 'template.not.set',
    templateDefaults: createTemplateDefaults(env)
    paramsDefaults: createDefaultParams(env)
  config.port = env.HUBOT_GLINK_PORT if env.HUBOT_GLINK_PORT
  config.protocol = env.HUBOT_GLINK_PROTOCOL if env.HUBOT_GLINK_PROTOCOL
  config.templateDefaultDelimiter = env.HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER if env.HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER

  if env.HUBOT_GLINK_CREDS
    creds = env.HUBOT_GLINK_CREDS + '@'
    authdConfig = JSON.parse(JSON.stringify(config))
    authdConfig.hostname = creds + authdConfig.hostname

  {
    config: config,
    authdConfig: authdConfig
  }
