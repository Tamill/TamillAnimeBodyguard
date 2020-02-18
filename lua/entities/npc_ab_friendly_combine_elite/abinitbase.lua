------------------------------------------------
--	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
--	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
--	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--	this addon by Tamill. Email: tamcl@qq.com 
--  contact me with QQ: 1298878474
-----------------------------------------------*/

ENT.VJ_NPC_Class = {"ANIME_BODYGUARDS_GROUP"}
ENT.PlayerFriendly = true -- Makes the SNPC friendly to the player and HL2 Resistance
ENT.FriendsWithAllPlayerAllies = false -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.DisableCallForBackUpOnDamageAnimation = true
ENT.FollowPlayer = true -- Should the SNPC follow the player when the player presses a certain key?
ENT.FollowPlayerChat = false -- Should the SNPCs say things like "Blank stopped following you" | self.AllowPrintingInChat overrides this variable!
ENT.HasFootStepSound = false
ENT.HasSounds = false
ENT.FadeCorpseTime = 30 -- How much time until the ragdoll fades | Unit = Seconds
ENT.MoveOutOfFriendlyPlayersWay = true
ENT.DisableWeaponReloadAnimation = true
ENT.DisableMeleeAttackAnimation = true -- if true, it will disable the animation code
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.BecomeEnemyToPlayer = false -- Should the friendly SNPC become enemy towards the player if it's damaged by a player? -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 50
ENT.DisableCallForBackUpOnDamageAnimation = true -- Disables the animation when the CallForBackUpOnDamage function is called
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.Weapon_UnlimitedAmmo = true
ENT.AllowWeaponReloading = true
ENT.FindEnemy_UseSphere = true -- Should the SNPC be able to see all around him? (360) | Objects and walls can still block its sight!
ENT.FindEnemy_CanSeeThroughWalls = true 
ENT.DisableChasingEnemy = true
ENT.IsMedicSNPC = true -- Is this SNPC a medic? Does it heal other friendly friendly SNPCs, and players(If friendly)
ENT.GodMode = true
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.Immune_Bullet = false -- Immune to bullet type damages
ENT.Immune_Blast = true -- Immune to explosive-type damages
ENT.Immune_Dissolve = true -- Immune to dissolving | Example: Combine Ball
ENT.Immune_Electricity = true -- Immune to electrical-type damages | Example: shock or laser
ENT.Immune_Fire = true -- Immune to fire-type damages
ENT.Immune_Physics = true -- Immune to physics impacts, won't take damage from props
ENT.Immune_Sonic = true -- Immune to sonic-type damages
ENT.CustomModel = ENT.Model
ENT.Model = { "models/tamill/ab_rem/tb_rem.mdl" }
ENT.HookId = ""
ENT.IsFirstInitMaster = true
ENT.Bleeds = false
ENT.SpawnPos = nil
ENT.Master = nil
ENT.Weapon_NoSpawnMenu = true

function ENT:CustomOnInitialize()
	self.SpawnPos = self:GetPos()
	if self.IsUnavailable == true then
		timer.Simple(0.1,function() if IsValid(self) then self:TipAddonError()  end end)
	end 
	if not file.Exists(self.CustomModel[1],"GAME") then
		print(self.PrintName.." is missing model "..self.CustomModel[1])
		timer.Simple(0.1,function() if IsValid(self) then self:OpenSteamWorkshopPage()  end end)
	else
		self:SetModel(Model(VJ_PICKRANDOMTABLE(self.CustomModel)))
	end
	
	self:SetHealth(100)
	local HookIdNumber = math.random(0,9999999)
	self.HookId = self.PrintName..tostring(HookIdNumber)
	self:InitTakeDamageHook()
	self:Give(VJ_PICKRANDOMTABLE({"weapon_vj_smg1","weapon_vj_ar2","weapon_vj_spas12", "weapon_vj_357", "weapon_vj_mp40", "weapon_vj_m16a1", "weapon_vj_ak47"})) --weapon_vj_rpg
	self:DoChangeWeapon()
	self.CombineFriendly = false
	self:SetCurrentWeaponProficiency(5)
	self.Master = self:GetCreator()
	
 end

 
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup) 
	if self:Health() <= 0 then 
		self:RespawnAnimeCharacter()
	end
end

function ENT:SetRealTarget(argent)
	if IsValid(argent) then
		self:SetEnemy(argent)
		if argent:IsNPC() then
			self:AddEntityRelationship(argent,D_HT,99)
			argent:AddEntityRelationship(self,D_HT,99)		
		end
		self.Target = argent
		if argent:Health() > 3000 then
			argent:SetHealth(3000)
		end	
	end
end

function ENT:RespawnAnimeCharacter()
	local master = self.Master
	local newself = ents.Create(self.EntName)
	if (!IsValid(self)) then return end 
	if (!IsValid(newself) or !IsValid(master)) then return end 
	if self.SpawnPos != nil then newself:SetPos(self.SpawnPos) end
	newself:Spawn()  
	newself:SetCreator(master)
	newself.FollowingPlayer = self.FollowingPlayer
	newself.FollowingPlayerName = master
	newself.RunningAfter_FollowPlayer = self.RunningAfter_FollowPlayer
	newself:SetRealTarget(self.Target)
