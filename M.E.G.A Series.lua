-- Instances

require "MapPositionGOS"
require "DamageLib"
require "2DGeometry"
 
--
local huge = math.huge
local pi = math.pi
local floor = math.floor
local ceil = math.ceil
local sqrt = math.sqrt
local max = math.max
local min = math.min
--
local lenghtOf = math.lenghtOf
local abs = math.abs
local deg = math.deg
local cos = math.cos
local sin = math.sin
local acos = math.acos
local atan = math.atan
--
local contains = table.contains
local insert = table.insert
local remove = table.remove
local sort = table.sort
--
local TEAM_JUNGLE = 300
local TEAM_ALLY = myHero.team
local TEAM_ENEMY = TEAM_JUNGLE - TEAM_ALLY
--
local _STUN = 5
local _TAUNT = 8
local _SLOW = 10
local _SNARE = 11
local _FEAR = 21
local _CHARM = 22
local _SUPRESS = 24
local _KNOCKUP = 29
local _KNOCKBACK = 30
--
local Vector = Vector
local KeyDown = Control.KeyDown
local KeyUp = Control.KeyUp
local IsKeyDown = Control.IsKeyDown
local SetCursorPos = Control.SetCursorPos
--
local GameCanUseSpell = Game.CanUseSpell
local Timer = Game.Timer
local Latency = Game.Latency
local HeroCount = Game.HeroCount
local Hero = Game.Hero
local MinionCount = Game.MinionCount
local Minion = Game.Minion
local TurretCount = Game.TurretCount
local Turret = Game.Turret
local WardCount = Game.WardCount
local Ward = Game.Ward
local ObjectCount = Game.ObjectCount
local Object = Game.Object
local MissileCount = Game.MissileCount
local Missile = Game.Missile
local ParticleCount = Game.ParticleCount
local Particle = Game.Particle
--
local DrawCircle = Draw.Circle
local DrawLine = Draw.Line
local DrawColor = Draw.Color
local DrawMap = Draw.CircleMinimap
local DrawText = Draw.Text
--
local barHeight = 8
local barWidth = 103
local barXOffset = 18
local barYOffset = 10
local DmgColor = DrawColor(255, 235, 103, 25)
 
local Color = {
    Red = DrawColor(255, 255, 0, 0),
    Green = DrawColor(255, 0, 255, 0),
    Blue = DrawColor(255, 0, 0, 255),
    White = DrawColor(255, 255, 255, 255),
    Black = DrawColor(255, 0, 0, 0),
}

local GetMode, GetMinions, GetAllyMinions, GetEnemyMinions, GetMonsters, GetHeroes, GetAllyHeroes, GetEnemyHeroes, GetTurrets, GetAllyTurrets, GetEnemyTurrets, GetWards, GetAllyWards, GetEnemyWards, OnPreMovement, OnPreAttack, OnAttack, OnPostAttack, OnPostAttackTick, OnUnkillableMinion, SetMovement, SetAttack, GetTarget, ResetAutoAttack, IsAutoAttacking, Orbwalk, SetHoldRadius, SetMovementDelay, ForceTarget, ForceMovement, GetHealthPrediction, GetPriority
 
Orbwalker = _G.SDK.Orbwalker
ObjectManager = _G.SDK.ObjectManager
TargetSelector = _G.SDK.TargetSelector
HealthPrediction = _G.SDK.HealthPrediction
	 
	GetMode = function() --1:Combo|2:Harass|3:LaneClear|4:JungleClear|5:LastHit|6:Flee
	    local modes = Orbwalker.Modes
	    for i = 0, #modes do
	        if modes[i] then return i + 1 end
	    end
	    return nil
	end
	 
	GetMinions = function(range)
	    return ObjectManager:GetMinions(range)
	end
	 
	GetAllyMinions = function(range)
	    return ObjectManager:GetAllyMinions(range)
	end
	 
	GetEnemyMinions = function(range)
	    return ObjectManager:GetEnemyMinions(range)
	end
	 
	GetMonsters = function(range)
	    return ObjectManager:GetMonsters(range)
	end
	 
	GetHeroes = function(range)
	    return ObjectManager:GetHeroes(range)
	end
	 
	GetAllyHeroes = function(range)
	    return ObjectManager:GetAllyHeroes(range)
	end
	 
	GetEnemyHeroes = function(range)
	    return ObjectManager:GetEnemyHeroes(range)
	end
	 
	GetTurrets = function(range)
	    return ObjectManager:GetTurrets(range)
	end
	 
	GetAllyTurrets = function(range)
	    return ObjectManager:GetAllyTurrets(range)
	end
	 
	GetEnemyTurrets = function(range)
	    return ObjectManager:GetEnemyTurrets(range)
	end
	 
	GetWards = function(range)
	    return ObjectManager:GetOtherMinions(range)
	end
	 
	GetAllyWards = function(range)
	    return ObjectManager:GetOtherAllyMinions(range)
	end
	 
	GetEnemyWards = function(range)
	    return ObjectManager:GetOtherEnemyMinions(range)
	end
	 
	OnPreMovement = function(fn)
	    Orbwalker:OnPreMovement(fn)
	end
	 
	OnPreAttack = function(fn)
	    Orbwalker:OnPreAttack(fn)
	end
	 
	OnAttack = function(fn)
	    Orbwalker:OnAttack(fn)
	end
	 
	OnPostAttack = function(fn)
	    Orbwalker:OnPostAttack(fn)
	end
	 
	OnPostAttackTick = function(fn)
	    if Orbwalker.OnPostAttackTick then
	        Orbwalker:OnPostAttackTick(fn)
	    else
	        Orbwalker:OnPostAttack(fn)
	    end
	end
	 
	OnUnkillableMinion = function(fn)
	    if Orbwalker.OnUnkillableMinion then
	        Orbwalker:OnUnkillableMinion(fn)
	    end
	end
	 
	SetMovement = function(bool)
	    Orbwalker:SetMovement(bool)
	end
	 
	SetAttack = function(bool)
	    Orbwalker:SetAttack(bool)
	end
	 
	GetTarget = function(range, mode) --0:Physical|1:Magical|2:True
	    return TargetSelector:GetTarget(range or huge, mode or 0)
	end
	 
	ResetAutoAttack = function()
	end
	 
	IsAutoAttacking = function()
	    return Orbwalker:IsAutoAttacking()
	end
	 
	Orbwalk = function()
	    Orbwalker:Orbwalk()
	end
	 
	SetHoldRadius = function(value)
	    Orbwalker.Menu.General.HoldRadius:Value(value)
	end
	 
	SetMovementDelay = function(value)
	    Orbwalker.Menu.General.MovementDelay:Value(value)
	end
	 
	ForceTarget = function(unit)
	    Orbwalker.ForceTarget = unit
	end
	 
	ForceMovement = function(pos)
	    Orbwalker.ForceMovement = pos
	end
	 
	GetHealthPrediction = function(unit, delay)
	    return HealthPrediction:GetPrediction(unit, delay)
	end
	 
	GetPriority = function(unit)
	    return TargetSelector:GetPriority(unit) or 1
	end
 
