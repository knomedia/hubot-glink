# Description:
#   Build graphite links to get instrumentation via hubot
#
# Dependencies:
#   "glink": "0.0.11"
#
# Commands:
#   hubot graphme <query> - Builds a graphite link based on applying <query> to  your config
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

module.exports = (robot) ->

  robot.respond /graphme (.*)/, (msg) ->
    config = configurator(process.env)
    args = msg.match[1].split(' ')
    link = glink(config, args) + '&image=.png'
    msg.reply link


createCanvasConfig = (params) ->
  params = params || {}
  {
    hostname: 'graphite.insops.net',
    template: 'stats.timers.canvas.prod.request.!!#controller#!!.!!#action#!!.!!#type#!!',
    templateDefaults: [
      "!!#controller#!!===files",
      "!!#action#!!===index",
      "!!#type#!!==={mean,median,upper_95}"
    ],
    paramsDefaults: params
  }

defaultParams = ->
  from: '-1week',
  width: '550',
  height: '450',
  bgcolor: 'black',
  fgcolor: 'grey',
  drawNullAsZero: 'true'
