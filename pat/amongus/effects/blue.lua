require "/scripts/util.lua"
require "/scripts/vec2.lua"

function init()
  animator.playSound("transform")
  
  poly = effect.getParameter("poly", {})
  movementParams = effect.getParameter("movementParams", {})
  movementParams.standingPoly = poly
  movementParams.crouchingPoly = poly
  
  effect.modifyDuration(math.huge)
  
  effect.setParentDirectives("?multiply=00000000")
  animator.setAnimationState("amongus", "on")
  animator.resetTransformationGroup("amongus")
  animator.scaleTransformationGroup("amongus", 0.1)
  
  angle = 0
end

function update(dt)
  animator.resetTransformationGroup("amongus")
  animator.scaleTransformationGroup("amongus", 0.1)
  
  local velocity = mcontroller.xVelocity()
  local direction = lastDir or 1
  if velocity > 0 then
    direction = 1
  elseif velocity < 0 then
    direction = -1
  end
  
  local positionDiff = world.distance(lastPosition or mcontroller.position(), mcontroller.position())
  angularVelocity = -vec2.mag(positionDiff) / dt * direction
  angle = math.fmod(math.pi * 2 + angle + angularVelocity * dt, math.pi * 2)
  
  animator.rotateTransformationGroup("amongus", angle)
  mcontroller.setRotation(angle)
  
  mcontroller.controlParameters(movementParams)
  
  lastPosition = mcontroller.position()
  lastDir = direction
end

function uninit()
  mcontroller.setRotation(0)
end