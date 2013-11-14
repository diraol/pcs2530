require 'dungeon.entity'
require 'base.message'
require 'base.vec2'
require 'dungeon.builder.util'

return function(args)
  
  local pandarila = dungeon.entity:new {
    image = love.graphics.newImage 'resources/entities/pandarila.png',
    scale = 1.2,
    p_attack_ratio = 0.9, --attack probability
    p_attack_distance = 2, -- distance pandarila can attack
    damage = 5,
    p_act = .2,
  }

  --pandarila.weapon

  function pandarila:playturn()
    if math.random() < self.p_act then return end

    local wtd = math.random() -- What to do?

    if wtd < self.p_attack_ratio then
      if hero_distance(self.position, self.p_attack_distance) then
        local local_scene = message.send [[main]] {'current_scene'}
        hero_pos = local_scene.state.hero.position
        local target_tile = self.map:get_tile(hero_pos)
        if target_tile.entity then
          target_tile.entity:take_damage(self.damage)
        else
          return
        end
      else
        return
      end
    else
      --do move to somewhere!
      local next_pos = self.position:clone()
      next_post = next_pos + random_side()

      local next_tile = self.map:get_tile(next_pos)
      if next_tile and next_tile:available() then
        self.map:get_tile(self.position):remove_entity()
        self.map:get_tile(next_pos):add_entity(self)
        self.position = next_pos
      end
    end
    
  end

  return pandarila
end
