# Description:
#   Wombo Combo
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   wombo combo
#   happy feet
#   that aint falco
#
# Author:
#   Marco

wombocombo = "https://www.youtube.com/watch?v=pD_imYhNoQ4"

module.exports = (robot) ->
  robot.hear /wombo combo.*/i, (msg)->
    msg.send "that aint falco- #{wombocombo}"

  robot.hear /happy feet.*/i, (msg)->
    msg.send "wombo combo - #{wombocombo}"

  robot.hear /that aint falco.*/i, (msg)->
    msg.send "wombo combo - #{wombocombo}"
    j
  robot.hear /dat aint falco.*/i, (msg)->
    msg.send "wombo combo - #{wombocombo}"