end

function ENT:OnReloadWeaponCheck()
	if self.IsReloadingWeapon == false && self.AllowWeaponReloading == true && self:VJ_HasActiveWeapon() == true and self.RunningAfter_FollowPlayer == true and IsValid(self:GetEnemy()) and self:GetEnemy() != nil then
		if self.Weapon_ShotsSinceLastReload >= self.Weapon_StartingAmmoAmount && ((self.VJ_IsBeingControlled == false) or (self.VJ_IsBeingControlled == true && self.VJ_TheController:KeyDown(IN_RELOAD))) then
			if self.Weapon_UnlimitedAmmo == true then self:GetActiveWeapon():SetClip1(99999) end
			self.Weapon_ShotsSinceLastReload = 0
			self:CustomOnWeaponReload()
		end
	end
end


function ENT:InitTakeDamageHook()
	hook.Add("EntityTakeDamage", "EntityTakeDamage"..self.HookId, function(ent, dmginfo)
		HookAttacker = dmginfo:GetAttacker()
		HookMaster = self.Master
		if IsValid(self) then
			if HookAttacker == self and ent != self.Master and not ent:IsPlayer() then
				ent:SetHealth(ent:Health() -15)
			end
			if ent == self then
				dmginfo:ScaleDamage(0.8)
			end
			if IsValid(HookAttacker) then
				if ent:Health() > 0 then
					if HookAttacker == self and ent == self.Master then dmginfo:ScaleDamage(0)  end
					if HookAttacker == HookMaster and ent != HookMaster then
						if ent.Master != HookMaster and ent != self then		
							self:SetRealTarget(ent)	
						end
					end
					if HookAttacker != self and ent == HookMaster and HookAttacker != HookMaster then
						if HookAttacker.Master != HookMaster then
							self:SetRealTarget(HookAttacker)
						end
					end							
				end
			end
		end
	end)
end

function ENT:CustomOnRemove() 
	hook.Remove("EntityTakeDamage", "TakeDamage"..self.HookId)
end

function ENT:OnTaskComplete()
	self.bTaskComplete = true
	if IsValid(self:GetCreator()) then self:OnUpdate() end
end

function ENT:OnCondition(iCondition) 
	if IsValid(self:GetCreator()) then self:OnUpdate() end
end

function ENT:Text(content)
	self.Master:PrintMessage(HUD_PRINTTALK, content)
end

function ENT:FirstInitMaster()
	if self.IsFirstInitMaster == true then
		if self.Master.AnimebodyGuards == nil then
			self.Master.AnimebodyGuards = {}
		end
		table.insert(self.Master.AnimebodyGuards, self)
		self.IsFirstInitMaster = false
		self:SetName(self.PrintName)
	end
end

function Teleport(self0, target0)
    rand = math.random(0,7)
	if rand == 0 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * 50 +  target0:GetUp() * 50)
	end
	if rand == 1 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * -50 +  target0:GetUp() * 100)
	end
	if rand == 2 then
		self0:SetPos(target0:GetPos() +  target0:GetForward() * -50 +  target0:GetUp() * 50)
	end
	if rand == 4 then
		self0:SetPos(target0:GetPos() +  target0:GetForward() * 50 +  target0:GetUp() * 100)
	end
	if rand == 5 then
		self0:SetPos(target0:GetPos()+  target0:GetRight() * 50 +  target0:GetForward() * -50  +  target0:GetUp() * 50)
	end
	if rand >= 6 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * 50 +  target0:GetForward() * 50 +  target0:GetUp() * 50)
	end
end

ENT.ReadyTeleport = false
function ENT:OnUpdate()
	self.FollowingPlayer = true
	self.Master = self:GetCreator() 
	self.FollowingPlayerName = self.Master
	self:FirstInitMaster()
	self.PlayerFriendly = true
	if self:GetEnemy() == self.Master then
		self:SetEnemy(nil)
	end	
	if self:GetPos():Distance(self.Master:GetPos()) > 350 and self.FollowingPlayer == true and not self:IsMoving() and self.ReadyTeleport == false then
		self.ReadyTeleport = true
		timer.Simple(3,function() 
			if IsValid(self) and IsValid(self.Master) then 
				if self:GetPos():Distance(self.Master:GetPos()) > 350 and not self:IsMoving() then
					Teleport(self, self.Master)
				end
				self.FollowingPlayer = true
				self.FollowingPlayerName = self.Master
				self.RunningAfter_FollowPlayer = true
				self.ReadyTeleport = false
			end 
		end)
		

	end
	if self:GetPos():Distance(self.Master:GetPos()) > 2000 and self.FollowingPlayer == true then
		Teleport(self, self.Master)
		self.FollowingPlayer = true
		self.FollowingPlayerName = self.Master
		self.RunningAfter_FollowPlayer = true
	    self.ReadyTeleport = false
	end
	self:OnReloadWeaponCheck()
end





