local function TextOnScreen(str)
    local res = Game.Resolution()
    Callback.Add("Draw", function()
        DrawText(str, 64, res.x / 2 - (#str * 10), res.y / 2, Color.Red)
    end)
end

local function Ready(spell)
    return GameCanUseSpell(spell) == 0
end
 
local function RotateAroundPoint(v1, v2, angle)
    local cos, sin = cos(angle), sin(angle)
    local x = ((v1.x - v2.x) * cos) - ((v1.z - v2.z) * sin) + v2.x
    local z = ((v1.z - v2.z) * cos) + ((v1.x - v2.x) * sin) + v2.z
    return Vector(x, v1.y, z or 0)
end
 
local function GetDistanceSqr(p1, p2)
	local success, message = pcall(function() if p1 == nil then print(p1.x) end end)
	if not success then print(message) end
    p2 = p2 or myHero
    p1 = p1.pos or p1
    p2 = p2.pos or p2
    
    local dx, dz = p1.x - p2.x, p1.z - p2.z
    return dx * dx + dz * dz
end
 
local function GetDistance(p1, p2)
    return sqrt(GetDistanceSqr(p1, p2))
end
 
local function HasBuffOfType(unit, bufftype, delay) --returns bool and endtime , why not starting at buffCOunt and check back to 1 ?
    local delay = delay or 0
    local bool = false
    local endT = Timer()
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == bufftype and buff.expireTime >= Timer() and buff.duration > 0 then
            if buff.expireTime > endT then
                bool = true
                endT = buff.expireTime
            end
        end
    end
    return bool, endT
end
 
local function HasBuff(unit, buffname) --returns bool
    return GotBuff(unit, buffname) == 1
end
 
local function GetBuffByName(unit, buffname) --returns buff
    return GetBuffData(unit, buffname)
end
 
local function GetBuffByType(unit, bufftype) --returns buff
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == bufftype and buff.expireTime >= Timer() and buff.duration > 0 then
            return buff
        end
    end
    return nil
end

local function ShouldWait()
    return myHero.dead or HasBuff(myHero, "recall") or Game.IsChatOpen() or (ExtLibEvade and ExtLibEvade.Evading == true)
end
 
local Emote = {
    Joke = HK_ITEM_1,
    Taunt = HK_ITEM_2,
    Dance = HK_ITEM_3,
    Mastery = HK_ITEM_5,
    Laugh = HK_ITEM_7,
    Casting = false
}
 
local function CastEmote(emote)
    if not emote or Emote.Casting or myHero.attackData.state == STATE_WINDUP then return end
    --
    Emote.Casting = true
    KeyDown(HK_LUS)
    KeyDown(emote)
    DelayAction(function()
        KeyUp(emote)
        KeyUp(HK_LUS)
        Emote.Casting = false
    end, 0.01)
end

local ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2, [ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6, [ITEM_7] = HK_ITEM_7}
local function GetItemSlot(id) --returns Slot, HotKey
    for i = ITEM_1, ITEM_7 do
        if myHero:GetItemData(i).itemID == id then
            return i, ItemHotKey[i]
        end
    end
    return 0
end
 
local wardItemIDs = {3340, 2049, 2301, 2302, 2303, 3711}
local function GetWardSlot() --returns Slot, HotKey
    for i = 1, #wardItemIDs do
        local ward, key = GetItemSlot(wardItemIDs[i])
        if ward ~= 0 then
            return ward, key
        end
    end
end
 
local rotateAngle = 0
local function DrawMark(pos, thickness, size, color)
    rotateAngle = (rotateAngle + 2) % 720
    local hPos, thickness, color, size = pos or myHero.pos, thickness or 3, color or Color.Red, size * 2 or 150
    local offset, rotateAngle, mod = hPos + Vector(0, 0, size), rotateAngle / 360 * pi, 240 / 360 * pi
    local points = {
        hPos:To2D(),
        RotateAroundPoint(offset, hPos, rotateAngle):To2D(),
        RotateAroundPoint(offset, hPos, rotateAngle + mod):To2D(),
    RotateAroundPoint(offset, hPos, rotateAngle + 2 * mod):To2D(),
}
    --
    for i = 1, #points do
        for j = 1, #points do
            local lambda = i ~= j and DrawLine(points[i].x - 3, points[i].y - 5, points[j].x - 3, points[j].y - 5, thickness, color) -- -3 and -5 are offsets (because ext)
        end
    end
end
 
local function DrawRectOutline(vec1, vec2, width, color)
    local vec3, vec4 = vec2 - vec1, vec1 - vec2
    local A = (vec1 + (vec3:Perpendicular2():Normalized() * width)):To2D()
    local B = (vec1 + (vec3:Perpendicular():Normalized() * width)):To2D()
    local C = (vec2 + (vec4:Perpendicular2():Normalized() * width)):To2D()
    local D = (vec2 + (vec4:Perpendicular():Normalized() * width)):To2D()
    
    DrawLine(A, B, 3, color)
    DrawLine(B, C, 3, color)
    DrawLine(C, D, 3, color)
    DrawLine(D, A, 3, color)
end
 
local function VectorPointProjectionOnLineSegment(v1, v2, v)
    local cx, cy, ax, ay, bx, by = v.x, v.z, v1.x, v1.z, v2.x, v2.z
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) * (bx - ax) + (by - ay) * (by - ay))
    local pointLine = {x = ax + rL * (bx - ax), z = ay + rL * (by - ay)}
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or {x = ax + rS * (bx - ax), z = ay + rS * (by - ay)}
    return pointSegment, pointLine, isOnSegment
