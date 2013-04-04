--[[
	Copyright (C) 2013 Lex Robinson
    This code is freely available under the MIT License. See the LICENSE file for more information.
--]]
AddCSLuaFile();
ENT.Type			= "anim";
ENT.Base			= "base_anim";

ENT.PrintName		= "Base Shootable";
ENT.Author			= "Lex Robinson";
ENT.Contact			= "lexi@lexi.org.uk";

-- ENT.Spawnable		= true;

ENT.Value 			= 10;

if (CLIENT) then
	return
end

function ENT:SpawnFunction(ply,  tr)
	if (not tr.Hit) then return end
	local ent = ents.Create(self.ClassName);
	ent:SetPos(tr.HitPos);
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
	-- self:SetModel('models/props_junk/garbage_glassbottle003a.mdl');
	-- self:SetModel("models/props_c17/canister02a.md");
	self:PrecacheGibs();
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	local phys = self:GetPhysicsObject();
    if (not phys:IsValid()) then
        local mdl = self:GetModel()
        self:Remove();
        error("Entity of type " .. self.ClassName .. " created without a physobj! (Model: " .. mdl .. ")");
    end
	phys:Wake();
end

function ENT:OnTakeDamage(dmginfo)
    self:GibBreakClient(dmginfo:GetDamageForce());
	local edata = EffectData();
	edata:SetOrigin(self:GetPos());
	-- edata:SetOrigin(dmginfo:GetDamagePosition());
	edata:SetScale(self.Value);
	util.Effect('shootable_score', edata);
    self:Remove();
end

