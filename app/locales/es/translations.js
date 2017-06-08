export default {
  common: {
    even: "Par",
    odd: "Impar",
    dayOfWeek: "Dia de la semana",
    interval: "Intervalo",
    day: "Dia",
    hoursMins: "HH:MM",
    program: "Programa",
    description: "Descripción",
    startTime: "Hora  de Inicio",
    off: "Apagado",
    on: "Encendido",
    selectFile: "Selecccionar Archivo",
    true: "Verdadero",
    false: "Falso",
    search: "Buscar",
    delete: "Borrar",
    cancel: "Cancelar",
    close: "Cerrar",
    go: "¡Ir!",
    status: "Cargando…",
    am: "am",
    pm: "pm",
    runZone: "Ejecutar Zona ",
    locateZone: "Ubicar Zona ",
    save: "Guardar Cambios",
    zone: "Zona",
    site: "Sitio",
    controller: "Controlador",
    buttonPrompt: "¿Listo?",
    sortByLocationButton: "Ordenar por Ubicación",
    sortByLocationMessage: "Sitios más cercanos aparecerán primero",
    sortByNameButton: "Ordenar por Nombre",
    sortByNameMessage: "Sitios aparecerán A-Z por nombre",
    noData: "No hay Data",
    daysOfWeek: {
      sun: "Domingo",
      mon: "Lunes",
      tue: "Martes",
      wed: "Miercoles",
      thurs: "Jueves",
      fri: "Viernes",
      sat: "Sabado"
    },
    months: {
      jan: "Enero",
      feb: "Febrero",
      mar: "Marzo",
      apr: "Abril",
      may: "Mayo",
      jun: "Junio",
      jul: "Julio",
      aug: "Agosto",
      sep: "Septiembre",
      oct: "Octubre",
      nov: "Noviembre",
      dec: "Diciembre",
    },
    programs: {
      a: "A",
      b: "B",
      c: "C",
      d: "D"
    }
  },
  login: {
    text: "Porfavor Inicie Sesion",
    loginButton: "Iniciar Sesion",
    retryButton: "Reintentar",
    email: "Email",
    password: "Password",
    disclaimer: "Si usted aún no tiene una cuenta, porfavor diríjase a",
    disclaimerCont: "y registrese.",
    error: "Inicio de Sesion fallido",
    errorMessage: "Porfavor verifique su email y contraseña"
  },
  sites: {
    title: "Sus Sitios",
    sortByLocation: "ordenado por ubicación",
    sortByName: "ordenado por nombre",
    locationUnit: "mi",
    controllerUnit: "controlador",
    faultUnit: "fallo"
  },
  menu: {
    title: "Opciones",
    sortTitle: "Ordenar Opciones",
    logoutButton: "Cerrar Sesión",
    logoutMessage: "Introduzca su email y contraseña para volver a iniciar sesión",
    syncButton: "Sincronizar Sitios",
    syncMessage: "Refrescar la última información de nuestros servidores",
    sortButton: "Ordenar Sitios",
    sortMessage: "Cambiar la secuencia de orden para la lista de sitios",
    feedbackButton: "Enviar Comentarios",
    feedbackMessage: "Envíenos comentarios sobre esta app",
    launchButton: "Lanzar Sitio Completo",
    launchMessage: "Abra el website Smartlink en un navegador web",
    version: "Version",
    advance: {
      title: "Opciones Avanzadas",
      commLogButton: "Registro de Comunicaciones",
      commLogMessage: "Ver comandos actualmente ejecutando y recientes",
      syncButton: "Re-sincronizar",
      syncMessage: "Refrescar con la última información de nuestros servidores",
      sendButton: "Enviar",
      sendMessage: "Transmitir sus configuraciones a su dispositivo Smartlink",
      receiveButton: "Recibir",
      receiveMessage: "Obtener las ultimas configuraciones de su dispositivo SmartLink"
    }
  },
  controllers: {
    title: "Controladores"
  },
  controllerOptions: {
    title: "Acciones",
    runProgram: "Ejecutar Programa",
    runZone: "Ejecutar Zona",
    locateValve: "Ubicar Valvula",
    walkSite: "Caminar Sitio",
    controlProgram: "Programacion del Controlador",
    stopButton: "Detener Todo",
    controllerTitle: "Detalles de Controlador",
    systemStatus: "Estado del Sistema",
    wateringMode: "Modo de Regado",
    rainMode: "LLuvia/Congelado",
    rainStatusActive: "Activo",
    rainStatusBypass: "Bypass",
    waterMode: "Clima",
    clearFaults: "Limpiar Fallos"
  },
  selectProgram: {
    headerTitle: "Seleccionar Programa",
    subTitle: "Seleccione un Programa",
    programA: "Ejecutar Programa A",
    programB: "Ejecutar Programa B",
    programC: "Ejecutar Programa C",
    programD: "Ejecutar Programa D"
  },
  selectZone: {
      title: "Seleccionar  una Zona",
      subInspectionZone: "Seleccionar una Zona para Inspeccionar",
      error: "No hay zonas establecidas para este controlador"
  },
  confirmProgram: {
    subTitle: "Confirmar Programa",
  },
  runZone: {
    subTitle: "Seleccione una Zona para Ejecutar",
  },
  confirmZone: {
    subTitle: "Confirmar Zona",
    zonePrompt: "Estamos a punto de ejecutar",
    timePrompt: "por esta cantidad de tiempo",
    timeUnit: "HH:MM"
  },
  locateValve: {
    subTitle: "Seleccione una Zona a ubicar"
  },
  confirmValue: {
    subTitle: "Confirmar Zona",
    controllerPrompt: "A punto de ejecutar ubicadores de valvula",
    valvePrompt: "El agua debe estar apagada en el dispositivo de retroceso o válvula de aislamiento flujo arriba de la válvula de la zona para poder usar plenamente la función Ubicador de Válvula del controlador de riego de SmartLine."
  },
  walkSite: {
    subTitle: "Caminar Sitio",
    zoneButton: "Saltar a Zona",
    startButton: "Iniciar",
    stopButton: "Detener",
    configure: "Configurar Auto-Ajuste",
    zonePhoto: "Añadir Foto de Zona"
  },
  programming: {
    basic: "Configuraciones Basicas",
    smart: "Smart Settings",
    basicMessage: "Editar hora/fecha y configuraciones de estado",
    program: "Configuraciones de Programa",
    programMessage: "Editar horarios de programa",
    flow: "Configuraciones de flujo",
    flowMessage: "Editar configuraciones de flujo",
    advance: "Configuraciones avanzadas",
    advanceMessage: "Editar programación avanzada del controlador",
    edit: "Editar Zonas",
    editMessage: "Editar nombre e imagen de zonas",
    flowRateGPM: 'Tasa de Flujo GPM',
    editZone: "Editar Zona"
  },
  basicSettings: {
    subTitle: "Configuraciones Basicas",
    date: "Fecha",
    time: "Hora",
    timeZone: "Zona Horaria del Controlador",
    runStatus: "Estado de Ejecucion",
    waterMode: "Modo de Regado",
    rainMode: "Lluvia/Congelado",
    runStatus1: "Ejecutar",
    runStatus2: "Remoto Apagado",
    waterMode1: "Basico (Standard)",
    waterMode2: "Inteligente (Auto-Ajuste)"
  },
  programSettings: {
    title: "Configuraciones de Programa",
    dayTime: "Dias y Horas de Inicio",
    dayMessage: "Editar dias de regado y horas de inicio",
    zoneTime: "Horas de Ejecucion de Zona",
    zoneMessage: "Editar tiempos de ejecuciion de zona por programa",
    programSmart: "Programacion inteligente",
    programMessage: "Editar programacion inteligente",
    omitTime: "Omitir Dias y Horas",
    omitMessage: "Editar omitir horas/dias/fechas",
    seasonalAdjust: "Ajuste estacional",
    seasonalMessage: "Editar  % mensual estacional por programa"
  },
  smartProgramming: {
    postalCode: "Codigo Postal",
    latitude: "Latitud"
  },
  omit: {
    title: "Omitir Dias y Horas",
    specificTime: "Omitir Horas Especificas:",
    specificDay: "Omitir Dias de la Semana:",
    specificDates: "Omitir Fechas de Evento:"
  },
  inspections: {
    inspection: "Inspección ",
    new: "Nueva Inspección",
    create: "Crear Inspección",
    title: "Titulo de la Inspección",
    titlePlaceholder: "Introducir un titulo",
    subTitle: "Seleccionar una Inspección",
    date: "Fecha y Hora",
    type: "Tipo de Inspección",
    start: "Iniciar Inspección",
    schedule: "Inspección Programada",
    service: "Llamada  de Servicio",
    edit: "Editar Opciones de Inspección",
    select: "Seleccionar Zona a Inspeccionar",
    general: "General",
    seasonal: "Estaciona",
    omit: "Omitir"
  },
  generalInspection: {
    date: "Fecha",
    inspector: "Inspector",
    type: "Tipo",
    compliant: "Queja",
    function: "¿Funcion Sensor R/F?",
    waterPressure: "Presion de Agua",
    name: "Nombre",
    location: "Ubicacion",
    model: "Modelo",
    airCard: "Aircard",
    slw: "SLW"
  },
  programInspection: {
    settings: "Configuraciones de Dia de Regado",
    daysOfWeek: {
      sun: "D",
      mon: "L",
      tue: "M",
      wed: "M",
      thurs: "J",
      fri: "V",
      sat: "S"
    }
  },
  emailInspection: {
    title: "Inspección de Email",
    subTitle: "Editar Opciones de Inspección",
    discliamer: "¿A qué email(s) le gustaría enviar las inspecciones?",
    fileType: "Qué tipo de archivo le gustaría adjuntar:",
    file: {
      pdf: "PDF",
      xls: "XLS"
    },
    includePhotos: "¿Quiere incluir fotos?",
    photos: {
      yes: "Si",
      no: "No"
    }
  },
  inspectionDetails: {
    runTimes: "Programar  Tiempos de Ejecucion de Zona",
    photos: {
      view: "Ver Fotos"
    },
    currentZone: "Zona Actual",
    runZone: "Programar  Tiempos de Ejecucion de Zona",
    zoneName: "Nombre de Zona",
    area: "% de Area",
    sprinklerType: "Tipo de Rociador",
    plantType: "Tipo de Planta",
    soilType: "Tipo de Suelo",
    moreLess: "Mas/Menos",
    valveSize: "Tamaño de Valvula",
    gpm: "GPM",
    photo: "Fotos",
    upload: "Subir",
    update: "Actualizando  Inspección...",
    programs: "Programas",
    valveStatus: "Estado de Valvula",
    valveChoices: {
      pass: "Pasar",
      fail: "Falla"
    },
    image: "Imagen",
    cloggedNozzle: "Boquilla Obstruida",
    blockedHead: "Cabeza Bloqueada",
    brokenHead: "Cabeza Rota",
    raiseHead: "Subir Cabeza",
    lowerHead: "Bajar Cabeza",
    replaceHead: "Reemplazar Cabeza",
    brokenLateral: "Lateral Roto",
    brokenMain: "Principal Roto",
    inOutScope: "Dentro/Fuera de Alcance",
    estimatedCost: "Costo Estimado",
    comments: "Comentarios"
  }
};