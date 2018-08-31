--[[
Sync Dial Luci configuration page.
Copyright (C) 2015-2016 GuoGuo <gch981213@gmail.com>
Copyright (C) 2017 Xingwang Liao <kuoruan@gmail.com>
]]--

local sys  = require "luci.sys"

local m, s, o

local ifnum = sys.exec("mwan3 status | grep -c 'is online and tracking is active'")

m = Map("syncdial", translate("Create Virtual WAN Interfaces"),
	translatef("Use Macvlan to create multi virtual WAN interfaces.<br />Current online interface: %s", ifnum))

s = m:section(NamedSection, "general", "syncdial")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enable"))
o.rmempty = false

-- o = s:option(Flag, "force_redial", "Force Redial All", "Force redial all interfaces when there is interface dropped.")
-- o.rmempty = false

o = s:option(Value, "wannum", translate("Number of Virtual WAN Interface"))
o.datatype = "range(0, 20)"
o.rmempty  = false

o = s:option(Flag, "old_frame", translate("Use Old Macvlan Frame to Create Interfaces"))
o.rmempty = false

o = s:option(Button, "_redial", translate("Concurrent Redial"))
o.write = function()
	local success = sys.call("killall -9 pppd") == 0
	if success then
		local url = luci.dispatcher.build_url("admin", "network", "network")
		luci.http.redirect(url)
	end
end

return m
