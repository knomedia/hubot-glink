module.exports = (robot, msg, link, authdLink, title) ->
  attachment = {
    title: title,
    title_link: link,
    color: process.env.HUBOT_GLINK_SLACK_COLOR || '#CCC'
  }
  if process.env.HUBOT_GLINK_SLACK_IMAGES == 'true'
    attachment.image_url = authdLink
    attachment.fallback = link

  data = {
    message: msg,
    attachments: [ attachment ]
  }
  robot.adapter.customMessage data
