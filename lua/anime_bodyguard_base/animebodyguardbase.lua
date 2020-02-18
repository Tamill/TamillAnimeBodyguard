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
ENT.TargetLock = nil
ENT.FollowingPlayer = true
ENT.FollowPlayer_GoingAfter = true
ENT.FollowPlayer_WanderValue = false
ENT.FollowPlayer_ChaseValue = false
ENT.AlreadyDone_RunSelectSchedule_FollowPlayer = false
ENT.Behavior = VJ_BEHAVIOR_AGGRESSIVE
--ENT.NPCTbl_Animals = {npc_barnacle=false,npc_crow=false,npc_pigeon=false,npc_seagull=false,monster_cockroach=false}
--ENT.NPCTbl_Resistance = {npc_magnusson=false,npc_vortigaunt=false,npc_mossman=false,npc_monk=false,npc_kleiner=false,npc_fisherman=false,npc_eli=false,npc_dog=false,npc_barney=false,npc_alyx=false,npc_citizen=false,monster_scientist=false,monster_barney=false}
ENT.NPCTbl_Combine = {npc_stalker=false,npc_rollermine=false,npc_turret_ground=false,npc_turret_floor=false,npc_turret_ceiling=false,npc_strider=false,npc_sniper=false,npc_metropolice=false,npc_hunter=false,npc_breen=false,npc_combine_camera=false,npc_combine_s=false,npc_combinedropship=false,npc_combinegunship=false,npc_cscanner=false,npc_clawscanner=false,npc_helicopter=false,npc_manhack=false}
ENT.NPCTbl_Zombies = {npc_fastzombie_torso=false,npc_zombine=false,npc_zombie_torso=false,npc_zombie=false,npc_poisonzombie=false,npc_headcrab_fast=false,npc_headcrab_black=false,npc_headcrab=false,npc_fastzombie=false,monster_zombie=false,monster_headcrab=false,monster_babycrab=false}
ENT.NPCTbl_Antlions = {npc_antlion=false,npc_antlionguard=false,npc_antlion_worker=false}
ENT.NPCTbl_Xen = {monster_bullchicken=false,monster_alien_grunt=false,monster_alien_slave=false,monster_alien_controller=false,monster_houndeye=false,monster_gargantua=false,monster_nihilanth=false}

if (CLIENT) then
	language.Add(ENT.AssetName, ENT.PrintName)
	killicon.Add(ENT.AssetName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..ENT.AssetName, ENT.PrintName)
	killicon.Add("#"..ENT.AssetName,"HUD/killicons/default",Color(255,80,0,255))
