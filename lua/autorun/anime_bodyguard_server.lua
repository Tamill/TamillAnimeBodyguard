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
	

	
	local frame = vgui.Create("DFrame")
	frame:SetTitle( "Model Subscription Menu 模型订阅界面.           "..sourceWork )
	frame:SetSize(ScrW()*0.2,ScrH()*0.8 )
	frame:Center()
	frame:MakePopup()
	
	
	
	local theText = "materials/entities/"..assetName..".png"
	local Text = vgui.Create( "DLabel", frame )
	Text:SetText( [[
	z(〃'▽'〃) Let's subscribe model ]]..name..[[. 
	Maybe you're wondering why I didn't make all the models 
	into this addon. 
	1.Models are uploaded by many people, I don't need to do that again.
	2.It's very difficult to put so many model files into one package.
    3.The models are not made by me.	
	
	z(〃'▽'〃) 正在订阅模型]]..chname..[[
	]] )
	text1posOffset = 30
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )
	Text:SetPos( 10, text1posOffset)	
	
	
	local aur = vgui.Create("DImage", frame)
	aur:SetSize(128, 128)
	aur:SetImage("materials/entities/Tamill.png")
	
	local button = vgui.Create("DButton", frame)
	button:SizeToContents()
	button:SetTall( 20 )
	button:SetSize(300, 90)
	
	button:SetText([[
	Open the list of all models.
	帮我打开全部模型的订阅页面。
	]])
	function button:DoClick()
		gui.OpenURL("https://steamcommunity.com/workshop/filedetails/?id=1462658424" )
	end
	local Text = vgui.Create( "DLabel", frame )
	Text:SetText( [[
	Please click here to use your steam to open the page.
	请点击这里使用你的steam来打开这个页面。
	]] )
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )
	aur:SetPos( 20, text1posOffset+110 )
	button:SetPos( 10, text1posOffset+250 )
	Text:SetPos( 20, text1posOffset+300 )
	local Text = vgui.Create( "DLabel", frame )
	Text:SetText( [[
	Please click here to use your steam to open the page.
	请点击这里使用你的steam来打开这个页面。
	]] )
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )
	Text:SetPos( 20, text1posOffset+550 )
	

	
			local button3 = vgui.Create("DButton", frame)
	button3:SizeToContents()
	button3:SetTall( 20 )
	button3:SetPos( 10, text1posOffset+600 )
	button3:SetSize(200, 90)
	button3:SetText([[
	Report Bugs.
	对我留言汇报问题
	]])
	function button3:DoClick()
		gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=1156321204" )
	end
	
	local aur2 = vgui.Create("DImage", frame)
	aur2:SetSize(128, 128)
	aur2:SetImage(theText)
	aur2:SetPos( 20, text1posOffset+350 )
	
	local button2 = vgui.Create("DButton", frame)
	button2:SizeToContents()
	button2:SetTall( 20 )
	button2:SetSize(300, 90)
	button2:SetPos( 10, text1posOffset+500 )
	button2:SetText([[
	Open the ]]..name..[[ model workshop page.
	帮我打开]]..chname..[[模型创意工坊页面。
	]])
	function button2:DoClick()
		gui.OpenURL(steamid)
	end
	
	
	timer.Simple(1, function() 
		gui.OpenURL(steamid)
	end)
end
net.Receive("ABT_ModelMenu", ModelMenu)

