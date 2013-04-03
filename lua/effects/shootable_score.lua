--[[
	Copyright (C) 2013 Lex Robinson
    This code is freely available under the MIT License. See the LICENSE file for more information.
--]]

function EFFECT:Init(edata)
	self.pos = edata:GetOrigin();
	self.amount = edata:GetScale();
	self.start  = CurTime();
	self.length = 3;
	self.finish = self.start + self.length;
	print("I'm an effect!");

	surface.SetFont("DermaLarge")
	local w, h = surface.GetTextSize(self.amount);
	self.x = -w / 2;
	self.y = -h;
end

function EFFECT:Think()
	self.pos = self.pos + vector_up * FrameTime() * 20;-- + self.ang:Forward() * 0.01 * math.sin(CurTime());
	return CurTime() < self.finish;
end

function EFFECT:Render()
	local ea = EyeAngles();
	local angle = Angle(90, ea.y - 180, 0);
	angle:RotateAroundAxis(angle:Up(), 90);
	self.ang = angle;
	cam.Start3D2D(self.pos, angle, 0.2);
		surface.SetTextColor(255, 255, 255, Lerp((self.finish - CurTime()) / self.length, 0, 255));
		surface.SetFont("DermaLarge")
		surface.SetTextPos(self.x, self.y);
		surface.DrawText(self.amount);
	cam.End3D2D();
end

print("I've been loaded!")