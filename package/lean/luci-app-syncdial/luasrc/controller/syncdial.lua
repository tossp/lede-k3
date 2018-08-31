--[[
Sync Dial Luci configuration page.
Copyright (C) 2015-2016 GuoGuo <gch981213@gmail.com>
Copyright (C) 2017 Xingwang Liao <kuoruan@gmail.com>
]]--

module("luci.controller.syncdial", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/syncdial") then
		return
	end

	entry({"admin", "network", "syncdial"}, cbi("syncdial/general"),
		_("Virtual WAN")).dependent = true
end
