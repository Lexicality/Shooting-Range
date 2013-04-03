--[[
	Copyright (C) 2013 Lex Robinson
    This code is freely available under the MIT License. See the LICENSE file for more information.
--]]
AddCSLuaFile();
ENT.Type			= "anim";
ENT.Base			= "base_anim";

ENT.PrintName		= "Shooting Range";
ENT.Author			= "Lex Robinson";
ENT.Contact			= "lexi@lexi.org.uk";

ENT.Purpose			= "A respawning shooting Range";
ENT.Category		= "Fun + Games";

ENT.Spawnable		= true;


if (CLIENT) then
	return
end

function ENT:SpawnFunction(ply,  tr)
	if (not tr.Hit) then return end
	local ent = ents.Create(self.ClassName);
	ent:SetPos(tr.HitPos);
	ent:SetAngles(Angle(0, ply:EyeAngles().y + 180, 0));
	ent:Spawn();
	ent:Activate();
	-- Attempt to move the object so it sits flush
	local vFlushPoint = tr.HitPos - ( tr.HitNormal * 512 )	-- Find a point that is definitely out of the object in the direction of the floor
	vFlushPoint = ent:NearestPoint( vFlushPoint )	-- Find the nearest point inside the object to that point
	vFlushPoint = ent:GetPos() - vFlushPoint	-- Get the difference
	vFlushPoint = tr.HitPos + vFlushPoint	-- Add it to our target pos
	ent:SetPos(vFlushPoint);
	return ent;
end

function ENT:Initialize()
	self:SetModel("models/props/cs_militia/sawhorse.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	local phys = self:GetPhysicsObject();
    if (not phys:IsValid()) then
        local mdl = self:GetModel()
        self:Remove();
        error("Entity of type " .. self.ClassName .. " created without a physobj! (Model: " .. mdl .. ")");
    end
	phys:EnableMotion(false);
	self:Bottles();
end

function ENT:Use()
	self:Bottles();
end

function ENT:Bottle(pos)
	pos = self:LocalToWorld(pos);
	local ent = ents.Create('shootable_bottle');
	ent:SetPos(pos);
	ent:SetAngles(self:GetAngles());
	ent:Spawn();
	ent:Activate();
	local up = self:GetUp();
	local vFlushPoint = pos - ( self:GetUp() * 512 )	-- Find a point that is definitely out of the object in the direction of the floor
	vFlushPoint = ent:NearestPoint( vFlushPoint )	-- Find the nearest point inside the object to that point
	vFlushPoint = ent:GetPos() - vFlushPoint	-- Get the difference
	vFlushPoint = pos + vFlushPoint	-- Add it to our target pos
	vFlushPoint = vFlushPoint - up * 8;
	ent:SetPos(vFlushPoint)
	ent:GetPhysicsObject():EnableMotion(false);
	self:DeleteOnRemove(ent);
	return ent;
end

function ENT:Bottles()
	if (self._bottles) then
		for _, ent in pairs(self._bottles) do
			if (IsValid(ent)) then
				-- ent:GibBreakClient(vector_origin);
				ent:Remove();
			end
		end
	end
	self:GetPhysicsObject():EnableMotion(false);
	local bottles = {};
	local start = Vector(0, -29.37, 45.41);
	for i = -29.37, 30, 5.8 do
		start.y = i;
		table.insert(bottles, self:Bottle(start));
	end
	self._bottles = bottles;
end