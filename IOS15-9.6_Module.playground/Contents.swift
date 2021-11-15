import UIKit

// Режимы работы
var driveMode: String

driveMode = "auto"
switch driveMode {
case "auto":
    print("Включен автопилот. Режим автопилота может быть опасен, следите за движением автомобиля")
case "manual":
    print("Автомобиль в режиме ручного управления")
default:
    print("Режим работы не выбран")
}

// Характеристики автомобиля
let autoWeight: UInt16 = 2108 //Масса, кг
let autoLenght: UInt16 = 4976 //Длина, мм
let autoWidth: UInt16 = 1963 //Ширина, мм
let autoHeight: UInt16 = 1435 //Высота, мм
let autoWheelLenght: UInt16 = 2959 //Колесная база, мм
let autoClearance: Float = 154.9 //Клиренс, мм
let autoTrunkVolume: UInt16 = 900 //Объем багажника в литрах

// Функционал авто
var autoMusic: String //Управление музыкой (громкость, радиостанция)
var autoSunfloor: Int //Управление люком (степень открытия в %)
var autoFanSpeed: Int //Скорость вентилятора обдува
var autoDriverSeatTemp: Int //Климатические установки для водительского места
var dayLight: Int // сигнал датчика света день/ночь

// Изменяемые параметры
var musicVolume: Int // уровень громкости аудиосистемы
var radioStation: Float // радиостанция
var positionSunfloor: Int // положение люка, %
var fanSpeed: Int // скорость вентилятора, % можности
var seatTemp: Int
var dayRunninglights: Bool //Дневные ходовые огни
var lowHeadlights: Bool // состояние ближнего света

autoMusic = "on" // состояние аудиосистемы
musicVolume = 50
radioStation = 96.8
switch autoMusic {
case "on":
    print("Аудиосистема включена. Частота \(radioStation) МГц. Громкость \(musicVolume) %")
default:
    print("Аудиосистема выключена")
}

autoSunfloor = 1 // выбор положения открытия люка
switch autoSunfloor {
case 1:
    positionSunfloor = autoSunfloor * 10
    print("Люк открыт на \(positionSunfloor) градусов")
case 2:
    positionSunfloor = autoSunfloor * 10
    print("Люк открыт на \(positionSunfloor) градусов")
case 3:
    positionSunfloor = autoSunfloor * 10
    print("Люк открыт на \(positionSunfloor) градусов")
default:
    positionSunfloor = 0
    print("Люк закрыт")
}

autoFanSpeed = 1 // выбор режима работы вентилятора отопителя
switch autoFanSpeed {
case 1:
    fanSpeed = autoFanSpeed * 25
    print("Обдув установлен на \(fanSpeed)% мощности")
case 2:
    fanSpeed = autoFanSpeed * 25
    print("Обдув установлен на \(fanSpeed)% мощности")
case 3:
    fanSpeed = autoFanSpeed * 25
    print("Обдув установлен на \(fanSpeed)% мощности")
case 4:
    fanSpeed = autoFanSpeed * 25
    print("Обдув установлен на \(fanSpeed)% мощности")
default:
  fanSpeed = 0
    print("Климатическая система отключена")
}

autoDriverSeatTemp = 23
switch autoDriverSeatTemp {
case autoDriverSeatTemp where (autoDriverSeatTemp > 17) && (autoDriverSeatTemp < 33):
    seatTemp = autoDriverSeatTemp
    print("Климатическая установка места водителя включена на \(seatTemp) град.")
default:
    print("Установлена недопустимая температура")
}

dayLight = 1
switch dayLight {
case 0:
    lowHeadlights = true
    dayRunninglights = false
    print("Работают фары ближнего света")
case 1:
    lowHeadlights = false
    dayRunninglights = true
    print("Включены дневные ходовые огни")
default:
    lowHeadlights = false
    dayRunninglights = false
    print("Освещение выключено")
}

//Ошибки системы
enum AutoError: Error {
    case gpsLost // потерян сигнад GPS
    case lowBattery // низкая батарея
    case checkEngine // автомобиль неисправен
    case lowPressure // низкое давление в шинах
}
var gpsLost: Bool = false
var lowBattery: Bool = false
var checkEngine: Bool = false
var lowPressure: Bool = false

do {
    if gpsLost {
        throw AutoError.gpsLost
    }
 
    if lowBattery {
        throw AutoError.lowBattery
    }
 
    if checkEngine {
        throw AutoError.checkEngine
    }
    if lowPressure {
        throw AutoError.lowPressure
    }
} catch AutoError.gpsLost {
    print("Потерян сигнал GPS! Переключитесь на ручное управление")
} catch AutoError.lowBattery {
    print("Низкий уровень заряда батареи! Найдите ближайшую станцию для подзарядки")
} catch AutoError.checkEngine {
    print("Критическая неисправность системы! Для предупреждения поломки необходимо остановиться, заглушить двигатель и проследовать на эвакуаторе до ближайшей станции технического обслуживания")
} catch AutoError.lowPressure {
    print("Низкое давление в шинах. Проверьте шины перед дальнейшим движением!")
}
