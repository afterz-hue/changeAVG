local a=function()return getgenv().HORST_AVG_CHANG_INITED end
if a()then return end
getgenv().HORST_AVG_CHANG_INITED=true;local b={IceQueen=true,Boxes=true,BoxAmount=6000000,Reroll=false,RerollMin=200,CheckEvery=5,CheckLevel=false,MinLevel=50}
local c=getgenv().AutoChangeConfig or{}
local d={}
for e,f in pairs(b)do d[e]=c[e]~=nil and c[e] or f end
getgenv().AutoChangeConfig=d;repeat task.wait(0.1)until game:IsLoaded()and _G.Horst_AccountChangeDone
local g=10;task.wait(g)
print("[AUTO CHANGE] ⏳ Waiting for Ice Queen detection...")
local h=game:GetService("Players")
local i=h.LocalPlayer
local j=function()return getgenv().IceQueenCached==true end
local k=function()return i:GetAttribute("TraitRerolls")or 0 end
local l=function()local m=i:GetAttribute("Level")or 0;return tonumber(m)or 0 end
local function n()if d.IceQueen and not j()then return false end;if d.Boxes then local o=i:GetAttribute("Presents26")or 0;if o<d.BoxAmount then return false end end;if d.Reroll then local p=k()if p<d.RerollMin then return false end end;if d.CheckLevel then local q=l()if q<d.MinLevel then return false end end;return true end
local r=function()task.wait(0.2)return n()end;while task.wait(d.CheckEvery)do if n()and r()then print("[AUTO CHANGE] 🎉 Condition passed!");print("[AUTO CHANGE] 🔁 เปลี่ยนไอดี...");warn("🔁 Horst AVG: Condition passed → เปลี่ยนไอดี");task.wait(1)_G.Horst_AccountChangeDone()break end end
print("[AUTO CHANGE] ✅ Switch account done!")
