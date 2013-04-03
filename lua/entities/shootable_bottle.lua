--[[
	Copyright (C) 2013 Lex Robinson
    This code is freely available under the MIT License. See the LICENSE file for more information.
--]]
AddCSLuaFile();
ENT.Type			= "anim";
-- ENT.Base			= "base_shootable";
DEFINE_BASECLASS("base_shootable");

ENT.PrintName		= "Shootable Bottle";
ENT.Author			= "Lex Robinson";
ENT.Contact			= "lexi@lexi.org.uk";
ENT.Category		= "Fun + Games";

ENT.Spawnable		= true;

ENT.Value 			= 10;

if (CLIENT) then
	return
end

local models = {
	"models/props_junk/garbage_glassbottle001a.mdl",
	"models/props_junk/garbage_glassbottle001a.mdl",
	"models/props_junk/garbage_glassbottle003a.mdl",
	"models/props_junk/garbage_glassbottle003a.mdl",
	"models/props_junk/garbage_glassbottle003a.mdl",
	"models/props_junk/garbage_glassbottle003a.mdl",
	"models/props_junk/GlassBottle01a.mdl",
	"models/props_junk/GlassBottle01a.mdl",
	"models/props_junk/GlassBottle01a.mdl",
	"models/props_junk/glassjug01.mdl",
}
local values = {
	["models/props_junk/garbage_glassbottle001a.mdl"] = 11,
	["models/props_junk/garbage_glassbottle003a.mdl"] = 10,
	["models/props_junk/GlassBottle01a.mdl"] = 9,
	["models/props_junk/glassjug01.mdl"] = 15,
}
function ENT:Initialize()
	-- self:SetModel(');
	local model = models[math.random(1, #models)]
	self:SetModel(model);
	self.Value = values[model] or 10;
	BaseClass.Initialize(self);
end
