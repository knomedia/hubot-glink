module.exports = (env, args) ->
  app = env.HUBOT_GLINK_DEFAULT_APP || ''
  args.forEach (arg) ->
    if arg.match(/--app=/)
      app = arg.split('=')[1]
  app.toUpperCase()
