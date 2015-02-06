# Description:
#   Evaluate one line of Clojure script
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot clojure|clj <script> - Evaluate one line of Clojure script
#
# Author:
#   jingweno

ringSessionID = ''

module.exports = (robot) ->
  robot.hear /(\#clojure|\#clj)\s+(.*)/i, (msg)->
    script = msg.match[2]

    msg.http("http://www.tryclj.com/eval.json")
      .query(expr: script)
      .headers(Cookie: "ring-session=#{ringSessionID}")
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            if res.headers["set-cookie"]
              ringSessionID = res.headers["set-cookie"][0].match(/ring-session=([-a-z0-9]+);/)[1]
            result = JSON.parse(body)

            if result.error
              msg.send result.message
            else
              outputs = result.result.split("\n")
              for output in outputs
                msg.send output
          when 302 then msg.send "Debug: Redirecting"
          else
            msg.send "Unable to evaluate script: #{script}. Request returned with the status code: #{res.statusCode}"
