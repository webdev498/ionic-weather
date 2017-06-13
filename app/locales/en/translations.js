export default {
  common: {
    even: "Even",
    odd: "Odd",
    dayOfWeek: "Day of Week",
    interval: "Interval",
    day: "Day",
    hoursMins: "HH:MM",
    program: "Program",
    description: "Description",
    startTime: "Start Time",
    off: "Off",
    on: "On",
    selectFile: "Select File",
    true: "True",
    false: "False",
    search: "Search",
    delete: "Delete",
    cancel: "Cancel",
    close: "Close",
    go: "Go!",
    status: "Loading…",
    am: "am",
    pm: "pm",
    runZone: "Run Zone ",
    locateZone: "Locate Zone ",
    save: "Save Changes",
    //sendNow: "Send Now",
    //unchanged: "Changes not applied yet",
    //enterTitle: "Enter a Title",
    //none: "None",
    //plural: "s",
    //remoteOff: "Remote Off"
    //normal: "Normal",
    zone: "Zone",
    site: "Site",
    controller: "Controller",
    buttonPrompt: "Ready?",
    sortByLocationButton: "Sort by Location",
    sortByLocationMessage: "Nearest sites will appear first",
    sortByNameButton: "Sort by Name",
    sortByNameMessage: "Sites will appear A-Z by name",
    noData: "No Data",
    daysOfWeek: {
      sun: "Sunday",
      mon: "Monday",
      tue: "Tuesday",
      wed: "Wednesday",
      thurs: "Thursday",
      fri: "Friday",
      sat: "Saturday"
    },
    months: {
      jan: "January",
      feb: "February",
      mar: "March",
      apr: "April",
      may: "May",
      jun: "June",
      jul: "July",
      aug: "August",
      sep: "September",
      oct: "October",
      nov: "November",
      dec: "December",
    },
    programs: {
      a: "A",
      b: "B",
      c: "C",
      d: "D"
    }
  },
  login: {
    text: "Please log in",
    loginButton: "Log In",
    retryButton: "Retry",
    email: "Email",
    password: "Password",
    disclaimer: "If you don't have an account yet, please go to",
    disclaimerCont: "and sign up.",
    error: "Login failed",
    errorMessage: "Please check your email and password"
  },
  sites: {
    title: "Your Sites",
    sortByLocation: "sorted by location",
    sortByName: "sorted by name",
    locationUnit: "mi",
    controllerUnit: "controller",
    faultUnit: "fault"
  },
  menu: {
    title: "Options",
    sortTitle: "Sort Options",
    logoutButton: "Log out",
    logoutMessage: "Enter your email and password to log back in",
    syncButton: "Sync Sites",
    syncMessage: "Refresh the latest data from our servers",
    sortButton: "Sort Sites",
    sortMessage: "Change the sort order for the sites list",
    feedbackButton: "Send Feedback",
    feedbackMessage: "Send us feedback about this app",
    launchButton: "Launch Full Site",
    launchMessage: "Open the Smartlink website in a web browser",
    version: "Version",
    advance: {
      title: "Advance Options",
      commLogButton: "Comm Log",
      commLogMessage: "View currently running and recent commands",
      syncButton: "Re-sync",
      syncMessage: "Refresh with the latest data from our servers",
      sendButton: "Send",
      sendMessage: "Transmit your settings to your Smartlink device",
      receiveButton: "Receive",
      receiveMessage: "Pull the latest settings from your Smartlink device"
    }
  },
  controllers: {
    title: "Controllers"
  },
  controllerOptions: {
    title: "Actions",
    runProgram: "Run Program",
    runZone: "Run Zone",
    locateValve: "Locate Valve",
    walkSite: "Walk Site",
    controlProgram: "Controller Programming",
    stopButton: "Stop All",
    controllerTitle: "Controller Details",
    systemStatus: "System Status",
    wateringMode: "Watering Mode",
    rainMode: "Rain/Freeze",
    rainStatusActive: "Active",
    rainStatusBypass: "Bypass",
    waterMode: "Weather",
    clearFaults: "Clear Faults"
  },
  selectProgram: {
    headerTitle: "Select Program",
    subTitle: "Select a Program",
    programA: "Run Program A",
    programB: "Run Program B",
    programC: "Run Program C",
    programD: "Run Program D"
  },
  selectZone: {
      title: "Select Zone",
      subInspectionZone: "Select a Zone to Inspect",
      error: "No zones set up for this controller"
  },
  confirmProgram: {
    subTitle: "Confirm Program",
  },
  runZone: {
    subTitle: "Select a Zone to Run",
  },
  confirmZone: {
    subTitle: "Confirm Zone",
    zonePrompt: "We're about to run",
    timePrompt: "for this amount of time",
    timeUnit: "HH:MM"
  },
  locateValve: {
    subTitle: "Select a Zone to Locate"
  },
  confirmValue: {
    subTitle: "Confirm Zone",
    controllerPrompt: "About to run valve locators",
    valvePrompt: "The water must be be turned off at the backflow device or isolation valve upstream of the zone valve in order to fully utilize the Valve Locator feature of the SmartLine irrigation controller."
  },
  walkSite: {
    subTitle: "Walk Site",
    zoneButton: "Jump to Zone",
    startButton: "Start",
    stopButton: "Stop",
    configure: "Configure Auto-Adjust",
    zonePhoto: "Add Zone Photo"
  },
  programming: {
    basic: "Basic Settings",
    smart: "Smart Settings",
    basicMessage: "Edit time/date and status settings",
    program: "Program Settings",
    programMessage: "Edit program schedules",
    flow: "Flow Settings",
    flowMessage: "Edit flow settings",
    advance: "Advanced Settings",
    advanceMessage: "Edit advanced controller programming",
    edit: "Edit Zones",
    editMessage: "Edit zone's name and image",
    flowRateGPM: 'Flow Rate GPM',
    editZone: "Edit Zone"
  },
  basicSettings: {
    subTitle: "Basic Settings",
    date: "Date",
    time: "Time",
    timeZone: "Controller Time Zone",
    runStatus: "Run Status",
    waterMode: "Watering Mode",
    rainMode: "Rain/Freeze",
    runStatus1: "Run",
    runStatus2: "Remote Off",
    waterMode1: "Basic (Standard)",
    waterMode2: "Smart (Auto-Adjust)"
  },
  programSettings: {
    title: "Program Settings",
    dayTime: "Days & Start Times",
    dayMessage: "Edit watering days and start times",
    zoneTime: "Zone Run Times",
    zoneMessage: "Edit zone run times by program",
    programSmart: "Smart Programming",
    programMessage: "Edit smart programming",
    omitTime: "Omit Days & Times",
    omitMessage: "Edit omit times/days/dates",
    seasonalAdjust: "Seasonal Adjust",
    seasonalMessage: "Edit monthly seasonal % by program"
  },
  smartProgramming: {
    postalCode: "Postal Code",
    latitude: "Latitude"
  },
  omit: {
    title: "Omit Days & Times",
    specificTime: "Omit Specific Times:",
    specificDay: "Omit Days of Week:",
    specificDates: "Omit Event Dates:"
  },
  inspections: {
    inspection: "Inspection ",
    new: "New Inspection",
    create: "Create Inspection",
    //createSubTitle: "Create a new inspection",
    //clickToCreate: "Click to create an inspection",
    title: "Inspection Title",
    titlePlaceholder: "Enter a title",
    subTitle: "Select an Inspection",
    date: "Date & Time",
    type: "Inspection Type",
    start: "Start Inspection",
    schedule: "Scheduled Inspection",
    service: "Service Call",
    edit: "Edit Inspection Options",
    select: "Select Zone to Inspect",
    general: "General",
    seasonal: "Seasonal",
    omit: "Omit"
  },
  generalInspection: {
    date: "Date",
    inspector: "Inspector",
    type: "Type",
    compliant: "Compliant",
    function: "Function R/F Sensor?",
    waterPressure: "Water Pressure",
    name: "Name",
    location: "Location",
    model: "Model",
    airCard: "Aircard",
    slw: "SLW"
  },
  programInspection: {
    settings: "Watering Day Settings",
    daysOfWeek: {
      sun: "S",
      mon: "M",
      tue: "T",
      wed: "W",
      thurs: "T",
      fri: "F",
      sat: "S"
    }
  },
  emailInspection: {
    title: "Email Inspection",
    subTitle: "Edit Inspection Options",
    discliamer: "What email(s) would you like to send the inspection to?",
    fileType: "What type of file do you want to attach:",
    file: {
      pdf: "PDF",
      xls: "XLS"
    },
    includePhotos: "Do you want to include photos?",
    photos: {
      yes: "Yes",
      no: "No"
    }
  },
  inspectionDetails: {
    runTimes: "Program Zone Run Times",
    photos: {
      view: "See Photos"
    },
    currentZone: "Current Zone",
    runZone: "Program Zone Run Times",
    zoneName: "Zone Name",
    area: "% of Area",
    sprinklerType: "Sprinkler Type",
    plantType: "Plant Type",
    soilType: "Soil Type",
    moreLess: "Mode/Less",
    valveSize: "Valve Size",
    gpm: "GPM",
    photo: "Photos",
    upload: "Upload",
    update: "Updating Inspection...",
    programs: "Programs",
    valveStatus: "Valve Status",
    valveChoices: {
      pass: "Pass",
      fail: "Fail"
    },
    image: "Image",
    cloggedNozzle: "Clogged Nozzle",
    blockedHead: "Blocked Head",
    brokenHead: "Broken Head",
    raiseHead: "Raise Head",
    lowerHead: "Lower Head",
    replaceHead: "Replace Head",
    brokenLateral: "Broken Lateral",
    brokenMain: "Broken Main",
    inOutScope: "In/Out Scope",
    estimatedCost: "Estimated Cost",
    comments: "Comments"
  }
};
