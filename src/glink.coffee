# Description:
#   Build graphite links to get instrumentation via hubot
#
# Dependencies:
#   "glink": "0.0.11"
#
# Commands:
#   hubot graphme <query> - Builds a graphite link based on applying <query> to  your config
#   hubot teachme - attempt to teach how to use based on config
#   hubut alias <name> as <query> - builds an alias for easy usage later
#   hubot alias <name> - display an alias
#   hubot run <alias> - run a graphme query using the given alias
#   hubot unalias <name> - remove an alias
#   hubot remove alias <name> - remove an alias
#   hubot aliases - list known aliases
#
# Configuration:
#   HUBOT_GLINK_TEMPLATE (i.e stats.timers.!!#controller#!!.!!#action#!!)
#   HUBOT_GLINK_TEMPLATE_DEFAULTS (comma delimited i.e.: !!#controller===users#!!, #!!action===index#!!)
#   HUBOT_GLINK_HOSTNAME
#   HUBOT_GLINK_DEFAULT_PARAMS [optional] (comma delimited i.e.: from:-1week, width:800)
#   HUBOT_GLINK_PROTOCOL [optional]
#   HUBOT_GLINK_PORT [optional]
#   HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER [optional] (defaults to ===)
#   see https://github.com/knomedia/glink for more info on configs

glink = require('glink')
configurator = require('../lib/configurator')
contextHelp = require('../lib/contextHelp')
Namespacer = require('../lib/namespacer')


module.exports = (robot) ->

  ns = new Namespacer('_glink_key_')

  robot.respond /teachme/, (msg) ->
    config = configurator(process.env)
    msg.reply contextHelp.buildHelp(config)

  robot.respond /graphme (.*)/, (msg) ->
    config = configurator(process.env)
    args = msg.match[1].split(' ')
    link = glink(config, args) + '&image=.png'
    msg.reply link

  robot.respond /run (.*)/, (msg) ->
    friendlyName = msg.match[1].trim()
    alias = ns.prepend(friendlyName)
    aliasValue = robot.brain.get(alias)
    if !!aliasValue
      config = configurator(process.env)
      args = aliasValue.split(' ')
      link = glink(config, args) + '&image=.png'
      msg.reply link
    else
      msg.reply ':bomb: no `' + friendlyName + '` alias found'

  robot.respond /alias (.*) as (.*)/, (msg) ->
    friendlyName = msg.match[1].trim()
    alias = ns.prepend(friendlyName)
    args = msg.match[2]
    robot.brain.set(alias, args)
    robot.brain.save()
    message = 'created alias `' + friendlyName + '` for `' + args + '`'
    msg.reply message

  robot.respond /alias (([\w|\-])*)$/, (msg) ->
    friendlyName = msg.match[1].trim()
    alias = ns.prepend(friendlyName)
    value = robot.brain.get(alias)
    if !!value
      msg.reply '`' + friendlyName + '` = `' + value + '`'
    else
      msg.reply 'no `' + friendlyName + '` found'

  robot.respond /(?:remove alias|unalias) (.*)/, (msg) ->
    friendlyName = msg.match[1].trim()
    alias = ns.prepend(friendlyName)
    if !!robot.brain.get(alias)
      robot.brain.remove(alias)
      robot.brain.save()
      msg.reply ':thumbsup: `' + friendlyName + '` removed'
    else
      msg.reply ':thumbsdown: no ' + friendlyName + ' alias found'

  robot.respond /aliases/, (msg) ->
    output = 'Aliases:\n\n'
    # this is bad, I should feel bad, not sure how else to iterate over keys set in the brain
    data = robot.brain.data._private
    Object.keys(data).forEach (key) ->
      if ns.inNS(key)
        output += '`' + ns.clear(key) + '` = `' + data[key] + '`\n'
    msg.reply output
