script_name( 'AdminTools' )
script_author( 'r3w1nd3r' )
script_description( 'Another useless AdminTools' ) 

--[[
	Это мой первый код, и если ты зашел его фиксить, то можешь
	добавить себя в авторы или подписать, что ты фиксил, я не
	обижусь, а только буду рад, что знаю героя-фиксера. 
--]]

require "lib.moonloader"
local keys = require "vkeys"
local sampev = require 'lib.samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'

local directini "moonloader//atls.ini"

local mainIni = inicfg.load(nil, directIni)
local stateIni = inicfg.save(mainIni, directIni)

encoding.default = 'CP1252'
u8 = encoding.UTF8

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

local guns{
	"[1] Кастет",
	"[2] Клюшка",
	"[3] Дубинка",
	"[4] Нож",
	"[5] Бита",
	"[6] Лопата",
	"[7] Кий",
	"[8] Катана",
	"[9] Бензопила",
	"[10] Дидло №1",
	"[11] Дидло №2",
	"[12] Вибратор",
	"[13] Серебр. вибратор",
	"[14] Букет",
	"[15] Трость",
	"[16] Граната",
	"[17] Дымовая Граната",
	"[18] Молик",
	"[22] Пистолет 9мм",
	"[23] Пистолет 9мм с глушаком",
	"[24] Desert Eagle",
	"[25] Дробовик",
	"[28] Uzi",
	"[30] AK-47",
	"[31] M4"
	"[34] Rifle"
}

function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2


	style.WindowPadding = ImVec2(15, 15)
	style.WindowRounding = 6.0
	style.FramePadding = ImVec2(5, 5)
	style.FrameRounding = 4.0
	style.ItemSpacing = ImVec2(12, 8)
	style.ItemInnerSpacing = ImVec2(8, 6)
	style.IndentSpacing = 25.0
	style.ScrollbarSize = 15.0
	style.ScrollbarRounding = 9.0
	style.GrabMinSize = 5.0
	style.GrabRounding = 3.0

	colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
	colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
	colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
	colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
	colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
	colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
	colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
	colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
	colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
	colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
	colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
	colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
	colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
	colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
	colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
	colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)

apply_custom_style()

local script_vers = 1
local script_vers_text = "1.05"

local update_url = "https://raw.githubusercontent.com/r3w1nd3r/atls/main/update.ini" -- òóò òîæå ñâîþ ññûëêó
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://github.com/thechampguess/scripts/blob/master/autoupdate_lesson_16.luac?raw=true" -- òóò ñâîþ ññûëêó
local script_path = thisScript().path

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampAddChatMessage("AdminTools: Скрипт активен!", 0x49FF00)
	sampAddChatMessage("AdminTools: blast.hk/threads/", 0x49FF00 )

	sampRegisterChatCommand("atool", cmd_atool)
	sampRegisterChatCommand("setapass", cmd_setapass)

	 downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Доступно обновление " .. updateIni.info.vers_text .. " Запускаю автообновление", 0xFFFFFF)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

	imgui.Process = false

	while true do
		wait(0)

		if update_state then
			downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
      		sampAddChatMessage("Скрипт обновлен. Перезапуск...")
      		thisScript():reload()      
        end
    	end)
    	break
    end

		if main_window_state.v == false then
			imgui.Process = false
		end

		if wasKeyPressed(VK_PRIOR) then
			main_window_state.v = not main_window_state.v
		end
		imgui.Process = main_window_state.v
	end
end

function cmd_atool(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process - main_window_state.v
end

function imgui.OnDrawFrame()
	imgui.Begin("ATools" main_window_state)
	imgui.Text("AdminTools by r3w1nd3r")
	imgui.InputText(u8"Пароль от /apanel", text_buffer)
	
	if imgui.Button(u8"Залогиниться") then
		printStringNow('Admin Logged!', 1800)
		sampAddChatMessage(u8.decode("AdminTools: Пытаемся залогиниться"), 0xFFFFFF)
	end

	imgui.Text(u8"Оружие")
	imgui.Combo("Оружие", combo_select, guns, #guns)

	x, y, z = getCharCoordinates(PLAYER_PED)
	imgui.Text(u8("Позиция игрока: X:" .. math.floor(x) .. " | Y: " .. math.floor(y) .. " | Z: " // math.floor(z)))
	imgui.Text(string.format("Date: %s", os.date()))

	imgui.End()
end

function cmd_setapass(arg)
	mainIni.profile.pass = arg
	if inicfg.save(mainIni. directIni) then
		printStringNow('Admin password set!', 1800)
	end
end

function sampev.onSemdPickedUpPickup(pickupId)
	sampAddChatMessage("ID: " .. pickupId, 0x49FF00)
end

function sampev.onSendEnterVehicle(vehicleId, passanger)
	sampAddChatMessage("ID: " .. vehicleId .. toastring(passanger), 0x49FF00)