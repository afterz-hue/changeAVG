-- ================================================================
-- AVG AUTO CHANGE ACCOUNT (Horst) - ICE QUEEN DETECTION + LEVEL CHECK
-- (DELAYED + SAFE)
-- ================================================================

-- รอ Horst พร้อม
repeat task.wait(0.1) until game:IsLoaded() and _G.Horst_AccountChangeDone

-- หน่วงเวลาเพิ่ม ให้ระบบ/สคริปต์อื่นตั้งค่า HasEscanor, Attribute ต่าง ๆ ให้พร้อมก่อน
local MIN_DELAY = 10  -- ปรับเพิ่มได้ถ้าจำเป็น
task.wait(MIN_DELAY)

-- กันรันซ้ำหลายครั้ง
if getgenv().HORST_AVG_CHANG_INITED then
    return
end
getgenv().HORST_AVG_CHANG_INITED = true

print("[AUTO CHANGE] ⏳ Waiting for Ice Queen detection...")

-- ================================================================
-- CONFIG
-- ================================================================
getgenv().AutoChangeConfig = {
    IceQueen    = true,
    Boxes       = true,
    BoxAmount   = 6_000_000,
    Reroll      = false,
    RerollMin   = 200,
    CheckEvery  = 5,   -- เช็คทุก 5 วิ

    -- 🆕 เงื่อนไขเลเวล
    CheckLevel  = false,  -- true = เปิดเช็คเลเวล
    MinLevel    = 50,     -- เลเวลขั้นต่ำที่ต้องการ
}

local CFG = getgenv().AutoChangeConfig

-- ================================================================
-- SERVICES
-- ================================================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ================================================================
-- ✅ CHECK HORST LOG FOR ICE QUEEN
-- ================================================================
local function CheckHorstIceQueen()
    if getgenv().IceQueenCached == true then
        return true
    end
    return false
end

local function GetReroll()
    return player:GetAttribute("TraitRerolls") or 0
end

local function GetPlayerLevel()
    local lvl = player:GetAttribute("Level") or 0
    return tonumber(lvl) or 0
end

local function ConditionPass()
    -- ❄️ Ice Queen
    if CFG.IceQueen and not CheckHorstIceQueen() then
        return false
    end

    -- 🎁 Boxes
    if CFG.Boxes then
        local presents = player:GetAttribute("Presents26") or 0
        if presents < CFG.BoxAmount then
            return false
        end
    end

    -- 🎲 Reroll
    if CFG.Reroll then
        local reroll = GetReroll()
        if reroll < CFG.RerollMin then
            return false
        end
    end

    -- 🧬 Level
    if CFG.CheckLevel then
        local lvl = GetPlayerLevel()
        if lvl < CFG.MinLevel then
            return false
        end
    end

    return true
end

-- ================================================================
-- DOUBLE CONFIRM
-- ================================================================
local function DoubleConfirm()
    task.wait(0.2)
    return ConditionPass()
end

-- ================================================================
-- MAIN LOOP (Switch Account)
-- ================================================================
while task.wait(CFG.CheckEvery) do
    if ConditionPass() then
        if DoubleConfirm() then
            print("[AUTO CHANGE] 🎉 Condition passed!")
            print("[AUTO CHANGE] 🔁 เปลี่ยนไอดี...")
            warn("🔁 Horst AVG: Condition passed → เปลี่ยนไอดี")

            task.wait(1)
            _G.Horst_AccountChangeDone()
            break
        end
    end
end

print("[AUTO CHANGE] ✅ Switch account done!")
