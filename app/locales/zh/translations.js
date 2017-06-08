export default {
  common: {
    even: "偶数",
    odd: "奇数",
    dayOfWeek: "周几",
    interval: "间隔",
    day: "天",
    hoursMins: "时：分",
    program: "程序",
    description: "描述",
    startTime: "启动时间",
    off: "关闭",
    on: "打开",
    selectFile: "选文件",
    true: "正确",
    false: "错",
    search: "搜索",
    delete: "删除",
    cancel: "取消",
    close: "关闭",
    go: "执行!",
    status: "状态",
    am: "上午",
    pm: "下午",
    runZone: "运行",
    locateZone: "定位",
    save: "保存",
    zone: "小区",
    site: "项目",
    controller: "控制器",
    buttonPrompt: "好了吗?",
    sortByLocationButton: "依地点排",
    sortByLocationMessage: "就近排",
    sortByNameButton: "依名称排",
    sortByNameMessage: "依名称 A-Z排",
    noData: "无数据",
    daysOfWeek: {
      sun: "星期日",
      mon: "星期一",
      tue: "星期二",
      wed: "星期三",
      thurs: "星期四",
      fri: "星期五",
      sat: "星期六"
    },
    months: {
      jan: "一月",
      feb: "二月",
      mar: "三月",
      apr: "四月",
      may: "五月",
      jun: "六月",
      jul: "七月",
      aug: "八月",
      sep: "九月",
      oct: "十月",
      nov: "十一月",
      dec: "十二月",
    },
    programs: {
      a: "A",
      b: "B",
      c: "C",
      d: "D"
    }
  },
  login: {
    text: "请登录",
    loginButton: "登陆",
    retryButton: "重试",
    email: "Email",
    password: "Password",
    disclaimer: "If you don't have an account yet, please go to",
    disclaimerCont: "如无账号，去注册",
    error: "登录失败",
    errorMessage: "邮箱与密码有误"
  },
  sites: {
    title: "项目",
    sortByLocation: "依地点排",
    sortByName: "依名称排",
    locationUnit: "英里",
    controllerUnit: "控制器",
    faultUnit: "错误"
  },
  menu: {
    title: "选项",
    sortTitle: "排序选择",
    logoutButton: "退出",
    logoutMessage: "输入电子邮箱和密码登录",
    syncButton: "同步",
    syncMessage: "刷新最新数据",
    sortButton: "项目排序",
    sortMessage: "从项目列表改变顺序",
    feedbackButton: "发回反馈",
    feedbackMessage: "发我们APP反馈信息",
    launchButton: "访问网址",
    launchMessage: "用浏览器打开Smartlink网址",
    version: "版本",
    advance: {
      title: "更多选项",
      commLogButton: "指令记录",
      commLogMessage: "最近运行状态及指令",
      syncButton: "重新同步",
      syncMessage: "刷新最新数据",
      sendButton: "发送",
      sendMessage: "发送设置到网络控制设备",
      receiveButton: "接收",
      receiveMessage: "从网络控制设备下载最新设置"
    }
  },
  controllers: {
    title: "控制器名称"
  },
  controllerOptions: {
    title: "执行",
    runProgram: "运行程序",
    runZone: "运行小区",
    locateValve: "阀门定位",
    walkSite: "现场检查",
    controlProgram: "编程",
    stopButton: "终止全部",
    controllerTitle: "控制器细节",
    systemStatus: "系统状态",
    wateringMode: "灌水模式",
    rainMode: "降雨/冰点",
    rainStatusActive: "激活",
    rainStatusBypass: "跳过",
    waterMode: "气象",
    clearFaults: "清除错误"
  },
  selectProgram: {
    headerTitle: "选择程序",
    subTitle: "选择一个程序",
    programA: "运行程序A",
    programB: "运行程序B",
    programC: "运行程序C",
    programD: "运行程序D"
  },
  selectZone: {
      title: "小区选择",
      subInspectionZone: "选一个小区检查",
      error: "本控制器未设定小区"
  },
  confirmProgram: {
    subTitle: "确任程序"
  },
  runZone: {
    subTitle: "选择一个区运行"
  },
  confirmZone: {
    subTitle: "确认运行",
    zonePrompt: "将运行",
    timePrompt: "时长",
    timeUnit: "小时：分钟"
  },
  locateValve: {
    subTitle: "选择定位阀号"
  },
  confirmValue: {
    subTitle: "确认小区",
    controllerPrompt: "运行阀门定位",
    valvePrompt: "为了充分利用控制器阀门定位功能，必须关闭控制阀上游逆止阀或隔离阀处的水"
  },
  walkSite: {
    subTitle: "现场检查",
    zoneButton: "跳到小区",
    startButton: "开始",
    stopButton: "停止",
    configure: "自动调节配置",
    zonePhoto: "增加小区照片"
  },
  programming: {
    basic: "更新基本设置",
    basicMessage: "编辑时间/日期及状态设置",
    program: "编程",
    programMessage: "编辑程序",
    flow: "流量设置",
    flowMessage: "流量设置编辑",
    advance: "先进设置",
    advanceMessage: "编辑控制器先进程序",
    edit: "编辑小区",
    editMessage: "编辑小区名字及照片",
    editZone: "流量设置",
  },
  basicSettings: {
    subTitle: "基础设置",
    date: "日期",
    time: "时间",
    timeZone: "控制器灌区时间",
    runStatus: "运行状态",
    waterMode: "灌水模式",
    rainMode: "降雨/冰点",
    runStatus1: "运行",
    runStatus2: "远程关闭",
    waterMode1: "标准",
    waterMode2: "自动调整"
  },
  programSettings: {
    title: "编程",
    dayTime: "灌水日&启动时间",
    dayMessage: "编辑灌水日及启动时间",
    zoneTime: "灌区运行时间",
    zoneMessage: "由程序编辑小区运行时间",
    programSmart: "启动程序",
    programMessage: "启动智能程序",
    omitTime: "缺省天数&时间",
    omitMessage: "编辑灌水时间/天/日期微调",
    seasonalAdjust: "季节调整",
    seasonalMessage: "由程序编辑月%"
  },
  smartProgramming: {
    postalCode: "邮政编码",
    latitude: "纬度"
  },
  omit: {
    title: "微调灌水天&时间",
    specificTime: "缺省特定时间",
    specificDay: "缺省一星期内天数",
    specificDates: "缺省事件日期"
  },
  inspections: {
    inspection: "检查",
    new: "新检查",
    create: "创建检查",
    title: "检查",
    titlePlaceholder: "进入检查",
    subTitle: "选择检查",
    date: "日期&时间",
    type: "检查类型",
    start: "开始检查",
    schedule: "安排检查",
    service: "服务呼叫",
    edit: "检查选项编辑",
    select: "选个区检查",
    general: "总的",
    seasonal: "季节的",
    omit: "省略"
  },
  generalInspection: {
    date: "检查日期",
    inspector: "检查员",
    type: "类型",
    compliant: "兼容？",
    function: "R/F传感器功能",
    waterPressure: "水压",
    name: "名称",
    location: "位置",
    model: "型号",
    airCard: "充值卡",
    slw: "SLW"
  },
  programInspection: {
    settings: "灌水日设置",
    daysOfWeek: {
      sun: "周日",
      mon: "周一",
      tue: "周二",
      wed: "周三",
      thurs: "周四",
      fri: "周五",
      sat: "周六"
    }
  },
  emailInspection: {
    title: "邮件检查",
    subTitle: "编辑检查选项",
    discliamer: "你想将检查结果发到哪个邮箱？",
    fileType: "附件为什么类型文件",
    file: {
      pdf: "PDF",
      xls: "XLS"
    },
    includePhotos: "你要包含图片吗",
    photos: {
      yes: "是",
      no: "否"
    }
  },
  inspectionDetails: {
    runTimes: "小区运行时间设定",
    photos: {
      view: "看照片"
    },
    currentZone: "当前区",
    runZone: "小区运行时间设定",
    zoneName: "小区名称",
    area: "% 区域%",
    sprinklerType: "喷头类型",
    plantType: "植物类型",
    soilType: "土壤类型",
    moreLess: "增加/减少",
    valveSize: "阀门",
    gpm: "GPM",
    photo: "图片",
    programs: "程序",
    valveStatus: "阀门状态",
    valveChoices: {
      pass: "通过",
      fail: "失败"
    },
    image: "Image",
    cloggedNozzle: "喷嘴堵塞",
    blockedHead: "喷头堵塞",
    brokenHead: "喷头破裂",
    raiseHead: "喷头弹出",
    lowerHead: "喷头缩回",
    replaceHead: "替换喷头",
    brokenLateral: "支管破裂",
    brokenMain: "主管破裂",
    inOutScope: "在范围 内/外",
    estimatedCost: "成本估算",
    comments: "检查注释"
  }
};
