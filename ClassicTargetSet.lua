local cts = {}

local frame = CreateFrame('Frame')
frame:RegisterEvent('ADDON_LOADED')
frame:RegisterEvent('PLAYER_LOGOUT')

function cts.onEvent(self, event, arg1)
end

frame:SetScript('OnEvent', cts.onEvent)

function cts.target()
   local name = GetUnitName('target')
   return name
end

function cts.setTarget(body, target)
   local t = {};
   for line in string.gmatch(body, '[^\n]+') do
      -- First replace /target xxx
      line = line:gsub('^/tar([^ ]*)([ ]+)[^\[].*', '/tar%1%2' .. target)
      -- Then replace /target [harmful] xxx
      line = line:gsub('/tar([^ ]*)([^\]]+\][ ]*).*', '/tar%1%2' .. target)
      -- Then replace [target=xxx]
      line = line:gsub('tar([^=]*=[ ]*)[^\],]+(.*)', 'tar%1' .. target .. '%2')

      t[#t + 1] = line
   end
   return table.concat(t, '\n')
end

function cts.replace(macro)
   local index = GetMacroIndexByName(macro)
   -- https://wow.gamepedia.com/API_GetMacroInfo
	local name, icon, body, islocal = GetMacroInfo(index)
   local target = cts.target()
   if target then
      body = cts.setTarget(body, target)
      EditMacro(index, nil, nil, body)
      DEFAULT_CHAT_FRAME:AddMessage("CTS: Target set in " .. name .. " to " .. target .. "!", 0.0, 1.0, 1.0)
   end
end
SlashCmdList['CTS_SET'] = cts.replace
SLASH_CTS_SET1 = '/cts'

function cts.sample(macro)
   CreateMacro('cts1', "INV_MISC_QUESTIONMARK", '#showtooltip [nomod] Verwandlung\n/target [nomod] x\n/stopcasting [nomod,exists,harm]\n/spell [nomod,exists,harm] Verwandlung\n/cts cts1')
   DEFAULT_CHAT_FRAME:AddMessage("CTS: Sample macro cts1 created!", 0.0, 1.0, 1.0)
end
SlashCmdList['CTS_SAMPLE'] = cts.sample
SLASH_CTS_SAMPLE1 = '/ctsample'

return cts
