# Description:
#   DM someone with a text
#
# Dependencies:
#   twilio
#
# Configuration:
#   Set all env variables and the usermap from username to phone#
#
# Commands:
#   @user hey this is important!!1one
#
# Author:
#   Marco


# Twilio Credentials
accountSid = process.env.TWILIO_SID
authToken = process.env.TWILIO_TOKEN
userMap = JSON.parse(process.env.HUBOT_TWILIO_USERMAP)
fromNumber = process.env.TWILIO_FROM

# require the Twilio module and create a REST client
client = require('twilio')(accountSid, authToken);

module.exports = (robot) ->
  robot.hear /@(\w+)\s+(.*)/i, (msg)->
    user = msg.match[1].toLowerCase()
    from = msg.envelope.user.name
    body = from + ": " + msg.match[2]

    if (userMap[user])
      client.messages.create {to: userMap[user], body:body, from: fromNumber}, (err, res) ->
        msg.send (if err? ("Error: " + err) else "Sent!")
