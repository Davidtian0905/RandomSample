-- @version 1.0.0
-- @author David.tian
-- @B站 https://space.bilibili.com/538201523/
-- @Github https://github.com/Davidtian0905/RandomSample


-- 获取设置
local function getSetting(name)
  local value = reaper.GetExtState("RandomAudioProcessor", name)
  return tonumber(value) or 0
end

-- 生成指定范围内的随机数
local function randomInRange(min, max)
  min, max = tonumber(min), tonumber(max)
  if min and max then
    if min > max then min, max = max, min end
    return min + math.random() * (max - min)
  else
    return 0
  end
end

-- 随机处理选中的音频块
local function processSelectedItems()
  local posMinMs = getSetting("位置偏移最小值(毫秒)")
  local posMaxMs = getSetting("位置偏移最大值(毫秒)")
  local pitchMin = getSetting("音高偏移最小值(音分)")
  local pitchMax = getSetting("音高偏移最大值(音分)")
  local volMin = getSetting("音量偏移最小值(dB)")
  local volMax = getSetting("音量偏移最大值(dB)")
  
  for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    
    -- 位置偏移 (毫秒转秒)
    local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local posOffsetMs = randomInRange(posMinMs, posMaxMs)
    local posOffsetSec = posOffsetMs / 1000
    reaper.SetMediaItemInfo_Value(item, "D_POSITION", pos + posOffsetSec)
    
    -- 音高偏移
    local take = reaper.GetActiveTake(item)
    local pitch = reaper.GetMediaItemTakeInfo_Value(take, "D_PITCH")
    local pitchOffset = randomInRange(pitchMin, pitchMax)
    reaper.SetMediaItemTakeInfo_Value(take, "D_PITCH", pitch + pitchOffset/100)
    
    -- 音量偏移
    local vol = reaper.GetMediaItemInfo_Value(item, "D_VOL")
    local volOffset = randomInRange(volMin, volMax)
    reaper.SetMediaItemInfo_Value(item, "D_VOL", vol * 10^(volOffset/20))
  end
  
  reaper.UpdateArrange()
end

-- 主函数
reaper.Undo_BeginBlock()
math.randomseed(os.time()) -- 设置随机数种子
processSelectedItems()
reaper.Undo_EndBlock("随机处理选中的音频块", -1)
