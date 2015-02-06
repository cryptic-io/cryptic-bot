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
serverHost = process.env.HUBOT_PROXY_HOST

module.exports = (robot) ->
  robot.respond /(insert)\s+(.*)/i, (msg)->
    imgUrl = msg.match[2]

    msg.http("http://#{serverHost}:#{serverPort}/proxy")
      .query(imgUrl: imgUrl)
      .get() (err, res, body) ->
        switch res.statusCode
          when 200 then msg.send body
          when 302 then msg.send "Debug: Redirecting"
          else
            msg.send "Unable to proxy url. Request returned with the status code: #{res.statusCode}"