local function AutoComplete( cmd, stringargs )
	local tbl = {
	"newab npc_ab_1",
	"newab npc_ab_2",
	"newab npc_ab_3",
	"newab npc_ab_4",
	"newab npc_ab_5",
	"newab npc_vj_sao_kirito",
	"newab npc_vj_sao_sinon",
	"newab npc_vj_sao_asuna",
	"newab npc_vj_kancolle_amatsukaze",
	"newab npc_vj_kancolle_shimakaze",
	"newab npc_vj_kancolle_kashima",
	"newab npc_vjtbg_elite_soldier",
	"newab npc_vjtbg_prison_guard",
	"newab npc_vj_rwby_ruby",
	"newab npc_vj_rwby_weiss",
	"newab npc_vj_kanna_kamui",
	"newab npc_vj_tohru",
	"newab npc_vjt_kizuna_ai",
	"newab npc_vjt_sagiri_izumi",
	"newab npc_vjt_creeper_girl",
	"newab npc_vj_kancolle_shigure",
	"newab npc_vj_fate_astolfo",
	"newab npc_vj_kafuu_chino",
	"newab npc_vjt_megumin",
	"newab npc_vjt_aqua",
	"newab npc_vjt_nepgear",
	"newab npc_vjt_2b",
	"newab npc_stt_misaka_mikoto",
	"newab npc_stt_saten_ruiko",
	"newab npc_stt_shirai_kuroko",
	"newab npc_stt_uiharu_kazari",
	"newab npc_stt_miku_1",
	"newab npc_stt_miku_2",
	"newab npc_stt_miku_3",
	"newab npc_stt_murasame",
	"newab npc_stt_shiro",
	"newab npc_stt_prinz_eugen",
	"newab npc_stt_zuikaku",
	"newab npc_stt_sharo",
	"newab npc_stt_katyusha",
    "newab npc_stt_yang",
	"newab npc_stt_blake",
	"newab npc_stt_brs",
	"newab npc_stt_wrs",
	"newab npc_stt_l7",
	"newab npc_stt_aya_drevis",
	"newab npc_stt_god_eater",
	"newab npc_stt_janue_arc",
	"newab npc_stt_kamikaze",
	"newab npc_stt_neptune",
	"newab npc_stt_pyrrha_nikos",
	"newab npc_stt_rin",
	"newab npc_stt_uni",
	"newab npc_stt_yuudachi",
	"newab npc_stt_cirno",
	}
	return tbl
end



concommand.Add( "newab", function( ply, cmd, args )
	local ab = ents.Create(args[1])
	if ( !IsValid( ab ) ) then return end 
	if math.random(-1,1) == 0 then
		ab:SetPos(ply:GetPos() +  ply:GetForward() * -50)
	else
		if math.random(-1,1) == 0 then
			ab:SetPos(ply:GetPos() +  ply:GetRight() * 50)
		else
			ab:SetPos(ply:GetPos() +  ply:GetRight() * -50)
		end
	end
	ab:Spawn()  
	ab:SetCreator(ply)
	print( "An anime bodyguard has been created." )
end, AutoComplete )

concommand.Add( "killab", function( ply, cmd, args )
	if ply.AnimebodyGuards == nil then
		print( "You have not soldier now." )
		return
	end
	for k,npcWho in ipairs(ply.AnimebodyGuards) do 
		if npcWho:IsValid() then
			ply:PrintMessage(HUD_PRINTTALK, npcWho.PrintName.." has been killed by console.")
			npcWho:Remove()
		end
	end
	print( "All your anime bodyguards has been killed." )
end)


function ENT:OpenSteamWorkshopPage()
	if IsValid(self:GetCreator()) then
		net.Start( "ABT_ModelMenu" )
		net.WriteString(self.AssetName, 5)
		net.WriteString(self.SteamID, 6)
		net.WriteString(self:GetName(), 7)
		net.WriteString(self.ChineseName, 8)
		net.WriteString(self.Source, 9)
		net.Send(self:GetCreator())
	end
	self:Remove()
end


function ENT:TipAddonError()
	if IsValid(self:GetCreator()) then
		self:GetCreator():PrintMessage(HUD_PRINTTALK, self.ChineseName.."("..self:GetName()..") 在 Steam Workshop 上已经被移除(removed by author)，请访问度盘下载(Please visit here to download it): https://pan.baidu.com/s/1nv5SibJ")
	end

end


util.AddNetworkString("ABT_ModelMenu")
util.AddNetworkString("ABT_DownloadChecker")

function SendAbInfoToServer(a, b, c, d, e)
		timer.Simple(2, function() 
			net.Start("ABT_DownloadChecker" )
			net.WriteString(a, 1)
			net.WriteString(b, 2)
			net.WriteString(c, 3)
			net.WriteString(d, 4)
			net.WriteString(e, 5)
			net.Broadcast()
		end)
end


function ENT:FollowPlayerReset()
	self.RunningAfter_FollowPlayer = false
end


if SERVER then
	SendAbInfoToServer(ENT.AssetName,ENT.CustomModel[1],ENT.PrintName,ENT.ChineseName,ENT.SteamID)
end




--	this addon by Tamill, tamcl@qq.com