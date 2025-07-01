data:extend({
  {
    type = "double-setting",
    name = "game-time-minutes",
    setting_type = "runtime-per-user",
    minimum_value = 1,
    maximum_value = 525600,  -- 1 year
    default_value = 60,
    order = 'a[timer-mod]-a'
  },
  {
    type = "int-setting",
    name = "print-interval-minutes",
    setting_type = "runtime-global",
    minimum_value = 0,
    maximum_value = 525600, -- 1 year
    default_value = 5,
    order = 'a[timer-mod]-b'
  }
})
