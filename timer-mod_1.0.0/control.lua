script.on_init(function()
  global.ticker = 0
end)

script.on_event(defines.events.on_tick, function(event)
  global.ticker = global.ticker + 1
  seconds_passed = global.ticker / 60
  minutes_passed = seconds_passed / 60

  if math.floor(seconds_passed) % (5 * 60) == 0 then
    game.print(string.format("time passed: %s", minutes_to_str(minutes_passed)))
  end
  if minutes_passed == global.time_to_play then
  	game.print("END THE GAME!!!")
  	-- end_menu(minutes_passed)
  end
end)

script.on_event(defines.events.on_player_joined_game, function(event)
  global.ticker = 0
  global.time_to_play = settings.get_player_settings(event.player_index)["game-time-minutes"].value

  if global.time_to_play ~= nil then
  	game.print(string.format("time allowed: %s", minutes_to_str(global.time_to_play)))
  end
end)

-- function end_menu(minutes_passed)
--   hours_passed = math.floor(minutes_passed / 60)
--   minutes_passed = minutes_passed % 60
--   txet = string.format("Time played: %d:%d\nyou have played enough and it is time to rest.", hours_passed, minutes_passed)
--   point_to = {type="nowhere"}
  -- style = idk what style but it has to be type speech bubble
  -- wrapper_frame_style = idk what style but it has to be type speech bubble

function minutes_to_str(m)
  minutes = m % 60
  hours = math.floor(m / 60)

  return string.format("%2dh:%2dm", hours, minutes)
end