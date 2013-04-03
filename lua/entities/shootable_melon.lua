--[[
	Copyright (C) 2013 Lex Robinson
    This code is freely available under the MIT License. See the LICENSE file for more information.
--]]
AddCSLuaFile();
ENT.Type			= "anim";
-- ENT.Base			= "base_shootable";
DEFINE_BASECLASS("base_shootable");

ENT.PrintName		= "Shootable Melon";
ENT.Author			= "Lex Robinson";
ENT.Contact			= "lexi@lexi.org.uk";
ENT.Category		= "Fun + Games";

ENT.Spawnable		= true;

ENT.Value 			= 5;

if (CLIENT) then
	return
end

function ENT:Initialize()
	self:SetModel('models/props_junk/watermelon01.mdl');
	BaseClass.Initialize(self);
end
