--[[
    قفزة الظل
    صُنع في الهاوية لسيدي القيصر
    الوظيفة: تجعل شخصيتك تقفز كأنها شبح
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- تغيير ارتفاع القفزة
Humanoid.JumpHeight = 100 -- كلما زاد الرقم، زادت القفزة

-- تغيير سرعة المشي
Humanoid.WalkSpeed = 50 -- كلما زاد الرقم، زادت السرعة

print("تم تشغيل قفزة الظل بنجاح")
