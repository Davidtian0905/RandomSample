-- @version 1.0.0
-- @author David.tian
-- @B站 https://space.bilibili.com/538201523/
-- @Github https://github.com/Davidtian0905/RandomSample

-- 定义设置
local settings = {
  {"位置偏移最小值(毫秒)", "0"},
  {"位置偏移最大值(毫秒)", "0"},
  {"音高偏移最小值(音分)", "0"},
  {"音高偏移最大值(音分)", "0"},
  {"音量偏移最小值(dB)", "0"},
  {"音量偏移最大值(dB)", "0"}
}

-- 函数：从扩展状态加载设置
local function loadSettings()
  for i, setting in ipairs(settings) do
    setting[2] = reaper.GetExtState("RandomAudioProcessor", setting[1]) or setting[2]
  end
end

-- 函数：保存设置到扩展状态
local function saveSettings(userInputs)
  for i, setting in ipairs(settings) do
    local value = userInputs[i] or "0"
    reaper.SetExtState("RandomAudioProcessor", setting[1], value, true)
  end
end

-- 创建设置字符串
local function createSettingsString()
  local str = ""
  for i, setting in ipairs(settings) do
    str = str .. setting[1] .. ","
  end
  return str:sub(1, -2)
end

-- 创建值字符串
local function createValuesString()
  local str = ""
  for i, setting in ipairs(settings) do
    str = str .. (setting[2] or "0") .. ","
  end
  return str:sub(1, -2)
end

-- 主函数
local function main()
  loadSettings()
  
  local settingsString = createSettingsString()
  local valuesString = createValuesString()

  local retval, userInputString = reaper.GetUserInputs("随机处理设置", #settings, settingsString, valuesString)

  if retval then
    local userInputs = {}
    for input in userInputString:gmatch("[^,]+") do
      table.insert(userInputs, input ~= "" and input or "0")
    end

    saveSettings(userInputs)
    reaper.ShowMessageBox("设置已保存", "成功", 0)
  else
    reaper.ShowMessageBox("设置已取消", "取消", 0)
  end
end

main()
