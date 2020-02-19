--------------------------------------------------
--	=============== Autorun File ===============
--	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
--	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
--	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--	this addon by Tamcl, newtamcl@foxmail.com
--  https://space.bilibili.com/3761568/#!/
--------------------------------------------------



	
function DownloadChecker(bits)
    if SERVER 
	
	then
	
	else
	
		local assetName = net.ReadString(1)
		local model = net.ReadString(2)
		local GetName = net.ReadString(3)
		local GetChineseName = net.ReadString(4)
		local steamID = net.ReadString(5)
		local downloaded = false
		
		
		if LocalPlayer().countingAb == nil then
			LocalPlayer().countingAb = 0
		end
		
		
		LocalPlayer().countingAb = LocalPlayer().countingAb + 1
		--print([[list.GetForEdit("NPC").]]..assetName..[[.Name = "❤Subscribe ]]..GetName..[["]])
		
		
		--if nice == 1 then
		if not file.Exists(model,"GAME") then
		   RunString([[list.GetForEdit("NPC").]]..assetName..[[.Name = "❤Subscribe ]]..GetName..[["]])

			timer.Create( "abchecker_download_"..assetName, 5, 0, function()	
				if file.Exists(model,"GAME") and downloaded == false then
				
					RunString([[list.GetForEdit("NPC").]]..assetName..[[.Name = "]]..GetName.." "..GetChineseName..[["]])
					LocalPlayer():ConCommand('spawnmenu_reload')
					downloaded = true
					LocalPlayer():PrintMessage(HUD_PRINTTALK, "Anime Bodyguards: "..GetName.." "..GetChineseName.." is available now.")
				end
			end)
		else
			 RunString([[list.GetForEdit("NPC").]]..assetName..[[.Name = "◤]]..GetName.." "..GetChineseName..[["]])
		end
		RunString([[list.GetForEdit("NPC").]]..assetName..[[.steamID = "]]..steamID..[["]])

		if LocalPlayer().countingAb == 1 then
			--LocalPlayer().countingAb = 0
			LocalPlayer():ConCommand('spawnmenu_reload')
		end
		
	end

end
net.Receive("ABT_DownloadChecker", DownloadChecker)

	
	
	


function ModelMenu(bits)

	local assetName = net.ReadString(5)
	local steamid = net.ReadString(6)
	local name = net.ReadString(7)
	local chname = net.ReadString(8)
	local sourceWork = net.ReadString(9)
	local posOfPor = "materials/entities/"..assetName..".png"
	local UIposOffset = ScrH()*0.25

	local frame = vgui.Create("DFrame")
	frame:SetTitle( "Model Subscription Menu 模型订阅   "..name.."  "..chname )
	frame:MakePopup()
	
	local Text = vgui.Create( "DLabel", frame )
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )
	Text:SetText( [[z(〃'▽'〃) Let's subscribe model ]]..name.."  "..chname..[[. 
Tip: All the models you subscribed from here will be 
attached with new VJBase Scripts. Not simple NPCs.

Maybe you're wondering why I didn't make all the models 
into this addon. 

1.Models are uploaded by many people, I don't need to do that again.
2.It's very difficult to put so many model files into one package.
3.The models are not made by me.

You can also try to browse the collection:
]] )	
	
	local ui_scri = vgui.Create("DImage", frame)
	ui_scri:SetImage("materials/entities/ui_scri.png")

	local bt_opall = vgui.Create("DButton", frame)
	bt_opall:SizeToContents()
	bt_opall:SetTall( 20 )
	bt_opall:SetText([[
	Browse Anime Character Collection
	浏览二次元模型集合
	]])
	function bt_opall:DoClick()
		gui.OpenURL("https://steamcommunity.com/workshop/filedetails/?id=1462658424" )
	end

	local bt_rebug = vgui.Create("DButton", frame)
	bt_rebug:SizeToContents()
	bt_rebug:SetTall( 20 )
	bt_rebug:SetText([[
	Report Bugs.
	对我留言汇报问题
	]])
	function bt_rebug:DoClick()
		gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=1156321204" )
	end
	
	local img_por = vgui.Create("DImage", frame)
	img_por:SetImage(posOfPor)
	
	local bt_opws = vgui.Create("DButton", frame)
	bt_opws:SizeToContents()
	bt_opws:SetTall( 20 )
	bt_opws:SetText([[
	Open the ]]..name..[[ model workshop page.
	帮我打开]]..chname..[[模型创意工坊页面。
	]])
	function bt_opws:DoClick()
		gui.OpenURL(steamid)
	end
	timer.Simple(1, function() 
		gui.OpenURL(steamid)
	end)
	
	--UI Size--------
	frame:SetSize(ScrW()*0.5,ScrH()*0.6 )
	Text:SizeToContents()
	ui_scri:SetSize(ScrW()*0.5, UIposOffset)
	img_por:SetSize(128*1.5, 128*1.5)
	bt_opall:SetSize(300, 50)
	bt_opws:SetSize(300, 58)
	bt_rebug:SetSize(200, 50)
	
	--UI Position--------
	frame:Center()
	ui_scri:SetPos( 0, 30 )
	
	Text:SetPos(10, UIposOffset+40)
	bt_opall:SetPos( 10, UIposOffset+200 )
	bt_rebug:SetPos( 10, UIposOffset+260 )
	img_por:SetPos( 380, UIposOffset+50 )
	bt_opws:SetPos( 580, UIposOffset+50 )
		
	
	
end
net.Receive("ABT_ModelMenu", ModelMenu)

