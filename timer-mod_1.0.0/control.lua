-- global game init
script.on_init(function()
  global.ticker = 0
end)

-- player-enter-game init
script.on_event(defines.events.on_player_joined_game, function(event)
  global.ticker = 0
  global.setting__time_to_play_minutes = settings.get_player_settings(event.player_index)["game-time-minutes"].value
  global.setting__print_interval_minutes = settings.global["print-interval-minutes"].value

  maybe_print_init_message(global.setting__time_to_play_minutes)
end)

-- time-counting
script.on_event(defines.events.on_tick, function(event)
  global.ticker = global.ticker + 1

  seconds_passed = global.ticker / 60
  minutes_passed = seconds_passed / 60

  maybe_print_time_passed(seconds_passed, minutes_passed, global.setting__print_interval_minutes)
  maybe_print_end_game(seconds_passed, minutes_passed, global.setting__time_to_play_minutes)
end)

--
-- Utils
--

-- function end_menu(minutes_passed)
--   hours_passed = math.floor(minutes_passed / 60)
--   minutes_passed = minutes_passed % 60
--   txet = string.format("Time played: %d:%d\nyou have played enough and it is time to rest.", hours_passed, minutes_passed)
--   point_to = {type="nowhere"}
  -- style = idk what style but it has to be type speech bubble
  -- wrapper_frame_style = idk what style but it has to be type speech bubble

function maybe_print_init_message(time_to_play_minutes)
  if time_to_play_minutes ~= nil then
    game.print(string.format("Welcome! Time allowed: %s. Have fun!", minutes_to_str(time_to_play_minutes)))
  else
    -- todo: add `skip_empty_time_limit_message`. If true: skip this print
    game.print("Welcome! No game time limit set. Have fun!")
  end
end

function maybe_print_time_passed(seconds_passed, minutes_passed, interval_minutes)
  if math.floor(seconds_passed) % (interval_minutes * 60) == 0 then
    game.print(string.format("time passed: %s", minutes_to_str(minutes_passed)))
  end
end

function maybe_print_end_game(seconds_passed, minutes_passed, time_to_play_minutes)
  if minutes_passed == time_to_play_minutes then
    game.print("END THE GAME!!!")
    -- end_menu(minutes_passed)
  end
end

function minutes_to_str(m)
  minutes = m % 60
  hours = math.floor(m / 60)

  return string.format("%2dh:%2dm", hours, minutes)
end
