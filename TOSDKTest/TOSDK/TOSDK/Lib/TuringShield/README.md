## 快速开始

#### 将图灵盾整合到你的项目中
1. 将SDK包中的TuringShield目录拖到你的项目中
2. 在Xcode中，依次点击你的project和target，打开"Build Settings"分页
   1. 找到"Library Search Paths"，展开，在Debug子项中增加"TuringShield/Debug"，在Release子项中增加"TuringShield/Release"
   2. 找到"Header Search Paths"，展开，在Debug子项中增加"TuringShield/Debug/include"，在Release子项中增加"TuringShield/Release/include"



#### 自动采集

使用图灵盾自动采集策略，只需要在合适的位置添加一行代码（例如`-application:didFinishLaunchingWithOptions:`）即可以启动：
``` Objective-C
    [[TuringShield standardService] startRiskDetectingWithUserID:YOUR_USER_ID];
```
**注意**：目前自动采集只集成了人机识别和设备风险识别，青少年识别和主人识别不适用。



#### 关于用户ID
 - 请使用业务自己的用户ID替换代码中的`YOUR_USER_ID`。
 - 如果业务本身有帐号体系，且需要监控的功能必须登录帐号才能使用，用户ID应填写能唯一标识用户帐号的字符串，例如OpenID的MD5。
 - 如果业务本身与帐号没有强关联，可以填写业务自行生成的GUID或者UUID（或其MD5）。
 - 没有用户ID的情况，可以直接填@"Default"



#### 关于场景ID
 - 如果应用中有多个需要采集的场景，则需要为每个场景指定不同的ID
 - 场景ID可以是任意整数，建议使用枚举类型并从1开始，并且不建议超过0x20000000
 - 只有单一场景的情况下，简单填为1即可



## 人机识别

