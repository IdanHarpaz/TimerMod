--
-- Utils
--

local function minutes_to_str(m)
  local minutes = m % 60
  local hours = math.floor(m / 60)

  return string.format("%2dh:%2dm", hours, minutes)
end

local function save()
  game.print("Saving game")
  game.auto_save()
  game.print("Saving game finished successfully")
end

local function pause_game()
  save()

  game.print("Pausing game")
  game.tick_paused = true
  -- storage.is_paused = true
  game.print("Done pausing game")
end

-- local function resume_game()
--   game.print("Resuming game")

--   game.tick_paused = false
--   -- storage.is_paused = false
-- end

local function maybe_print_init_message()
  local time_to_play_minutes = settings.global["game-time-minutes"].value

  if time_to_play_minutes ~= nil then
    game.print(string.format("Welcome! Time allowed: %s. Have fun!", minutes_to_str(time_to_play_minutes)))
  else
    -- todo: add `skip_empty_time_limit_message`. If true: skip this print
    game.print("Welcome! No game time limit set. Have fun!")
  end
end

local function maybe_print_time_passed(total_seconds_passed, total_minutes_passed, game_tick)
  local interval_minutes = settings.global["print-interval-minutes"].value

  if math.floor(total_seconds_passed) % (interval_minutes * 60) == 0 then
    game.print(string.format("time passed: %s (game tick: %d)", minutes_to_str(total_minutes_passed), game_tick))
  end
end

local function maybe_print_end_game(total_minutes_passed)
  local time_to_play_minutes = settings.global["game-time-minutes"].value

  if total_minutes_passed == time_to_play_minutes then
    local hours_passed = math.floor(total_minutes_passed / 60)
    local minutes_passed = total_minutes_passed % 60
    game.print(string.format("Time played: %d:%d\nyou have played enough and it is time to rest.", hours_passed, minutes_passed))

    game.print("END THE GAME!!!")

    pause_game()
  end
end

--
-- Hooks
--

-- global game init
script.on_init(function()
  global.ticker = 0
end)

-- player-enter-game init
script.on_event(defines.events.on_player_joined_game, function(event)
  global.ticker = 0
  maybe_print_init_message()
end)

-- time-counting
script.on_event(defines.events.on_tick, function(event)
  global.ticker = global.ticker + 1

  local total_seconds_passed = global.ticker / 60
  local total_minutes_passed = total_seconds_passed / 60

  maybe_print_time_passed(total_seconds_passed, total_minutes_passed, event.tick)
  maybe_print_end_game(total_minutes_passed)
end)
