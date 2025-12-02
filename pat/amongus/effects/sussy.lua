function init()
  local variants = effect.getParameter("variants", 1)
  animator.setPartTag("amongus", "color", math.random(variants) - 1)
  animator.playSound("transform")
  
  local movementParams = effect.getParameter("movementParams", {})
  local poly = effect.getParameter("poly")
  movementParams.standingPoly = poly
  movementParams.crouchingPoly = poly
  
  mcontroller.setAutoClearControls(false)
  mcontroller.controlParameters(movementParams)
  
  effect.modifyDuration(math.huge)
  effect.setParentDirectives("?multiply=0000")
  
  position = mcontroller.position()
  direction = mcontroller.facingDirection()
  
  scale = effect.getParameter("scale", 0.1)
  updateTransforms()
end

function update()
  local newPos = mcontroller.position()

  local vel = mcontroller.xVelocity()
  if vel ~= 0 then direction = vel > 0 and 1 or -1 end

  local mag = world.magnitude(position, newPos)
  mcontroller.setRotation(mcontroller.rotation() - mag * direction)
  position = newPos

  updateTransforms()
end

function uninit()
  mcontroller.setRotation(0)
end

function updateTransforms()
  animator.resetTransformationGroup("amongus")
  animator.scaleTransformationGroup("amongus", scale)
  animator.rotateTransformationGroup("amongus", mcontroller.rotation())
end