通常我们推荐使用[快速开始](#快速开始)中的方法来使用人机识别，但如果你需要特别监控某个重要场景，则可以使用该方法。

开始监听并识别（建议在`-viewDidLoad`回调中实现）：
``` Objective-C
    // 将分析策略指定为人机识别
    TuringAnalysisPolicy *humanPolicy = [TuringAnalysisPolicy humanPolicy];
    // 绑定需要跟踪的视图（下例是点击button1时触发采集）
    humanPolicy.associatedView = self.button1;
    // 创建一个分析任务
    TuringAnalysisTask *humanTask = [[TuringShieldService standardService] analysisTaskForSceneID:YOUR_SCENE_ID withUserID:YOUR_USER_ID policy:humanPolicy];
    // 开始任务
    [humanTask startWithPostRule:TuringDefaultAutoPostRule];
```
结束监听(建议在dealloc回调中实现)
``` Objective-C
    // 寻回分析任务
    TuringAnalysisTask *task = [[TuringShield standardService] managedAnalysisTaskForSceneID:YOUR_SCENE_ID];
    // 结束任务
    [task stop];
```



## 主人识别

主人识别因为场景的复杂性，目前需要根据不同的e场景采取不同的采集策略，并且采集的开始/结束时机也会因场景而略有不同。

#### 标准键盘输入场景

开始监听（建议在`-textFieldDidBeginEditing:`回调中实现）
``` Objective-C
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 必须延后处理，否则无法跟踪到键盘输入
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      	// 设置分析策略为密码输入主人识别
        TuringAnalysisPolicy *policy = [TuringAnalysisPolicy ownerSecurityInputPolicy];
      	// 如果使用标准的系统键盘，则绑定文本输入框，如果是自绘制的键盘（使用`-setInputView:`指定给文件框），则需要绑定键盘视图
        policy.associatedView = YOUR_TEXT_FIELD_OR_KEY_BOARD_VIEW;
      	// 创建一个分析任务
        TuringAnalysisTask *task = [[TuringShield standardService] analysisTaskForSceneID:YOUR_SCENE_ID withUserID:YOUR_USER_ID policy:policy];
      	// 开始任务
        [task startWithPostRule:TuringDefaultAutoPostRule];
    });
#   endif
}
```

结束监听（建议在`-textFieldDidEndEditing:`回调中实现）
``` Objective-C
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    TuringAnalysisTask *task = [[TuringShield standardService] managedAnalysisTaskForSceneID:YOUR_USER_ID];
    // 密码正确则使用[task stop]结束采集并开始分析，密码不正确使用[task cancel]结束采集并取消分析
    // 在不知道密码是否正确的情况下，直接使用[task stop]即可
    if (PASSCODE_IS_CORRECT) {
        // 结束任务
        [task stop];
    }
    else {
        // 取消任务
        [task cancel];
    }
}
```


#### 自绘制键盘输入场景

在等待用户输入密码时开始监听（通常是密码界面出现后）

```Objective-C
    // 设置分析策略为密码输入主人识别
    TuringAnalysisPolicy *policy = [TuringAnalysisPolicy ownerSecurityInputPolicy];
    // 绑定需要跟踪的视图
    policy.associatedView = YOUR_PATTERN_VIEW; // 请将图形锁界面的视图传入来，否则会采集整个窗口
    // 创建一个分析任务
    TuringAnalysisTask *ownerTask = [[TuringShield standardService] analysisTaskForSceneID:YOUR_SCENE_ID withUserID:YOUR_USER_ID policy:policy];
    // 开始任务
    [task startWithPostRule:TuringDefaultAutoPostRule];
```

在用户完成密码输入后结束监听（通常是密码输入完成并且确认密码是否正确后）

```Objective-C
    // 寻回分析任务
    TuringAnalysisTask *task = [[TuringShield standardService] managedAnalysisTaskForSceneID:YOUR_SCENE_ID];
    // 密码正确则使用stop结束采集并开始分析，密码不正确使用cancel结束彩信并取消分析
    // 在不知道密码是否正确的情况下，直接使用stop即可
    if (PASSCODE_IS_CORRECT) {
        // 结束任务
        [task stop];
    }
    else {
        // 取消任务
        [task cancel];
    }
```



#### 图形密码场景

在等待用户输入密码时开始监听（通常是密码界面出现后）
``` Objective-C
    // 设置分析策略为图形锁主人识别
    TuringAnalysisPolicy *policy = [TuringAnalysisPolicy ownerSecurityPatternPolicy];
    // 绑定需要跟踪的视图
    policy.associatedView = YOUR_PATTERN_VIEW; // 请将图形锁界面的视图传入来，否则会采集整个窗口
    // 创建一个分析任务
    TuringAnalysisTask *ownerTask = [[TuringShield standardService] analysisTaskForSceneID:YOUR_SCENE_ID withUserID:YOUR_USER_ID policy:policy];
    // 开始任务
    [task startWithPostRule:TuringDefaultAutoPostRule];
```

在用户完成密码输入后结束监听（通常是密码输入完成并且确认密码是否正确后）
``` Objective-C
    // 寻回分析任务
    TuringAnalysisTask *task = [[TuringShield standardService] managedAnalysisTaskForSceneID:YOUR_SCENE_ID];
    // 密码正确则使用stop结束采集并开始分析，密码不正确使用cancel结束彩信并取消分析
    // 在不知道密码是否正确的情况下，直接使用stop即可
    if (PASSCODE_IS_CORRECT) {
        // 结束任务
        [task stop];
    }
    else {
        // 取消任务
        [task cancel];
    }
```

在用户输入图形密码过程中，每连接一个节点，告知分析任务时间戳，以便切分事件（可选）
``` Objective-C
    TuringAnalysisTask *task = [[TuringShield standardService] managedAnalysisTaskForSceneID:TSSceneIdentifierInputTextView];
    // 增加切分点，注意时间戳为touch事件的时间戳，不是 [NSDate date].timeIntervalSince1970 或者 CFAbsoluteTimeGetCurrent()
    [task addSplittingTimestamp:timestamp];
```



## 青少年识别
（暂空）



## 与我们联系
如有任何问题，欢迎与我们联系，企业w .x. @samsonxu