end
 
local function mCollision(pos1, pos2, spell, list) --returns a table with minions (use #table to get count)
    local result, speed, width, delay, list = {}, spell.Speed, spell.Width + 65, spell.Delay, list
    --
    if not list then
        list = GetEnemyMinions(max(GetDistance(pos1), GetDistance(pos2)) + spell.Range + 100)
    end
    --
    for i = 1, #list do
        local m = list[i]
        local pos3 = delay and m:GetPrediction(speed, delay) or m.pos
        if m and m.team ~= TEAM_ALLY and m.dead == false and m.isTargetable and GetDistanceSqr(pos1, pos2) > GetDistanceSqr(pos1, pos3) then
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(pos1, pos2, pos3)
            if isOnSegment and GetDistanceSqr(pointSegment, pos3) < width * width then
                result[#result + 1] = m
            end
        end
    end
    return result
end
 
local function hCollision(pos1, pos2, spell, list) --returns a table with heroes (use #table to get count)
    local result, speed, width, delay, list = {}, spell.Speed, spell.Width + 65, spell.Delay, list
    if not list then
        list = GetEnemyHeroes(max(GetDistance(pos1), GetDistance(pos2)) + spell.Range + 100)
    end
    for i = 1, #list do
        local h = list[i]
        local pos3 = delay and h:GetPrediction(speed, delay) or h.pos
        if h and h.team ~= TEAM_ALLY and h.dead == false and h.isTargetable and GetDistanceSqr(pos1, pos2) > GetDistanceSqr(pos1, pos3) then
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(pos1, pos2, pos3)
            if isOnSegment and GetDistanceSqr(pointSegment, pos3) < width * width then
                insert(result, h)
            end
        end
    end
    return result
end
 
local function HealthPercent(unit)
    return unit.maxHealth > 5 and unit.health / unit.maxHealth * 100 or 100
end
 
local function ManaPercent(unit)
    return unit.maxMana > 0 and unit.mana / unit.maxMana * 100 or 100
end
 
local function HasBuffOfType(unit, bufftype, delay) --returns bool and endtime , why not starting at buffCOunt and check back to 1 ?
    local delay = delay or 0
    local bool = false
    local endT = Timer()
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == bufftype and buff.expireTime >= Timer() and buff.duration > 0 then
            if buff.expireTime > endT then
                bool = true
                endT = buff.expireTime
            end
        end
    end
    return bool, endT
end
 
local function HasBuff(unit, buffname) --returns bool
    return GotBuff(unit, buffname) == 1
end
 
local function GetBuffByName(unit, buffname) --returns buff
    return GetBuffData(unit, buffname)
end
 
local function GetBuffByType(unit, bufftype) --returns buff
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == bufftype and buff.expireTime >= Timer() and buff.duration > 0 then
            return buff
        end
    end
    return nil
end

local UndyingBuffs = {
    ["Aatrox"] = function(target, addHealthCheck)
        return HasBuff(target, "aatroxpassivedeath")
    end,
    ["Fiora"] = function(target, addHealthCheck)
        return HasBuff(target, "FioraW")
    end,
    ["Tryndamere"] = function(target, addHealthCheck)
        return HasBuff(target, "UndyingRage") and (not addHealthCheck or target.health <= 30)
    end,
    ["Vladimir"] = function(target, addHealthCheck)
        return HasBuff(target, "VladimirSanguinePool")
    end,
}

local function HasUndyingBuff(target, addHealthCheck)
    --Self Casts Only
    local buffCheck = UndyingBuffs[target.charName]
    if buffCheck and buffCheck(target, addHealthCheck) then return true end
    --Can Be Casted On Others
    if HasBuff(target, "JudicatorIntervention") or ((not addHealthCheck or HealthPercent(target) <= 10) and (HasBuff(target, "kindredrnodeathbuff") or HasBuff(target, "ChronoShift") or HasBuff(target, "chronorevive"))) then
        return true
    end
    return target.isImmortal
end

local function IsValidTarget(unit, range) -- the == false check is faster than using "not"
    return unit and unit.valid and unit.visible and not unit.dead and unit.isTargetableToTeam and (not range or GetDistance(unit) <= range) and (not unit.type == myHero.type or not HasUndyingBuff(unit, true))
end
 
local function GetTrueAttackRange(unit, target)
    local extra = target and target.boundingRadius or 0
    return unit.range + unit.boundingRadius + extra
end
 
local function HeroesAround(range, pos, team)
    pos = pos or myHero.pos
    local dist = GetDistance(pos) + range + 100
    local result = {}
    local heroes = (team == TEAM_ENEMY and GetEnemyHeroes(dist)) or (team == TEAM_ALLY and GetAllyHeroes(dist) or GetHeroes(dist))
    for i = 1, #heroes do
        local h = heroes[i]
        if GetDistance(pos, h.pos) <= range then
            result[#result + 1] = h
        end
    end
    return result
end
 
local function CountEnemiesAround(pos, range)
    return #HeroesAround(range, pos, TEAM_ENEMY)
end
 
local function GetClosestEnemy(unit)
    local unit = unit or myHero
    local closest, list = nil, GetHeroes()
    for i = 1, #list do
        local enemy = list[i]
        if IsValidTarget(enemy) and enemy.team ~= unit.team and (not closest or GetDistance(enemy, unit) < GetDistance(closest, unit)) then
            closest = enemy
        end
    end
    return closest
end
 
local function MinionsAround(range, pos, team)
    pos = pos or myHero.pos
    local dist = GetDistance(pos) + range + 100
    local result = {}
    local minions = (team == TEAM_ENEMY and GetEnemyMinions(dist)) or (team == TEAM_ALLY and GetAllyMinions(dist) or GetMinions(dist))
    for i = 1, #minions do
        local m = minions[i]
        if m and not m.dead and GetDistance(pos, m.pos) <= range + m.boundingRadius then
            result[#result + 1] = m
        end
    end
    return result
end
 
local function IsUnderTurret(pos, team)
    local turrets = GetTurrets(GetDistance(pos) + 1000)
    for i = 1, #turrets do
        local turret = turrets[i]
        if GetDistance(turret, pos) <= 915 and turret.team == team then
            return turret
        end
    end
end

GetEnemyMinions = function(range)
	return ObjectManager:GetEnemyMinions(range)
end

-- Classes
class "Spell"
 
function Spell:__init(SpellData)
    self.Slot = SpellData.Slot
    self.Range = SpellData.Range or huge
    self.Delay = SpellData.Delay or 0.25
    self.Speed = SpellData.Speed or huge
    self.Radius = SpellData.Radius or SpellData.Width or 0
    self.Width = SpellData.Width or SpellData.Radius or 0
    self.From = SpellData.From or myHero
    self.Collision = SpellData.Collision or false
    self.Type = SpellData.Type or "Press"
    self.DmgType = SpellData.DmgType or "Physical"
    --
    return self
end
 

local function ExcludeFurthest(average, lst, sTar)
    local removeID = 1
    for i = 2, #lst do
        if GetDistanceSqr(average, lst[i].pos) > GetDistanceSqr(average, lst[removeID].pos) then
            removeID = i
        end
    end
    
    local Newlst = {}
    for i = 1, #lst do
        if (sTar and lst[i].networkID == sTar.networkID) or i ~= removeID then
            Newlst[#Newlst + 1] = lst[i]
        end
    end
    return Newlst
end

local function GetBestCircularCastPos(spell, sTar, lst)
    local average = {x = 0, z = 0, count = 0}
    local heroList = lst and lst[1] and (lst[1].type == myHero.type)
    local range = spell.Range or 2000
    local radius = spell.Radius or 50
    if sTar and (not lst or #lst == 0) then
        return Prediction:GetBestCastPosition(sTar, spell), 1
    end
    --
    for i = 1, #lst do
        if IsValidTarget(lst[i], range) then
            local org = heroList and Prediction:GetBestCastPosition(lst[i], spell) or lst[i].pos
            average.x = average.x + org.x
            average.z = average.z + org.z
            average.count = average.count + 1
        end
    end
    --
    if sTar and sTar.type ~= lst[1].type then
        local org = heroList and Prediction:GetBestCastPosition(sTar, spell) or lst[i].pos
        average.x = average.x + org.x
        average.z = average.z + org.z
        average.count = average.count + 1
    end
    --
    average.x = average.x / average.count
    average.z = average.z / average.count
    --
    local inRange = 0
    for i = 1, #lst do
        local bR = lst[i].boundingRadius
        if GetDistanceSqr(average, lst[i].pos) - bR * bR < radius * radius then
            inRange = inRange + 1
        end
    end
    --
    local point = Vector(average.x, myHero.pos.y, average.z)
    --
    if inRange == #lst then
        return point, inRange
    else
        return GetBestCircularCastPos(spell, sTar, ExcludeFurthest(average, lst))
    end
end

local function GetBestLinearCastPos(spell, sTar, list)
    startPos = spell.From.pos or myHero.pos
    local isHero = list[1].type == myHero.type
    --
    local center = GetBestCircularCastPos(spell, sTar, list)
    local endPos = startPos + (center - startPos):Normalized() * spell.Range
    local MostHit = isHero and #hCollision(startPos, endPos, spell, list) or #mCollision(startPos, endPos, spell, list)
    return endPos, MostHit
end
 
local function GetBestLinearFarmPos(spell)
    local minions = GetEnemyMinions(spell.Range + spell.Radius)
    if #minions == 0 then return nil, 0 end
    return GetBestLinearCastPos(spell, nil, minions)
end
 
local function GetBestCircularFarmPos(spell)
    local minions = GetEnemyMinions(spell.Range + spell.Radius)
    if #minions == 0 then return nil, 0 end
    return GetBestCircularCastPos(spell, nil, minions)
end
 
local function CircleCircleIntersection(c1, c2, r1, r2)
    local D = GetDistance(c1, c2)
    if D > r1 + r2 or D <= abs(r1 - r2) then return nil end
    local A = (r1 * r2 - r2 * r1 + D * D) / (2 * D)
    local H = sqrt(r1 * r1 - A * A)
    local Direction = (c2 - c1):Normalized()
    local PA = c1 + A * Direction
    local S1 = PA + H * Direction:Perpendicular()
    local S2 = PA - H * Direction:Perpendicular()
    return S1, S2
end

function Spell:IsReady()
    return GameCanUseSpell(self.Slot) == READY
end
 
function Spell:CanCast(unit, Range, from)
    local from = from or self.From.pos
    local Range = Range or self.Range
    return unit and unit.valid and unit.visible and not unit.dead and (not Range or GetDistance(from, unit) <= Range)
end
 
function Spell:GetPrediction(target)
    return Prediction:GetBestCastPosition(target, self)
end
 
function Spell:GetBestLinearCastPos(sTar, lst)
    return GetBestLinearCastPos(self, sTar, lst)
end
 
function Spell:GetBestCircularCastPos(sTar, lst)
    return GetBestCircularCastPos(self, sTar, lst)
end
 
function Spell:GetBestLinearFarmPos()
    return GetBestLinearFarmPos(self)
end
 
function Spell:GetBestCircularFarmPos()
    return GetBestCircularFarmPos(self)
end
 
function Spell:CalcDamage(target)
    local rawDmg = self:GetDamage(target, stage)
    if rawDmg <= 0 then return 0 end
    --
    local damage = 0
    if self.DmgType == 'Magical' then
        damage = CalcMagicalDamage(self.From, target, rawDmg)
    elseif self.DmgType == 'Physical' then
        damage = CalcPhysicalDamage(self.From, target, rawDmg);
    elseif self.DmgType == 'Mixed' then
        damage = CalcMixedDamage(self.From, target, rawDmg * .5, rawDmg * .5)
    end
    
    if self.DmgType ~= 'True' then
        if HasBuff(myHero, "summonerexhaustdebuff") then
            damage = damage * .6
        elseif HasBuff(myHero, "itemsmitechallenge") then
            damage = damage * .6
        elseif HasBuff(myHero, "itemphantomdancerdebuff") then
            damage = damage * .88
        end
    else
        damage = rawDmg
    end
    
    return damage
end
 
function Spell:GetDamage(target, stage)
    local slot = self:SlotToString()
    return self:IsReady() and getdmg(slot, target, self.From, stage or 1) or 0
end
 
function Spell:SlotToHK()
    return ({[_Q] = HK_Q, [_W] = HK_W, [_E] = HK_E, [_R] = HK_R, [SUMMONER_1] = HK_SUMMONER_1, [SUMMONER_2] = HK_SUMMONER_2})[self.Slot]
end
 
function Spell:SlotToString()
    return ({[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"})[self.Slot]
end
 
function Spell:Cast(castOn)
    if not self:IsReady() or ShouldWait() then return end
    --
    local slot = self:SlotToHK()
    if self.Type == "Press" then
        KeyDown(slot)
        return KeyUp(slot)
    end
    --
    local pos = castOn.x and castOn
    local targ = castOn.health and castOn
    --
    if self.Type == "AOE" and pos then
        local bestPos, hit = self:GetBestCircularCastPos(targ, GetEnemyHeroes(self.Range + self.Radius))
        pos = hit >= 2 and bestPos or pos
    end
    --
    if (targ and not targ.pos:To2D().onScreen) then
        return
    elseif (pos and not pos:To2D().onScreen) then
        if self.Type == "AOE" then
            local mapPos = pos:ToMM()
            Control.CastSpell(slot, mapPos.x, mapPos.y)
        else
            pos = myHero.pos:Extended(pos, 200)
            if not pos:To2D().onScreen then return end
        end
    end
    --
    return Control.CastSpell(slot, targ or pos)
end
 
function Spell:CastToPred(target, minHitchance)
    if not target then return end
    --
    local predPos, castPos, hC = self:GetPrediction(target)
    if predPos and hC >= minHitchance then
        return self:Cast(predPos)
    end
end
 
function Spell:OnImmobile(target)
    local TargetImmobile, ImmobilePos, ImmobileCastPosition = Prediction:IsImmobile(target, self)
    if self.Collision then
        local colStatus = #(mCollision(self.From.pos, Pos, self)) > 0
        if colStatus then return end
        return TargetImmobile, ImmobilePos, ImmobileCastPosition
    end
    return TargetImmobile, ImmobilePos, ImmobileCastPosition
end

local function VectorPointProjectionOnLineSegment(v1, v2, v)
    local cx, cy, ax, ay, bx, by = v.x, v.z, v1.x, v1.z, v2.x, v2.z
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) * (bx - ax) + (by - ay) * (by - ay))
    local pointLine = {x = ax + rL * (bx - ax), z = ay + rL * (by - ay)}
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or {x = ax + rS * (bx - ax), z = ay + rS * (by - ay)}
    return pointSegment, pointLine, isOnSegment
end

local function mCollision(pos1, pos2, spell, list) --returns a table with minions (use #table to get count)
    local result, speed, width, delay, list = {}, spell.Speed, spell.Width + 65, spell.Delay, list
    --
    if not list then
        list = GetEnemyMinions(max(GetDistance(pos1), GetDistance(pos2)) + spell.Range + 100)
    end
    --
    for i = 1, #list do
        local m = list[i]
        local pos3 = delay and m:GetPrediction(speed, delay) or m.pos
        if m and m.team ~= TEAM_ALLY and m.dead == false and m.isTargetable and GetDistanceSqr(pos1, pos2) > GetDistanceSqr(pos1, pos3) then
            local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(pos1, pos2, pos3)
            if isOnSegment and GetDistanceSqr(pointSegment, pos3) < width * width then
                result[#result + 1] = m
            end
        end
    end
    return result
end


class "Prediction"
 
function Prediction:VectorMovementCollision(startPoint1, endPoint1, v1, startPoint2, v2, delay)
    local sP1x, sP1y, eP1x, eP1y, sP2x, sP2y = startPoint1.x, startPoint1.z, endPoint1.x, endPoint1.z, startPoint2.x, startPoint2.z
    local d, e = eP1x - sP1x, eP1y - sP1y
    local dist, t1, t2 = sqrt(d * d + e * e), nil, nil
    local S, K = dist ~= 0 and v1 * d / dist or 0, dist ~= 0 and v1 * e / dist or 0
    local function GetCollisionPoint(t) return t and {x = sP1x + S * t, y = sP1y + K * t} or nil end
    if delay and delay ~= 0 then sP1x, sP1y = sP1x + S * delay, sP1y + K * delay end
    local r, j = sP2x - sP1x, sP2y - sP1y
    local c = r * r + j * j
    if dist > 0 then
        if v1 == huge then
            local t = dist / v1
            t1 = v2 * t >= 0 and t or nil
        elseif v2 == huge then
            t1 = 0
        else
            local a, b = S * S + K * K - v2 * v2, -r * S - j * K
            if a == 0 then
                if b == 0 then --c=0->t variable
                    t1 = c == 0 and 0 or nil
                else --2*b*t+c=0
                    local t = -c / (2 * b)
                    t1 = v2 * t >= 0 and t or nil
                end
            else --a*t*t+2*b*t+c=0
                local sqr = b * b - a * c
                if sqr >= 0 then
                    local nom = sqrt(sqr)
                    local t = (-nom - b) / a
                    t1 = v2 * t >= 0 and t or nil
                    t = (nom - b) / a
                    t2 = v2 * t >= 0 and t or nil
                end
            end
        end
    elseif dist == 0 then
        t1 = 0
    end
    return t1, GetCollisionPoint(t1), t2, GetCollisionPoint(t2), dist
end
 
function Prediction:IsDashing(unit, spell)
    local delay, radius, speed, from = spell.Delay, spell.Radius, spell.Speed, spell.From.pos
    local OnDash, CanHit, Pos = false, false, nil
    local pathData = unit.pathing
    --
    if pathData.isDashing then
        local startPos = Vector(pathData.startPos)
        local endPos = Vector(pathData.endPos)
        local dashSpeed = pathData.dashSpeed
        local timer = Game.Timer()
        local startT = timer - Game.Latency() / 2000
        local dashDist = GetDistance(startPos, endPos)
        local endT = startT + (dashDist / dashSpeed)
        --
        if endT >= timer and startPos and endPos then
            OnDash = true
            --
            local t1, p1, t2, p2, dist = self:VectorMovementCollision(startPos, endPos, dashSpeed, from, speed, (timer - startT) + delay)
            t1, t2 = (t1 and 0 <= t1 and t1 <= (endT - timer - delay)) and t1 or nil, (t2 and 0 <= t2 and t2 <= (endT - timer - delay)) and t2 or nil
            local t = t1 and t2 and min(t1, t2) or t1 or t2
            --
            if t then
                Pos = t == t1 and Vector(p1.x, 0, p1.y) or Vector(p2.x, 0, p2.y)
                CanHit = true
            else
                Pos = Vector(endPos.x, 0, endPos.z)
                CanHit = (unit.ms * (delay + GetDistance(from, Pos) / speed - (endT - timer))) < radius
            end
        end
    end
    
    return OnDash, CanHit, Pos
end
 


function Prediction:IsImmobile(unit, spell)
    if unit.ms == 0 then return true, unit.pos, unit.pos end
    local delay, radius, speed, from = spell.Delay, spell.Radius, spell.Speed, spell.From.pos
    local debuff = {}
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.duration > 0 then
            local ExtraDelay = speed == math.huge and 0 or (GetDistance(from, unit.pos) / speed)
            if buff.expireTime + (radius / unit.ms) > Game.Timer() + delay + ExtraDelay then
                debuff[buff.type] = true
            end
        end
    end
    if debuff[_STUN] or debuff[_TAUNT] or debuff[_SNARE] or debuff[_SLEEP] or
        debuff[_CHARM] or debuff[_SUPRESS] or debuff[_AIRBORNE] then
        return true, unit.pos, unit.pos
    end
    return false, unit.pos, unit.pos
end
 
function Prediction:IsSlowed(unit, spell)
    local delay, speed, from = spell.Delay, spell.Speed, spell.From.pos
    for i = 1, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff.type == _SLOW and buff.expireTime >= Game.Timer() and buff.duration > 0 then
            if buff.expireTime > Game.Timer() + delay + GetDistance(unit.pos, from) / speed then
                return true
            end
        end
    end
    return false
end
 
function Prediction:CalculateTargetPosition(unit, spell, tempPos)
    local delay, radius, speed, from = spell.Delay, spell.Radius, spell.Speed, spell.From
    local calcPos = nil
    local pathData = unit.pathing
    local pathCount = pathData.pathCount
    local pathIndex = pathData.pathIndex
    local pathEndPos = Vector(pathData.endPos)
    local pathPos = tempPos and tempPos or unit.pos
    local pathPot = (unit.ms * ((GetDistance(pathPos) / speed) + delay) + Game.Latency())
    local unitBR = unit.boundingRadius
    --
    if pathCount < 2 then
        local extPos = unit.pos:Extended(pathEndPos, pathPot - unitBR)
        --
        if GetDistance(unit.pos, extPos) > 0 then
            if GetDistance(unit.pos, pathEndPos) >= GetDistance(unit.pos, extPos) then
                calcPos = extPos
            else
                calcPos = pathEndPos
            end
        else
            calcPos = pathEndPos
        end
    else
        for i = pathIndex, pathCount do
            if unit:GetPath(i) and unit:GetPath(i - 1) then
                local startPos = i == pathIndex and unit.pos or unit:GetPath(i - 1)
                local endPos = unit:GetPath(i)
                local pathDist = GetDistance(startPos, endPos)
                --
                if unit:GetPath(pathIndex - 1) then
                    if pathPot > pathDist then
                        pathPot = pathPot - pathDist
                    else
                        local extPos = startPos:Extended(endPos, pathPot - unitBR)
                        
                        calcPos = extPos
                        
                        if tempPos then
                            return calcPos, calcPos
                        else
                            return self:CalculateTargetPosition(unit, spell, calcPos)
                        end
                    end
                end
            end
        end
        --
        if GetDistance(unit.pos, pathEndPos) > unitBR then
            calcPos = pathEndPos
        else
            calcPos = unit.pos
        end
    end
    
    calcPos = calcPos and calcPos or unit.pos
    
    if tempPos then
        return calcPos, calcPos
    else
        return self:CalculateTargetPosition(unit, spell, calcPos)
    end
end
 
function Prediction:GetBestCastPosition(unit, spell)
    local Range = spell.Range and spell.Range or huge
    local radius = spell.Radius == 0 and 1 or (spell.Radius + unit.boundingRadius) - 4
    local speed = spell.Speed or huge
    local from = spell.From or myHero
    local delay = spell.Delay + (0.06 + Game.Latency() / 2000)
    local collision = spell.Collision or false
    --
    local Position, CastPosition, HitChance = Vector(unit), Vector(unit), 0
    local TargetDashing, CanHitDashing, DashPosition = self:IsDashing(unit, spell)
    local TargetImmobile, ImmobilePos, ImmobileCastPosition = self:IsImmobile(unit, spell)
    
    if TargetDashing then
        if CanHitDashing then
            HitChance = 5
        else
            HitChance = 0
        end
        Position, CastPosition = DashPosition, DashPosition
    elseif TargetImmobile then
        Position, CastPosition = ImmobilePos, ImmobileCastPosition
        HitChance = 4
    else
        Position, CastPosition = self:CalculateTargetPosition(unit, spell)
        
        if unit.activeSpell and unit.activeSpell.valid then
            HitChance = 2
        end
        
        if GetDistanceSqr(from.pos, CastPosition) < 250 then
            HitChance = 2
            local newSpell = {Range = Range, Delay = delay, Radius = radius, Width = radius, Speed = speed, From = from}
            Position, CastPosition = self:CalculateTargetPosition(unit, newSpell)
        end
        
        local temp_angle = from.pos:AngleBetween(unit.pos, CastPosition)
        if temp_angle >= 60 then
            HitChance = 1
        elseif temp_angle <= 30 then
            HitChance = 2
        end
    end
    if GetDistanceSqr(from.pos, CastPosition) >= Range * Range then
        HitChance = 0
    end
    if collision and HitChance > 0 then
        local newSpell = {Range = Range, Delay = delay, Radius = radius, Width = radius, Speed = speed, From = from}
        if #(mCollision(from.pos, CastPosition, newSpell)) > 0 then
            HitChance = 0
        end
    end
    
    return Position, CastPosition, HitChance
end

--Initialize Menu
local 	Menu = MenuElement({id = "JiingzCassio", name = "M.E.G.A "..myHero.charName, type = MENU})
        -- Q Menu
		QMenu = Menu:MenuElement({id = "QSettings", name = "Q Settings", type = MENU})

        QMenu:MenuElement({id = "QCombo", name = "COMBO", type = SPACE})
        QMenu:MenuElement({id = "QCombo_enabled", name = "Use Q", value = true})
        QMenu:MenuElement({id = "QCombo_mana", name = "Mana in %", value = 20, min = 1, max = 100, step = 1})
        --Harass Q
        QMenu:MenuElement({id = "QHARASS_Spacing", name = "", type = SPACE})
        QMenu:MenuElement({id = "QHarass", name = "HARASS", type = SPACE})
        QMenu:MenuElement({id = "QHarass_enabled", name = "Use Q", value = true})
		QMenu:MenuElement({id = "QHarass_mana", name = "Mana in %", value = 30, min = 1, max = 100, step = 1})
----------------------------------------------------------------------------------------------------------------------
         -- W Menu
		WMenu = Menu:MenuElement({id = "WSettings", name = "W Settings", type = MENU})

        WMenu:MenuElement({id = "WCombo", name = "COMBO", type = SPACE})
        WMenu:MenuElement({id = "WCombo_enabled", name = "Use W", value = true})
        WMenu:MenuElement({id = "WCombo_mana", name = "Mana in %", value = 20, min = 1, max = 100, step = 1})
----------------------------------------------------------------------------------------------------------------------
         -- E Menu
		EMenu = Menu:MenuElement({id = "ESettings", name = "E Settings", type = MENU})

        EMenu:MenuElement({id = "ECombo", name = "COMBO", type = SPACE})
        EMenu:MenuElement({id = "ECombo_enabled", name = "Use E", value = true})
        EMenu:MenuElement({id = "ECombo_mana", name = "Mana in %", value = 20, min = 1, max = 100, step = 1})

        --Harass E
        EMenu:MenuElement({id = "EHARASS_Spacing", name = "", type = SPACE})
        EMenu:MenuElement({id = "EHarass", name = "HARASS", type = SPACE})
        EMenu:MenuElement({id = "EHarass_enabled", name = "Use E", value = true})
----------------------------------------------------------------------------------------------------------------------

         -- R Menu
		RMenu = Menu:MenuElement({id = "RSettings", name = "R Settings", type = MENU})
		RMenu:MenuElement({id = "WFarm_Spacing", name = "COMING SOON", type = SPACE})
       -- RMenu:MenuElement({id = "RCombo", name = "COMBO", type = SPACE})
      --  RMenu:MenuElement({id = "RCombo_enabled", name = "Use R", value = true})
      --  RMenu:MenuElement({id = "RCombo_enemyNumber", name = "At x Enemies", value = 2, min = 1, max = 5, step = 1})
----------------------------------------------------------------------------------------------------------------------

        DrawingsMenu = Menu:MenuElement({id = "DrawingsMenu", name = "Drawings", type = MENU})
        DrawingsMenu:MenuElement({id = "DrawQ", name = "Draw Q", value = true})
        DrawingsMenu:MenuElement({id = "DrawW", name = "Draw W", value = true})
        DrawingsMenu:MenuElement({id = "DrawE", name = "Draw E", value = true})
        DrawingsMenu:MenuElement({id = "DrawR", name = "Draw R", value = true})


        -- Key Settings
        Menu:MenuElement({id = "MainSpacing", name = "", type = SPACE})
		Menu:MenuElement({id = "Key", name = "Key Settings", type = MENU})
		Menu.Key:MenuElement({id = "Combo", name = "Combo", key = string.byte(" ")})
		Menu.Key:MenuElement({id = "Harass", name = "Harass | Mixed", key = string.byte("C")})
		
	
--Init Callbacks
Callback.Add("Tick",OnTick)
Callback.Add("Draw",OnDraw)
Callback.Add("Load",OnLoad)


function InitSpells()
	Q = Spell({
		Slot = 0,
		Range = 850,
		Delay = 0.5,
		Speed = huge,
		Width =  75,
		Collision = false,
		From = myHero,
		Type = "AOE"
	})
	W = Spell({
		Slot = 1,
		Range = 700,
		Delay = 0.25,
		Speed = huge,
		Width = 160,
		Collision = false,
		From = myHero,
		Type = "AOE"
	})
	E = Spell({
		Slot = 2,
		Range = 700,
		Delay = 0.25,
		Speed = huge,
		Collision = false,
		From = myHero,
		Type = "Targetted"
	})
	R = Spell({
		Slot = 3,
		Range = 825,
		Delay = 0.5,
		Speed = huge,
		Width = 200,
		Collision = false,
		From = myHero,
		Type = "AOE"
	})
end

class "Logic"

function Logic:Combo()

 target = GetTarget(Q.Range)

 if IsValidTarget(target) then
	
	if W:IsReady() and WMenu.WCombo_enabled:Value() and (myHero.mana / myHero.maxMana)*100 >= WMenu.WCombo_mana:Value() then
		wPred = W:GetPrediction(target)
		W:Cast(wPred)
	end

	if GetDistance(target, myHero) <= E.Range and Q:IsReady() and QMenu.QCombo_enabled:Value() and (myHero.mana / myHero.maxMana)*100 >= QMenu.QCombo_mana:Value() then
     qPred = Q:GetPrediction(target)
	 Q:Cast(qPred)
	elseif E:IsReady() and EMenu.ECombo_enabled:Value() and (myHero.mana / myHero.maxMana)*100 >= EMenu.ECombo_mana:Value() then
	 E:Cast(target)
	end
	
 end
end

function Logic:Harass()

	if Q:IsReady() and QMenu.QHarass_enabled:Value() and (myHero.mana / myHero.maxMana)*100 >= QMenu.QHarass_mana:Value() then
		qPred = Q:GetPrediction(target)
		Q:Cast(qPred)
	   elseif GetDistance(target, myHero) <= E.Range and E:IsReady() and EMenu.EHarass_enabled:Value() and (myHero.mana / myHero.maxMana)*100 >= EMenu.EHarass_mana:Value() then
		E:Cast(target)
	   end

end

--Callbacks
function OnLoad()
print("Jiingz "..myHero.charName.." Loaded")
InitSpells()
end

function OnTick()
    if GetMode() == 1 then Logic:Combo()
	elseif GetMode() == 2 then Logic:Harass() end
end

function OnDraw()
 if DrawingsMenu.DrawQ:Value() then
    DrawCircle(myHero.pos, Q.Range,5,Color.White)
 end

 if DrawingsMenu.DrawW:Value() then
    DrawCircle(myHero.pos, W.Range,5,Color.Blue)
 end

 if DrawingsMenu.DrawE:Value() then
    DrawCircle(myHero.pos, E.Range,5,Color.Green)
 end

 if DrawingsMenu.DrawR:Value() then
    DrawCircle(myHero.pos, R.Range,5,Color.Red)
 end
    
end

