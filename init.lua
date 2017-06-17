--------------------------------------------------------------------------------
-- Copyright (c) 2016 tacigar. All rights reserved.
-- https://github.com/tacigar/torch_plus
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>
--------------------------------------------------------------------------------

local function add_particlespawner(minpos, maxpos)
	minetest.add_particlespawner{
		time = 2.5;
		minpos = minpos;
		maxpos = maxpos;
		minvel = {x = 0.0, y = 0.5, z = 0.0};
		maxvel = {x = 0.0, y = 1.0, z = 0.0};
		minacc = {x = 0.0, y = 0.1, z = 0.0};
		maxacc = {x = 0.0, y = 0.2, z = 0.0};
		minexptime = 1.0;
		maxexptime = 1.0;
		minsize = 1.5;
		maxsize = 3.0;
		texture = "torch_smoke_torch_smoke.png";

		animation = {
			type = "vertical_frames";
			aspect_w = 16;
			aspect_h = 16;
			length = 1.05;
		};
	}
end

for i = 1, 3 do
	minetest.register_abm{
		label = 'torch smoke',
		nodenames = {'default:torch', 'default:torch_ceiling'},
		interval = 1,
		chance = 1,

		action = function(pos, node)
			local minpos, maxpos = 0, 0
			if node.name == 'default:torch' then
				minpos = vector.add(pos, vector.new(-0.1, 0.05, -0.1))
				maxpos = vector.add(pos, vector.new(0.1, 0.1, 0.1))
			else -- 'default:torch_ceiling'
				minpos = vector.add(pos, vector.new(-0.1, -0.1, -0.1))
				maxpos = vector.add(pos, vector.new(0.1, -0.05, 0.1))
			end
			add_particlespawner(minpos, maxpos)
		end,
	}
end

for i = 1, 3 do
	minetest.register_abm{
		label = 'torch wall smoke',
		nodenames = {'default:torch_wall'},
		interval = 1,
		chance = 1,

		action = function(pos, node)
			local minpos, maxpos = 0, 0
			local facedir = node.param2 % 4

			if facedir == 0 then
				minpos = vector.add(pos, vector.new(-0.1, 0.05, 0.2))
				maxpos = vector.add(pos, vector.new(0.1, 0.1, 0.3))
			elseif facedir == 1 then
				minpos = vector.add(pos, vector.new(-0.1, 0.05, -0.2))
				maxpos = vector.add(pos, vector.new(0.1, 0.1, -0.3))
			elseif facedir == 2 then
				minpos = vector.add(pos, vector.new(0.2, 0.05, -0.1))
				maxpos = vector.add(pos, vector.new(0.3, 0.1, 0.1))
			elseif facedir == 3 then
				minpos = vector.add(pos, vector.new(-0.2, 0.05, -0.1))
				maxpos = vector.add(pos, vector.new(-0.3, 0.1, 0.1))
			end
			add_particlespawner(minpos, maxpos)
		end,
	}
end
