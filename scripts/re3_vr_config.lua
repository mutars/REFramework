if reframework:get_game_name() ~= "re2" and reframework:get_game_name() ~= "re3" then
    return
end

-- local tdb_version = sdk.get_tdb_version();

-- local statics = require("utility/Statics")
local re2 = require("utility/RE2")
-- local GameObject = require("utility/GameObject")

-- local renderer = sdk.get_native_singleton("via.render.Renderer")
-- local renderer_type = sdk.find_type_definition("via.render.Renderer")

-- local GamePadButton = statics.generate("via.hid.GamePadButton")

local openxr = {
    left_hand_rotation_vec = Vector3f.new(0.186417 , 2.820591, 1.221779), -- pitch yaw roll?
    right_hand_rotation_vec = Vector3f.new(0.186417 - 0.3, -2.820591-0.1, -1.221779-0.1), -- pitch yaw roll?
    left_hand_position_offset = Vector4f.new(0.036934, 0.069525, 0.017501, 0.0),
    right_hand_position_offset = Vector4f.new(0.036934, 0.069525, 0.017501, 0.0)
}

local is_openxr = vrmod:is_openxr_loaded()

local last_original_right_hand_rotation = Quaternion.new(0.0, 0.0, 0.0, 0.0)
local last_camera_matrix = Matrix4x4f.new()

local left_hand_rotation_vec = Vector3f.new(-0.105 + 0.2, 2.37, 1.10) -- pitch yaw roll?
local right_hand_rotation_vec = Vector3f.new(-0.105, -2.37, -1.10) -- pitch yaw roll?

if is_openxr then
    left_hand_rotation_vec = openxr.left_hand_rotation_vec:clone()
    right_hand_rotation_vec = openxr.right_hand_rotation_vec:clone()
end

local left_hand_rotation_offset = Quaternion.new(left_hand_rotation_vec):normalized()
local right_hand_rotation_offset = Quaternion.new(right_hand_rotation_vec):normalized()

local left_hand_position_offset = Vector4f.new(-0.025, 0.045, 0.155, 0.0)
local right_hand_position_offset = Vector4f.new(0.025, 0.045, 0.155, 0.0)

if is_openxr then
    left_hand_position_offset = openxr.left_hand_position_offset:clone()
    right_hand_position_offset = openxr.right_hand_position_offset:clone()
end

firstpersonmod.left_hand_rotation_offset = left_hand_rotation_offset
firstpersonmod.right_hand_rotation_offset = right_hand_rotation_offset
firstpersonmod.left_hand_position_offset = left_hand_position_offset
firstpersonmod.right_hand_position_offset = right_hand_position_offset

-- re.on_draw_ui(function()
--     local changed = false

--     changed, left_hand_rotation_vec = imgui.drag_float3("Left Hand Rotation Offset", left_hand_rotation_vec, 0.005, -5.0, 5.0)

--     if changed then
--         left_hand_rotation_offset = Quaternion.new(left_hand_rotation_vec):normalized()
--     end

--     changed, right_hand_rotation_vec = imgui.drag_float3("Right Hand Rotation Offset", right_hand_rotation_vec, 0.005, -5.0, 5.0)

--     if changed then
--         right_hand_rotation_offset = Quaternion.new(right_hand_rotation_vec):normalized()
--     end

--     changed, left_hand_position_offset = imgui.drag_float4("Left Hand Position Offset", left_hand_position_offset, 0.005, -5.0, 5.0)
--     changed, right_hand_position_offset = imgui.drag_float4("Right Hand Position Offset", right_hand_position_offset, 0.005, -5.0, 5.0)
-- end)