end

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
		if not VJ_HasValue(self.VJ_AddCertainEntityAsEnemy,argent) then
		  self.VJ_AddCertainEntityAsEnemy[#self.VJ_AddCertainEntityAsEnemy+1] = argent
		end
		--self.TakingCoverT = CurTime() + 2
		if argent:IsNPC() then
			self:AddEntityRelationship(argent,D_HT,99)
			argent:AddEntityRelationship(self,D_HT,99)
			argent.GodMode = false	
			self:VJ_DoSetEnemy(argent,true)
		end
		self.Target = argent
		if argent:Health() > 1000 then
			argent:SetHealth(800)
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

function ENT:CreateBloodOn(tgt)
	local vPoint = tgt:GetPos() + tgt:GetUp() * 50
	local effectdata = EffectData()
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale(2)
	util.Effect( "Explosion", effectdata )
end


function ENT:InitTakeDamageHook()
	hook.Add("EntityTakeDamage", "EntityTakeDamage"..self.HookId, function(ent, dmginfo)
		HookAttacker = dmginfo:GetAttacker()
		HookMaster = self.Master
		if IsValid(self) then
			if HookAttacker == self and ent != self.Master and not ent:IsPlayer() then
				dmginfo:ScaleDamage(2)
				dmginfo:SetDamageForce(self:GetForward()* 2000)
			end
			if ent == self then
				dmginfo:ScaleDamage(0)
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
    rand = math.random(0,12)
	if rand == 0 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * 50 +  target0:GetUp() * 50)
	end
	if rand == 1 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * -50 +  target0:GetUp() * 50)
	end
	if rand == 2 then
		self0:SetPos(target0:GetPos() +  target0:GetForward() * -50 +  target0:GetUp() * 50)
	end
	if rand == 3 then
		self0:SetPos(target0:GetPos() +  target0:GetForward() * 50 +  target0:GetUp() * 50)
	end
	if rand == 4 then
		self0:SetPos(target0:GetPos()+  target0:GetRight() * 50 +  target0:GetForward() * -50  +  target0:GetUp() * 50)
	end
	if rand == 5 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * 50 +  target0:GetForward() * 50 +  target0:GetUp() * 50)
	end
	if rand == 6 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * 70 +  target0:GetUp() * 50)
	end
	if rand == 7 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * -70 +  target0:GetUp() * 50)
	end
	if rand == 8 then
		self0:SetPos(target0:GetPos() +  target0:GetForward() * -70 +  target0:GetUp() * 50)
	end
	if rand == 9 then
		self0:SetPos(target0:GetPos() +  target0:GetForward() * 70 +  target0:GetUp() * 50)
	end
	if rand == 10 then
		self0:SetPos(target0:GetPos()+  target0:GetRight() * 70 +  target0:GetForward() * -50  +  target0:GetUp() * 50)
	end
	if rand >= 11 then
		self0:SetPos(target0:GetPos() +  target0:GetRight() * 70 +  target0:GetForward() * 50 +  target0:GetUp() * 50)
	end
end
ENT.BecomeEnemyToPlayerLevel = 100
ENT.ReadyTeleport = false
ENT.CheckTeleportedOnGround = false
ENT.BecomeEnemyToPlayerChance = 0
ENT.PlayerFriendly = true
ENT.BecomeEnemyToPlayer = false



function ENT:OnUpdate()
	
	self.Master = self:GetCreator() 
	if IsValid(self.Master) then
		self.FollowPlayer_Entity = self.Master
		self.FollowingPlayer = true
		self:FirstInitMaster()
		
		if IsValid(TargetLock) then
			if not self.shouldDieCheck == true and not TargetLock:IsPlayer()  then
				self.shouldDieCheck = true
				local abc = TargetLock
				timer.Simple(20, function()
					if IsValid(abc) and IsValid(self) then
						if self:GetEnemy() == abc then
							self:CreateBloodOn(abc)
							local body = ents.Create( "prop_ragdoll" )
							body:SetPos( abc:GetPos() )
							body:SetModel( abc:GetModel() )
							body:Spawn()
							abc:Remove()
							timer.Simple( 15, function()
								body:Remove()
							end )					
						end
					end
					self.shouldDieCheck = false
				end )
			end
		end
		

		if self:GetPos():Distance(self.Master:GetPos()) > 350 and self.FollowingPlayer == true and not self:IsMoving() and self.ReadyTeleport == false then
			self.ReadyTeleport = true
			timer.Simple(4,function() 
				if IsValid(self) and IsValid(self.Master) then 
					if self:GetPos():Distance(self.Master:GetPos()) > 350 and not self:IsMoving() then
						Teleport(self, self.Master)
					end
				end 
				self.ReadyTeleport = false
			end)
			
		end
		if self:GetPos():Distance(self.Master:GetPos()) > 2000 and self.FollowingPlayer == true and self.ReadyTeleport == false then
			Teleport(self, self.Master)
			self.ReadyTeleport = false
		end
		self:OnReloadWeaponCheck()
		TargetLock = self:GetEnemy()
		if  TargetLock == self.Master then
			print("player is enemy, reseting")
			self:SetEnemy(NULL)
			self.PlayerFriendly = true
			self.BecomeEnemyToPlayer = false
			self.AngerLevelTowardsPlayer = 0
			self.VJ_AddCertainEntityAsEnemy = {}
		end	
	else
		self.ReadyTeleport = false
	end
