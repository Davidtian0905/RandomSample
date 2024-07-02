# 该Lua脚本适用于Reaper，预览效果：
![RandomSample](https://github.com/Davidtian0905/RandomSample/assets/122532842/5a6e1a92-a1d6-4814-bb26-3859e847c9c6)


# 功能简介：
## 这套脚本由两部分组成：设置脚本（SettingRandomSample.lua）和处理脚本（ProcessRandomSample.lua）。它们共同实现了对REAPER中选定音频项的随机化处理。

### SettingRandomSample.lua：

- 提供一个用户界面，允许设置音频随机化的参数。
- 可以设置位置偏移、音高偏移和音量偏移的最小值和最大值。
- 将设置保存到REAPER的扩展状态中，以便处理脚本使用。


### ProcessRandomSample.lua：

- 读取之前保存的设置。
- 对选中的音频项进行随机处理，包括：

1.随机调整位置（基于毫秒）
2.随机调整音高（基于音分）
3.随机调整音量（基于分贝）



# 使用方法：

## 安装脚本：

- 将SettingRandomSample.lua和ProcessRandomSample.lua保存到REAPER的Scripts目录中。
- 通常路径为：[REAPER安装目录]/Scripts/
- 路径：C:\Users\User(你的电脑用户名)\AppData\Roaming\REAPER\Scripts\


## 在REAPER中加载脚本：

- 打开REAPER，进入"Actions"菜单 -> "Show action list"。
- 点击"New action" -> "Load ReaScript"。
- 分别选择并加载SettingRandomSample.lua和ProcessRandomSample.lua。
- 为每个脚本分配一个方便的快捷键（可选）。


## 设置随机化参数：

### 运行SettingRandomSample.lua脚本。
### 在弹出的对话框中，设置以下参数：

- 位置偏移最小值和最大值（毫秒）
- 音高偏移最小值和最大值（音分）
- 音量偏移最小值和最大值（分贝）


- 点击"OK"保存设置。


### 应用随机化处理：

- 在REAPER的编辑窗口中选择要处理的音频项。
- 运行ProcessRandomSample.lua脚本。
- 脚本将根据之前设置的参数，对选中的音频项进行随机化处理。


### 调整和重复：

- 如需调整随机化参数，重新运行SettingRandomSample.lua并修改设置。
- 可以多次运行ProcessRandomSample.lua来尝试不同的随机效果。



# 注意事项：

- 请在应用随机化之前保存您的项目，以防需要撤销更改。
- 位置偏移是相对于音频项当前位置的，可以是正值（向后移动）或负值（向前移动）。
- 音高偏移中，100音分等于一个半音。
- 音量偏移是在当前音量的基础上进行调整的。

# 后记：
- 我的习惯是，这两个Lua会放在工具栏上，可以快速操作
