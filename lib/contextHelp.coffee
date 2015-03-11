diff = require 'diff'

getDescriptions =  (config) ->
  templateKey = ''
  templateVariables = []
  templateDefaults = []
  paramsDefaults = []
  buildKeys(config, templateVariables, templateDefaults)
  templateKey = buildTemplateKey(templateVariables)
  templateVariables = stripTemplateKey(templateKey, templateVariables)
  paramsDefaults = buildParamsDefaults(config)

  return {
    templateKey: templateKey
    templateVariables: templateVariables
    templateDefaults: templateDefaults
    paramsDefaults: paramsDefaults
  }

buildHelp = (config) ->
  desc = getDescriptions(config)
  output = 'Here goes \n\n'
  output += '```'
  output += buildArgsExample(desc)
  output += "\n\n\n"
  output += buildParamsHelp(desc)
  output += "\n\n\n"
  output += buildDefaultsExample(desc)
  output += '```'
  output

buildArgsExample = (desc) ->
  example = ['graphme']
  desc.templateVariables.forEach (vr) ->
    example.push('[' + vr + ']')
  output = "ARGS: \n"
  output += '=====\n'
  output += "`graphme` me can take args, as currently configured it looks like:\n\n"
  output += '`' + example.join(' ') + '`'
  output

buildParamsHelp = (desc) ->
  output = 'PARAMS:\n'
  output += '=======\n'
  output += 'You can optionally append any params (see http://graphite.readthedocs.org/en/latest/render_api.html for params you can use) in the form of `--name=value` to the end of your command. '
  output += 'The following params are currently configured as defaults, passing in a flag with the same name, but of a different value, will override the default ofc\n\n'
  output += '`' + desc.paramsDefaults.join(' ') + '`'


buildDefaultsExample = (desc) ->
  example = ['graphme']
  desc.templateDefaults.forEach (vr) ->
    example.push(vr)
  output = 'DEFAULTS: \n'
  output += '=========\n'
  output += 'Without any args the defaults are used, as currently configured `graphme` defaults to:\n\n'
  output += '`' + example.join(' ') + ' ' + desc.paramsDefaults.join(' ') + '`'
  output

buildParams = (desc) ->


buildKeys = (config, templateVariables, templateDefaults) ->
  config.templateDefaults.forEach (def) ->
    parts = def.split(config.templateDefaultDelimiter || '===')
    templateVariables.push parts[0]
    templateDefaults.push parts[1]

# TODO: ASSuming we have more than one variable
buildTemplateKey = (variables) ->
  changes = diff.diffChars(variables[0], variables[1])
  # first section of unchanged should always be the key
  changes[0].value

stripTemplateKey = (key, variables) ->
  endKey = key.split('').reverse().join('')
  clean = []
  variables.forEach (v) ->
    stripped = v.replace(key, '')
    stripped = stripped.replace(endKey, '')
    clean.push stripped
  clean

buildParamsDefaults = (config) ->
  defaults = []
  Object.keys(config.paramsDefaults).forEach (key) ->
    flag = '--' + key + '=' + config.paramsDefaults[key]
    defaults.push flag
  defaults

module.exports = {
    getDescriptions: getDescriptions
    buildHelp: buildHelp
  }

