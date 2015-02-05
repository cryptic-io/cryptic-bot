# Description:
#   Proxy an image through a local server
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot insert <img> - proxy an image through a server, paste the proxied link
#
# Author:
#   Marco

serverPort = 8123

module.exports = (robot) ->
  robot.respond /(insert)\s+(.*)/i, (msg)->
    imgUrl = msg.match[2]

    msg.http("http://localhost:#{serverPort}/proxy")
      .query(imgUrl: imgUrl)
      .get() (err, res, body) ->
        switch res.statusCode
          when 200 then msg.reply body
          when 302 then msg.reply "Debug: Redirecting"
          else
            msg.reply "Unable to proxy url. Request returned with the status code: #{res.statusCode}"
