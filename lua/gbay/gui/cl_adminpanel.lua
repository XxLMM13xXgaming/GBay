net.Receive("GBayOpenAdminPanel", function()
	local theplayers = net.ReadTable()
	local DFrame = vgui.Create("DFrame")
	DFrame:SetSize(300, 300)
	DFrame:Center()
	DFrame:SetText("")
	DFrame:MakePopup()
	DFrame:ShowCloseButton(true)

	DFrame.Paint = function(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
		draw.SimpleText("GBay Admin Panel", "GBayLabelFont", w / 2, 5, Color(137, 137, 137, 255), TEXT_ALIGN_CENTER)
	end

	local ScrollList = vgui.Create("DPanelList", DFrame)
	ScrollList:SetPos(10, 50)
	ScrollList:SetSize(DFrame:GetWide() - 15, DFrame:GetTall() - 70)
	ScrollList:EnableHorizontal(true)
	ScrollList:SetSpacing(10)
	ScrollList:EnableVerticalScrollbar(true)

	for k, v in pairs(theplayers) do
		local ItemMain = vgui.Create("DFrame")
		ItemMain:SetSize(ScrollList:GetWide() - 20, 50)
		ItemMain:SetDraggable(false)
		ItemMain:SetTitle("")
		ItemMain:ShowCloseButton(false)

		ItemMain.Paint = function(s, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(137, 137, 137, 255))
		end

		local PlayerAvatar = vgui.Create("EnhancedAvatarImage", ItemMain)
		PlayerAvatar:SetPos(10, 8)
		PlayerAvatar:SetSize(34, 34)
		PlayerAvatar:SetSteamID(v.sid, 64)
		local SetRank = vgui.Create("DButton", ItemMain)
		SetRank:SetPos(50, 8)
		SetRank:SetSize(100, 15)
		SetRank:SetText("Set Rank")
		SetRank:SetTextColor(Color(185, 201, 229))

		SetRank.Paint = function(s, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(238, 238, 238))
			draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(255, 255, 255))
		end

		SetRank.DoClick = function()
			Derma_Query("What would you like to set this players rank to?", "GBay Set Player Rank", "User", function()
				net.Start("GBaySetPlayerRank")
				net.WriteString("User")
				net.WriteString(v.sid)
				net.SendToServer()
			end, "Admin", function()
				net.Start("GBaySetPlayerRank")
				net.WriteString("Admin")
				net.WriteString(v.sid)
				net.SendToServer()
			end, "Superadmin", function()
				net.Start("GBaySetPlayerRank")
				net.WriteString("Superadmin")
				net.WriteString(v.sid)
				net.SendToServer()
			end, "Close", function() end)
		end

		local BanOUB = vgui.Create("DButton", ItemMain)
		BanOUB:SetPos(50, 25)
		BanOUB:SetSize(100, 15)
		BanOUB:SetText("Ban/Unban player")
		BanOUB:SetTextColor(Color(185, 201, 229))

		BanOUB.Paint = function(s, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(238, 238, 238))
			draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(255, 255, 255))
		end

		BanOUB.DoClick = function()
			Derma_Query("Do you want to ban or unban this player?", "GBay ban/unban player", "Ban", function()
				net.Start("GBayBanPlayer")
				net.WriteFloat(1)
				net.WriteString(v.sid)
				net.SendToServer()
			end, "Unban", function()
				net.Start("GBayUnBanPlayer")
				net.WriteString(v.sid)
				net.SendToServer()
			end, "Close", function() end)
		end

		ScrollList:AddItem(ItemMain)
	end
end)