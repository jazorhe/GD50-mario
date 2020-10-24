GameObject = Class{}

function GameObject:init(def)
    self.x = def.x
    self.y = def.y
    self.texture = def.texture
    self.width = def.width
    self.height = def.height
    self.frame = def.frame
    self.solid = def.solid
    self.collidable = def.collidable
    self.consumable = def.consumable
    self.onCollide = def.onCollide
    self.onConsume = def.onConsume
    self.hit = def.hit
    self.inPlay = true
    self.animation = def.animation
end

function GameObject:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end

function GameObject:update(dt)

    if self.animation then
        self.animation:update(dt)
        self.frame = self.animation:getCurrentFrame()
    end

end

function GameObject:render()
    if self.inPlay then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x, self.y)
    end
end
