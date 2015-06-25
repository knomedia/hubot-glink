createDefaultParams = require('./createDefaultParams')
createTemplateDefaults = require('./createTemplateDefaults')


getTemplateName = (app) ->
  'HUBOT_GLINK_' + app + '_TEMPLATE'


module.exports = (env, app) ->
  app = app.toUpperCase()
  templateName = getTemplateName(app)
  config =
    hostname: env.HUBOT_GLINK_HOSTNAME || 'graphite.example.com',
    template: env[templateName] || 'template.not.set',
    templateDefaults: createTemplateDefaults(env, app),
    paramsDefaults: createDefaultParams(env)
  config.port = env.HUBOT_GLINK_PORT if env.HUBOT_GLINK_PORT
  config.protocol = env.HUBOT_GLINK_PROTOCOL if env.HUBOT_GLINK_PROTOCOL
  config.templateDefaultDelimiter = env.HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER if env.HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER
  config.absoluteTimes = env.HUBOT_GLINK_ABSOLUTE_TIMES || false

  authdConfig = JSON.parse(JSON.stringify(config))
  if env.HUBOT_GLINK_CREDS
    creds = env.HUBOT_GLINK_CREDS + '@'
    authdConfig.hostname = creds + authdConfig.hostname

  {
    config: config,
    authdConfig: authdConfig
  }
