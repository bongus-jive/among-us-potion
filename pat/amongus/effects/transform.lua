function init()
  transformEffect = effect.getParameter("transform")
  status.removeEphemeralEffect(transformEffect)
  
  startDuration = effect.duration()
end

function update()
  local r = math.min(1, math.max(0, effect.duration() / startDuration))
  local h = string.format("%02x", math.floor(r * 155 + 100))
  effect.setParentDirectives(string.format("?multiply=FF%s%s", h, h))
end

function uninit()
  status.addEphemeralEffect(transformEffect)
end