end





























local function AutoComplete( cmd, stringargs )
	local tbl = {
	"newab npc_ab_2b",
	"newab npc_ab_amatsukaze",
	"newab npc_ab_aqua",
	"newab npc_ab_astolfo",
	"newab npc_ab_asuna",
	"newab npc_ab_aya_drevis",
	"newab npc_ab_blake_belladonna",
	"newab npc_ab_brs",
	"newab npc_ab_cirno",
	"newab npc_ab_cleaire",
	"newab npc_ab_combine_soldier",
	"newab npc_ab_creeper_girl",
	"newab npc_ab_ezo_red_fox",
	"newab npc_ab_friendly_combine_elite",
	"newab npc_ab_god_eater",
	"newab npc_ab_hata_no_kokoro",
	"newab npc_ab_hinanawi_tenshi",
	"newab npc_ab_izuku_midoriya",
	"newab npc_ab_jaune_arc",
	"newab npc_ab_kafuu_chino",
	"newab npc_ab_kamikaze",
	"newab npc_ab_kanna_kamui",
	"newab npc_ab_kashima",
	"newab npc_ab_katyusha",
	"newab npc_ab_kirito",
	"newab npc_ab_kizuna_ai",
	"newab npc_ab_kochiya_sanae",
	"newab npc_ab_konata",
	"newab npc_ab_l7",
	"newab npc_ab_llenn",
	"newab npc_ab_megumin",
	"newab npc_ab_miku",
	"newab npc_ab_miku_2",
	"newab npc_ab_mirai_akari",
	"newab npc_ab_misaka_mikoto",
	"newab npc_ab_murasame",
	"newab npc_ab_nepgear",
	"newab npc_ab_neptune",
	"newab npc_ab_prinz_eugen",
	"newab npc_ab_pyrrha_nikos",
	"newab npc_ab_ram",
	"newab npc_ab_rem",
	"newab npc_ab_renri_yamine",
	"newab npc_ab_rin",
	"newab npc_ab_ruby_rose",
	"newab npc_ab_sagiri_izumi",
	"newab npc_ab_saten_ruiko",
	"newab npc_ab_sharo_kirima",
	"newab npc_ab_shigure",
	"newab npc_ab_shimakaze",
	"newab npc_ab_shirai_kuroko",
	"newab npc_ab_shiro",
	"newab npc_ab_sinon",
	"newab npc_ab_tohru",
	"newab npc_ab_uiharu_kazari",
	"newab npc_ab_umaru_doma",
	"newab npc_ab_uni",
	"newab npc_ab_u_511",
	"newab npc_ab_weiss_schnee",
	"newab npc_ab_wrs",
	"newab npc_ab_yang_xiao_long",
	"newab npc_ab_yuudachi",
	"newab npc_ab_zero_two",
	"newab npc_ab_zetsune_miku",
	"newab npc_ab_zuikaku",

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
		net.WriteString(self.Web, 6)
		net.WriteString(self:GetName(), 7)
		net.WriteString(self.ChineseName, 8)
		net.WriteString("Half-Life 2", 9)
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



function ENT:FollowPlayerReset()
	self.RunningAfter_FollowPlayer = false
end

function SendInfo(AssetName,CustomModel,PrintName,ChineseName,Web)
	timer.Simple(2, function() 
		net.Start("ABT_DownloadChecker" )
		net.WriteString(AssetName, 1)
		net.WriteString(CustomModel[1], 2)
		net.WriteString(PrintName, 3)
		net.WriteString(ChineseName, 4)
		net.WriteString(Web, 5)
		net.Broadcast()
	end)
end

if SERVER then
	SendInfo(ENT.AssetName,ENT.CustomModel,ENT.PrintName,ENT.ChineseName,ENT.Web)
end




--	this addon by Tamill, tamcl@qq.com