function init()
	transform = effect.getParameter("transform")
	status.removeEphemeralEffect(transform)
	
	defaultDuration = config.getParameter("defaultDuration", 10)
end

function update(dt)
	world.debugText(defaultDuration, mcontroller.position(), "red")

	local hex = string.format("%02x", 127 + math.floor((effect.duration() / defaultDuration) * 128))
	effect.setParentDirectives("?multiply=FF"..hex..hex)
end

function uninit()
	status.addEphemeralEffect(transform)
end