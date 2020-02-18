--------------------------------------------------
--	=============== Autorun File ===============
--	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
--	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
--	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--	this addon by Tamcl, newtamcl@foxmail.com
--  https://space.bilibili.com/3761568/#!/
--------------------------------------------------


------------------ Addon Information ------------------
local PublicAddonName = "Improved Anime Bodyguard"
local AddonName = "Improved Anime Bodyguard"
local AddonType = "SNPC"
local AutorunFile = "autorun/anime_bodyguard.lua"
-------------------------------------------------------

local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	local vCat = "Anime Bodyguards"
	VJ.AddNPC_HUMAN("2B","npc_ab_2b",{"weapon_vj_smg1"},vCat)  --index: 1
	VJ.AddNPC_HUMAN("Amatsukaze","npc_ab_amatsukaze",{"weapon_vj_smg1"},vCat)  --index: 2
	VJ.AddNPC_HUMAN("Aqua","npc_ab_aqua",{"weapon_vj_smg1"},vCat)  --index: 3
	VJ.AddNPC_HUMAN("Astolfo","npc_ab_astolfo",{"weapon_vj_smg1"},vCat)  --index: 4
	VJ.AddNPC_HUMAN("Asuna","npc_ab_asuna",{"weapon_vj_smg1"},vCat)  --index: 5
	VJ.AddNPC_HUMAN("Aya Drevis","npc_ab_aya_drevis",{"weapon_vj_smg1"},vCat)  --index: 6
	VJ.AddNPC_HUMAN("Blake Belladonna","npc_ab_blake_belladonna",{"weapon_vj_smg1"},vCat)  --index: 7
	VJ.AddNPC_HUMAN("BRS","npc_ab_brs",{"weapon_vj_smg1"},vCat)  --index: 8
	VJ.AddNPC_HUMAN("Cirno","npc_ab_cirno",{"weapon_vj_smg1"},vCat)  --index: 9
	VJ.AddNPC_HUMAN("Cleaire","npc_ab_cleaire",{"weapon_vj_smg1"},vCat)  --index: 10
	VJ.AddNPC_HUMAN("Combine Soldier","npc_ab_combine_soldier",{"weapon_vj_smg1"},vCat)  --index: 11
	VJ.AddNPC_HUMAN("Creeper Girl","npc_ab_creeper_girl",{"weapon_vj_smg1"},vCat)  --index: 12
	VJ.AddNPC_HUMAN("Ezo Red Fox","npc_ab_ezo_red_fox",{"weapon_vj_smg1"},vCat)  --index: 13
	VJ.AddNPC_HUMAN("Friendly Combine Elite","npc_ab_friendly_combine_elite",{"weapon_vj_smg1"},vCat)  --index: 14
	VJ.AddNPC_HUMAN("God Eater","npc_ab_god_eater",{"weapon_vj_smg1"},vCat)  --index: 15
	VJ.AddNPC_HUMAN("Hata No Kokoro","npc_ab_hata_no_kokoro",{"weapon_vj_smg1"},vCat)  --index: 16
	VJ.AddNPC_HUMAN("Hinanawi Tenshi","npc_ab_hinanawi_tenshi",{"weapon_vj_smg1"},vCat)  --index: 17
	VJ.AddNPC_HUMAN("Izuku Midoriya","npc_ab_izuku_midoriya",{"weapon_vj_smg1"},vCat)  --index: 18
	VJ.AddNPC_HUMAN("Jaune Arc","npc_ab_jaune_arc",{"weapon_vj_smg1"},vCat)  --index: 19
	VJ.AddNPC_HUMAN("Kafuu Chino","npc_ab_kafuu_chino",{"weapon_vj_smg1"},vCat)  --index: 20
	VJ.AddNPC_HUMAN("Kamikaze","npc_ab_kamikaze",{"weapon_vj_smg1"},vCat)  --index: 21
	VJ.AddNPC_HUMAN("Kanna Kamui","npc_ab_kanna_kamui",{"weapon_vj_smg1"},vCat)  --index: 22
	VJ.AddNPC_HUMAN("Kashima","npc_ab_kashima",{"weapon_vj_smg1"},vCat)  --index: 23
	VJ.AddNPC_HUMAN("Katyusha","npc_ab_katyusha",{"weapon_vj_smg1"},vCat)  --index: 24
	VJ.AddNPC_HUMAN("Kirito","npc_ab_kirito",{"weapon_vj_smg1"},vCat)  --index: 25
	VJ.AddNPC_HUMAN("Kizuna AI","npc_ab_kizuna_ai",{"weapon_vj_smg1"},vCat)  --index: 26
	VJ.AddNPC_HUMAN("Kochiya Sanae","npc_ab_kochiya_sanae",{"weapon_vj_smg1"},vCat)  --index: 27
	VJ.AddNPC_HUMAN("Konata","npc_ab_konata",{"weapon_vj_smg1"},vCat)  --index: 28
	VJ.AddNPC_HUMAN("L7","npc_ab_l7",{"weapon_vj_smg1"},vCat)  --index: 29
	VJ.AddNPC_HUMAN("Llenn","npc_ab_llenn",{"weapon_vj_smg1"},vCat)  --index: 30
	VJ.AddNPC_HUMAN("Megumin","npc_ab_megumin",{"weapon_vj_smg1"},vCat)  --index: 31
	VJ.AddNPC_HUMAN("Miku","npc_ab_miku",{"weapon_vj_smg1"},vCat)  --index: 32
	VJ.AddNPC_HUMAN("Miku 2","npc_ab_miku_2",{"weapon_vj_smg1"},vCat)  --index: 33
	VJ.AddNPC_HUMAN("Mirai Akari","npc_ab_mirai_akari",{"weapon_vj_smg1"},vCat)  --index: 34
	VJ.AddNPC_HUMAN("Misaka Mikoto","npc_ab_misaka_mikoto",{"weapon_vj_smg1"},vCat)  --index: 35
	VJ.AddNPC_HUMAN("Murasame","npc_ab_murasame",{"weapon_vj_smg1"},vCat)  --index: 36
	VJ.AddNPC_HUMAN("Nepgear","npc_ab_nepgear",{"weapon_vj_smg1"},vCat)  --index: 37
	VJ.AddNPC_HUMAN("Neptune","npc_ab_neptune",{"weapon_vj_smg1"},vCat)  --index: 38
	VJ.AddNPC_HUMAN("Prinz Eugen","npc_ab_prinz_eugen",{"weapon_vj_smg1"},vCat)  --index: 39
	VJ.AddNPC_HUMAN("Pyrrha Nikos","npc_ab_pyrrha_nikos",{"weapon_vj_smg1"},vCat)  --index: 40
	VJ.AddNPC_HUMAN("Ram","npc_ab_ram",{"weapon_vj_smg1"},vCat)  --index: 41
	VJ.AddNPC_HUMAN("Rem","npc_ab_rem",{"weapon_vj_smg1"},vCat)  --index: 42
	VJ.AddNPC_HUMAN("Renri Yamine","npc_ab_renri_yamine",{"weapon_vj_smg1"},vCat)  --index: 43
	VJ.AddNPC_HUMAN("Rin","npc_ab_rin",{"weapon_vj_smg1"},vCat)  --index: 44
	VJ.AddNPC_HUMAN("Ruby Rose","npc_ab_ruby_rose",{"weapon_vj_smg1"},vCat)  --index: 45
	VJ.AddNPC_HUMAN("Sagiri Izumi","npc_ab_sagiri_izumi",{"weapon_vj_smg1"},vCat)  --index: 46
	VJ.AddNPC_HUMAN("Saten Ruiko","npc_ab_saten_ruiko",{"weapon_vj_smg1"},vCat)  --index: 47
	VJ.AddNPC_HUMAN("Sharo Kirima","npc_ab_sharo_kirima",{"weapon_vj_smg1"},vCat)  --index: 48
	VJ.AddNPC_HUMAN("Shigure","npc_ab_shigure",{"weapon_vj_smg1"},vCat)  --index: 49
	VJ.AddNPC_HUMAN("Shimakaze","npc_ab_shimakaze",{"weapon_vj_smg1"},vCat)  --index: 50
	VJ.AddNPC_HUMAN("Shirai Kuroko","npc_ab_shirai_kuroko",{"weapon_vj_smg1"},vCat)  --index: 51
	VJ.AddNPC_HUMAN("Shiro","npc_ab_shiro",{"weapon_vj_smg1"},vCat)  --index: 52
	VJ.AddNPC_HUMAN("Sinon","npc_ab_sinon",{"weapon_vj_smg1"},vCat)  --index: 53
	VJ.AddNPC_HUMAN("Tohru","npc_ab_tohru",{"weapon_vj_smg1"},vCat)  --index: 54
	VJ.AddNPC_HUMAN("Uiharu Kazari","npc_ab_uiharu_kazari",{"weapon_vj_smg1"},vCat)  --index: 55
	VJ.AddNPC_HUMAN("Umaru Doma","npc_ab_umaru_doma",{"weapon_vj_smg1"},vCat)  --index: 56
	VJ.AddNPC_HUMAN("Uni","npc_ab_uni",{"weapon_vj_smg1"},vCat)  --index: 57
	VJ.AddNPC_HUMAN("U-511","npc_ab_u_511",{"weapon_vj_smg1"},vCat)  --index: 58
	VJ.AddNPC_HUMAN("Weiss Schnee","npc_ab_weiss_schnee",{"weapon_vj_smg1"},vCat)  --index: 59
	VJ.AddNPC_HUMAN("WRS","npc_ab_wrs",{"weapon_vj_smg1"},vCat)  --index: 60
	VJ.AddNPC_HUMAN("Yang Xiao Long","npc_ab_yang_xiao_long",{"weapon_vj_smg1"},vCat)  --index: 61
	VJ.AddNPC_HUMAN("Yuudachi","npc_ab_yuudachi",{"weapon_vj_smg1"},vCat)  --index: 62
	VJ.AddNPC_HUMAN("Zero Two","npc_ab_zero_two",{"weapon_vj_smg1"},vCat)  --index: 63
	VJ.AddNPC_HUMAN("Zetsune Miku","npc_ab_zetsune_miku",{"weapon_vj_smg1"},vCat)  --index: 64
	VJ.AddNPC_HUMAN("zuikaku","npc_ab_zuikaku",{"weapon_vj_smg1"},vCat)  --index: 65

	
	if SERVER then
		resource.AddWorkshop("1156321204")
	end
end

