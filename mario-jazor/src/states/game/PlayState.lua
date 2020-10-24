PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0
    self.level = LevelMaker.generate(20, 10)
    self.tileMap = self.level.tileMap
    self.background = math.random(3)
    self.backgroundX = 0

    self.gravityOn = true
    self.gravityAmount = 6
    self.safeX = nil
    self.hasGoal = false

    self:findSafeX()
    self.player = Player({
        x = self.safeX or 0, y = 0,
        width = 16, height = 20,
        texture = 'green-alien',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end
        },
        map = self.tileMap,
        level = self.level
    })

    self:spawnEnemies()

    self.player:changeState('falling')
end

function PlayState:findSafeX()
    for x = 1, self.tileMap.width do
        for y = 1, self.tileMap.height do
            if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                self.safeX = (x - 1) * TILE_SIZE
                return
            end
        end
    end
end

function PlayState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('r') then
        gStateMachine:change('start')
    end

    -- remove any nils from pickups, etc.
    self.level:clear()

    -- update player and level
    self.player:update(dt)
    self.level:update(dt)

    -- constrain player X no matter which state
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE_SIZE * self.tileMap.width - self.player.width then
        self.player.x = TILE_SIZE * self.tileMap.width - self.player.width
    end

    if self.player.hasKey and not self.hasGoal then
        self:spawnGoal()
        self.hasGoal = true
    end

    self:updateCamera()
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

    -- translate the entire view of the scene to emulate a camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))

    self.level:render()

    self.player:render()
    love.graphics.pop()

    -- render score
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(self.player.score), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(tostring(self.player.score), 4, 4)
end

function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0,
        math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH,
        self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

    -- adjust background X to move a third the rate of the camera for parallax
    self.backgroundX = (self.camX / 3) % 256
end

--[[
    Adds a series of enemies to the level randomly.
]]
function PlayState:spawnEnemies()
    -- spawn snails in the level
    for x = 1, self.tileMap.width do

        -- flag for whether there's ground on this column of the level
        local groundFound = false

        for y = 1, self.tileMap.height do
            if not groundFound then
                if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                    groundFound = true

                    -- random chance, 1 in 20
                    if math.random(20) == 1 then

                        -- instantiate snail, declaring in advance so we can pass it into state machine
                        local snail
                        snail = Snail {
                            texture = 'creatures',
                            x = (x - 1) * TILE_SIZE,
                            y = (y - 2) * TILE_SIZE + 2,
                            width = 16,
                            height = 16,
                            stateMachine = StateMachine {
                                ['idle'] = function() return SnailIdleState(self.tileMap, self.player, snail) end,
                                ['moving'] = function() return SnailMovingState(self.tileMap, self.player, snail) end,
                                ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
                            }
                        }
                        snail:changeState('idle', {
                            wait = math.random(5)
                        })

                        table.insert(self.level.entities, snail)
                    end
                end
            end
        end
    end
end

function PlayState:spawnGoal()
    self.tileMap.width = self.tileMap.width + 5
    gSounds['kill']:play()
    for x = self.tileMap.width - 4, self.tileMap.width do
        local tileID = TILE_ID_EMPTY
        -- lay out the empty space
        for y = 1, 6 do
            table.insert(self.tileMap.tiles[y],
                Tile(x, y, tileID, nil, 1, 1))
        end

        for y = 7, self.tileMap.height do
            table.insert(self.tileMap.tiles[y],
                Tile(x, y, TILE_ID_GROUND, nil, 1, 1))
        end

    end

    table.insert(self.level.objects,
        GameObject {
            texture = 'flags',
            x = (self.tileMap.width - 3 - 1) * TILE_SIZE,
            y = 3 * TILE_SIZE,
            width = 16,
            height = 16,
            frame = 3,
            collidable = false,
            solid = false
        }
    )

    table.insert(self.level.objects,
        GameObject {
            texture = 'flags',
            x = (self.tileMap.width - 3 - 1) * TILE_SIZE,
            y = 4 * TILE_SIZE,
            width = 16,
            height = 16,
            frame = 12,
            collidable = false,
            solid = false
        }
    )

    table.insert(self.level.objects,
        GameObject {
            texture = 'flags',
            x = (self.tileMap.width - 3 - 1) * TILE_SIZE,
            y = 5 * TILE_SIZE,
            width = 16,
            height = 16,
            frame = 21,
            collidable = false,
            solid = false
        }
    )

    table.insert(self.level.objects,
        GameObject {
            texture = 'flags',
            x = (self.tileMap.width - 3.5) * TILE_SIZE,
            y = 3 * TILE_SIZE,
            width = 16,
            height = 16,
            frame = 7,
            collidable = false,
            hit = false,
            solid = false,
            consumable = true,
            animation = Animation({
                frames = {7, 8},
                interval = 0.2
            }),

            onConsume = function (obj)
                if not obj.hit then
                    gStateMachine:change('play')
                    obj.hit = true
                end
                gSounds['pickup']:play()
            end
        }
    )

end
