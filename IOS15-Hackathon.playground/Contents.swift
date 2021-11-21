import UIKit

protocol UserData {
  var userName: String { get }                //Имя пользователя
  var userCardId: String { get }              //Номер карты
  var userCardPin: Int { get }                //Пин-код
  var userCardBalance: Float { get set }      //Баланс карты
  var userBankDeposit: String { get }         //Банковский счет
  var userDepositBalance: Float { get set }   //Номер банковского счета
  var userPhoneNumber: String { get }         //Номер телефона
  var userPhoneBalance: Float { get set }     //Баланс телефона
  var userCash: Float { get set }             //Наличные
}

protocol BankApi {
    func showUserCardBalance()                          // Показать баланс на карте
    func showUserDepositBalance()                       // Показать баланс на депозите
    func showUserToppedUpMobilePhoneCash(cash: Float)   // Показать пользователю баланс пополненного телефона
    func showUserToppedUpMobilePhoneCard(card: Float)   // Показать пользователю баланс пополненной карты
    func showWithdrawalCard(cash: Float)                // Показать сумму, доступную для снятия с карты
    func showWithdrawalDeposit(cash: Float)             // Показать сумму, доступную для снятия со счета
    func showTopUpCard(cash: Float)                     // Показать сумму пополнения карты "На карту № зачислено ... р."
    func showTopUpDeposit(cash: Float)                  // Показать сумму пополнения счета "На счет № зачислено ... р."
    func showError(error: TextErrors)                   // Показать ошибки

    func checkUserPhone(phone: String) -> Bool          // Проверка телефона пользователя
    func checkMaxUserCash(cash: Float) -> Bool          // Проверить максимально возможную сумму для снятия
    func checkMaxUserCard(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
 
    mutating func topUpPhoneBalanceCash(pay: Float)     // Пополнить баланс телефона наличными
    mutating func topUpPhoneBalanceCard(pay: Float)     // Пополнить баланс телефона картой
    mutating func getCashFromDeposit(cash: Float)       // Снять деньги со счета
    mutating func getCashFromCard(cash: Float)          // Снять деньги с карты
    mutating func putCashDeposit(topUp: Float)          // Положить деньги на счёт
    mutating func putCashCard(topUp: Float)             // Положить деньги на карту
}

enum UserActions {
    case balanceCardRequest                                             // запрос баланса по карте;
    case balanceDepositRequest                                          // запрос баланса на банковском депозите;
    case topUpPhoneBalanceCash(pay: Float)                              // Пополнить баланс телефона наличными
    case topUpPhoneBalanceCard(pay: Float)                              // Пополнить баланс телефона картой
    case getCashFromDeposit(cash: Float)                                // Снять деньги со счета
    case getCashFromCard(cash: Float)                                   // Снять деньги с карты
    case putCashDeposit(topUp: Float)                                   // Положить деньги на счёт
    case putCashCard(topUp: Float)                                      // Положить деньги на карту
}                                                     // Действия, которые пользователь может выбирать в банкомате (имитация кнопок)

enum DescriptionTypesAvailableOperations: String {
    case AuthorizationSuccessfull = "Авторизация успешно пройдена"
    case OperationSelect = "Выберите операцию. Для выполнения операций пополнения/снятия/оплаты необходимо указать источник денежных средств"
    case PaymentMethodIsNotNil = "Для выполнения операции запроса баланса необходимо оставить поле источник пополнения/снятия/оплаты пустым"
    case PaymentMethodCashIsWright = "Для выполнения данной операции необходимо выбрать \"Наличные\" в качестве источника пополнения/снятия/оплаты. Измените источник и повторите запрос"
    case PaymentMethodCardIsWright = "Для выполнения данной операции необходимо выбрать \"Карта\" в качестве источника пополнения/снятия/оплаты. Измените источник и повторите запрос"
    case PaymentMethodDepositIsWright = "Для выполнения данной операции необходимо выбрать \"Счет\" в качестве источника снятия наличных. Измените источник и повторите запрос"
    
    case balanceCardRequest = "Выполняется операция запроса баланса карты."
    case balanceDepositRequest = "Выполняется операция запроса баланса счета."
    case topUpPhoneBalanceCash = "Выполняется операция пополнение счета мобильного телефона наличными"
    case topUpPhoneBalanceCard = "Выполняется операция пополнение счета мобильного телефона картой"
    case getCashFromDeposit = "Выполняется операция снятия наличных со счета"
    case getCashFromCard = "Выполняется операция снятия наличных с карты"
    case putCashCard = "Выполняется операция пополнения карты наличными"
    case putCashDeposit = "Выполняется операция пополнения счета наличными"
}                     // Виды операций, выбранных пользователем (подтверждение выбора)

enum PaymentMethod {
    case byCash
    case byCard
    case byDeposit // Наличкой, картой, со счета
}                                                   // Способ оплаты/пополнения наличными, картой или через депозит

enum TextErrors: String {
    case userPhone = "Указан неверный номер мобильного телефона"
    case maxUserCash = "Не хватает наличных"
    case maxUserCard = "Недостаточно средств на карте"
    case maxUserDeposit = "Недостаточно средств на счете"
    case сurrentUser = "Ошибка авторизации"
}                                              // Возможные ошибки при работе с банкоматом

class User: UserData {
    var userName: String                 //Имя пользователя
    var userCardId: String               //Номер карты
    var userCardPin: Int                 //Пин-код
    var userCardBalance: Float           //Баланс карты
    var userBankDeposit: String           //Банковский счет
    var userDepositBalance: Float        //Баланс на счете
    var userPhoneNumber: String          //Номер телефона
    var userPhoneBalance: Float          //Баланс телефона
    var userCash: Float                  //Наличные
   
    init(name userName: String, cardId userCardId: String, cardPin userCardPin: Int, cardBalance userCardBalance: Float, bankDeposit userBankDeposit: String, depositBalance userDepositBalance: Float, phone userPhoneNumber: String, phoneBalance userPhoneBalance: Float, cash userCash: Float) {
        self.userName = userName
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.userCardBalance = userCardBalance
        self.userBankDeposit = userBankDeposit
        self.userDepositBalance = userDepositBalance
        self.userPhoneNumber = userPhoneNumber
        self.userPhoneBalance = userPhoneBalance
        self.userCash = userCash
    }
}                                                 // Создаем класс пользователя, удовлетворяющий протоколу UserData

class Bank: BankApi {
    var user: User
    init(user: User) {
        self.user = user
    }
    
    func showUserCardBalance() {                                            // Показать баланс на карте
        print("Карта \(user.userCardId) Доступно  \(user.userCardBalance) р.")
    }
    func showUserDepositBalance() {                                         // Показать баланс на депозите
        print("Счет \(user.userBankDeposit) Доступно \(user.userDepositBalance) р.")
    }
    func showUserToppedUpMobilePhoneCash(cash: Float) {                     // Показать пользователю баланс пополненного телефона
        print("Поступил платеж \(cash) р. Баланс \(user.userPhoneBalance) р.")
    }
    func showUserToppedUpMobilePhoneCard(card: Float) {                     // Показать пользователю баланс пополненной карты
        print("Пополнение \(card) р. Баланс \(user.userPhoneBalance) р.")
    }
    func showWithdrawalCard(cash: Float) {                                  // Снятие наличных с карты ... р. Доступно ... р.
        print("Снятие наличных с карты \(cash) р. Доступно \(user.userCardBalance) р.")
    }
    func showWithdrawalDeposit(cash: Float) {                               // Снятие наличных со счета ... р. Доступно ... р.
        print("Снятие наличных со счета \(cash) р. Доступно \(user.userDepositBalance) р.")
    }
    func showTopUpCard(cash: Float){                                        // Внесение наличных на карту. Зачислено ... р. Доступно ... р.
        print("Внесение наличных на карту. Зачислено \(cash) р. Доступно \(user.userCardBalance) р.")
    }
    func showTopUpDeposit(cash: Float) {                                    // Внесение наличных на счет. Зачислено ... р. Доступно ... р.
        print("Внесение наличных на счет. Зачислено \(cash) р. Доступно \(user.userDepositBalance) р.")
    }
    func showError(error: TextErrors){                                      // Показать ошибки
        print(error.rawValue)
    }

    func checkUserPhone(phone: String) -> Bool {                            // Проверка телефона пользователя
        if phone == user.userPhoneNumber {
            return true
        } else {
            return false
        }
    }
    func checkMaxUserCash(cash: Float) -> Bool {                            // Проверить максимально возможную сумму для внесения
        if cash < user.userCash {
            return true
        } else {
            return false
        }
    }
    func checkMaxUserCard(withdraw: Float) -> Bool {                        // Проверить максимально возможную сумму для снятия
        if withdraw < user.userCardBalance {
            return true
        } else {
            return false
        }
    }
    func checkMaxUserDeposit(withdraw: Float) -> Bool {                        // Проверить максимально возможную сумму для снятия
        if withdraw < user.userDepositBalance {
            return true
        } else {
            return false
        }
    }
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {   // Проверка текущего пользователя
        if userCardId == user.userCardId && userCardPin == user.userCardPin {
            return true
        } else {
            return false
        }
    }
 
    func topUpPhoneBalanceCash(pay: Float) {     // Пополнить баланс телефона наличными
        user.userPhoneBalance += pay
        user.userCash -= pay
    }
    func topUpPhoneBalanceCard(pay: Float) {     // Пополнить баланс телефона картой
        user.userPhoneBalance += pay
        user.userCardBalance -= pay
    }
    func getCashFromDeposit(cash: Float) {       // Снять деньги со счета
        user.userCash += cash
        user.userDepositBalance -= cash
    }
    func getCashFromCard(cash: Float) {          // Снять деньги с карты
        user.userCash += cash
        user.userCardBalance -= cash
    }
    func putCashDeposit(topUp: Float) {          // Положить деньги на счёт
        user.userCash -= topUp
        user.userDepositBalance += topUp
    }
    func putCashCard(topUp: Float) {             // Положить деньги накарту
        user.userCash -= topUp
        user.userCardBalance += topUp
    }
    
    func showUserGreetings() {
        print("Добрый день, \(user.userName)!")
    }
}                                                  // Создаем класс Банк, удовлетворяющий протоколу BankApi

//class ATM2 {
//private let userCardId: String // Карта, которую вставляет пользователь
//private let userCardPin: Int // Пин-код, который вводит пользователь
//private var someBank: Bank
//private let action: UserActions
//private let paymentMethod: PaymentMethod?
//
//init(userCardId: String, userCardPin: Int, someBank: Bank, action: UserActions, paymentMethod: PaymentMethod? = nil) {
//self.userCardId = userCardId
//self.userCardPin = userCardPin
//self.someBank = someBank
//self.action = action
//self.paymentMethod = paymentMethod
//sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod)
//}
//public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
//if someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin) {
//    print(DescriptionTypesAvailableOperations.AuthorizationSuccessfull.rawValue)
//    someBank.showUserGreetings()
//    print(DescriptionTypesAvailableOperations.OperationSelect.rawValue)
//    if paymentMethod == nil {
//        switch actions {
//        case .balanceCardRequest:   // Показать баланс на карте
//            print(DescriptionTypesAvailableOperations.balanceCardRequest.rawValue)
//            someBank.showUserCardBalance()
//        case .balanceDepositRequest:    // Показать баланс на депозите
//            print(DescriptionTypesAvailableOperations.balanceDepositRequest.rawValue)
//            someBank.showUserDepositBalance()
//        default:
//            print(DescriptionTypesAvailableOperations.PaymentMethodIsNil.rawValue)
//        }
//    } else {
//        switch payment {
//        case .none:
//            print(DescriptionTypesAvailableOperations.PaymentMethodIsWrong.rawValue)
//        case .byCash:
//            switch actions {
//            case .topUpPhoneBalanceCash(pay: let pay):  // Пополнить баланс телефона наличными
//                print(DescriptionTypesAvailableOperations.topUpPhoneBalanceCash.rawValue)
//                if someBank.checkMaxUserCash(cash: pay) {
//                    someBank.topUpPhoneBalanceCash(pay: pay)
//                    someBank.showUserToppedUpMobilePhoneCash(cash: pay)
//                } else {
//                    someBank.showError(error: .maxUserCash)
//                }
//            case .putCashDeposit(topUp: let topUp): // Положить деньги на счёт
//                print(DescriptionTypesAvailableOperations.putCashDeposit.rawValue)
//                if someBank.checkMaxUserCash(cash: topUp) {
//                    someBank.putCashDeposit(topUp: topUp)
//                    someBank.showTopUpDeposit(cash: topUp)
//                } else {
//                    someBank.showError(error: .maxUserCash)
//                }
//            case .putCashCard(topUp: let topUp):    // Положить деньги на карту
//                print(DescriptionTypesAvailableOperations.putCashCard.rawValue)
//                if someBank.checkMaxUserCash(cash: topUp) {
//                    someBank.putCashCard(topUp: topUp)
//                    someBank.showTopUpCard(cash: topUp)
//                } else {
//                    someBank.showError(error: .maxUserCash)
//                }
//            default:
//                print(DescriptionTypesAvailableOperations.PaymentMethodIsWrong.rawValue)
//            }
//        case .byDeposit:
//            switch actions {
//            case .getCashFromDeposit(cash: let cash):   // Снять деньги со счета
//                print(DescriptionTypesAvailableOperations.getCashFromDeposit.rawValue)
//                if someBank.checkMaxUserDeposit(withdraw: cash) {
//                    someBank.getCashFromDeposit(cash: cash)
//                    someBank.showWithdrawalDeposit(cash: cash)
//                } else {
//                    someBank.showError(error: .maxUserDeposit)
//                }
//            default:
//                print(DescriptionTypesAvailableOperations.PaymentMethodIsWrong.rawValue)
//            }
//        case .byCard:
//            switch actions {
//            case .topUpPhoneBalanceCard(pay: let pay):  // Пополнить баланс телефона картой
//                print(DescriptionTypesAvailableOperations.topUpPhoneBalanceCard.rawValue)
//                if someBank.checkMaxUserCard(withdraw: pay) {
//                    someBank.topUpPhoneBalanceCard(pay: pay)
//                    someBank.showUserToppedUpMobilePhoneCard(card: pay)
//                } else {
//                    someBank.showError(error: .maxUserCard)
//                }
//            case .getCashFromCard(cash: let cash):  // Снять деньги с карты
//                print(DescriptionTypesAvailableOperations.getCashFromCard.rawValue)
//                if someBank.checkMaxUserCard(withdraw: cash) {
//                    someBank.getCashFromCard(cash: cash)
//                    someBank.showWithdrawalCard(cash: cash)
//                } else {
//                    someBank.showError(error: .maxUserCard)
//                }
//            default:
//                print(DescriptionTypesAvailableOperations.PaymentMethodIsWrong.rawValue)
//            }
//        }
//    }
//} else {
//    someBank.showError(error: .сurrentUser)
//}
//}
//}

class ATM {
private let userCardId: String // Карта, которую вставляет пользователь
private let userCardPin: Int // Пин-код, который вводит пользователь
private var someBank: Bank
private let action: UserActions
private let paymentMethod: PaymentMethod?

init(userCardId: String, userCardPin: Int, someBank: Bank, action: UserActions, paymentMethod: PaymentMethod? = nil) {
    self.userCardId = userCardId
    self.userCardPin = userCardPin
    self.someBank = someBank
    self.action = action
    self.paymentMethod = paymentMethod
    sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod)
}
public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
    if someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin) {
        print(DescriptionTypesAvailableOperations.AuthorizationSuccessfull.rawValue)
        someBank.showUserGreetings()
        print(DescriptionTypesAvailableOperations.OperationSelect.rawValue)
        
        switch actions {
        case .balanceCardRequest:                                                                   // Показать баланс на карте
            print(DescriptionTypesAvailableOperations.balanceCardRequest.rawValue)
            if payment == nil {
                someBank.showUserCardBalance()
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodIsNotNil.rawValue)
            }
           
        case .balanceDepositRequest:                                                                // Показать баланс на депозите
            print(DescriptionTypesAvailableOperations.balanceDepositRequest.rawValue)
            if payment == nil {
            someBank.showUserDepositBalance()
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodIsNotNil.rawValue)
            }

        case .topUpPhoneBalanceCash(pay: let pay):                                                  // Пополнить баланс телефона наличными
            print(DescriptionTypesAvailableOperations.topUpPhoneBalanceCash.rawValue)
            if payment == .byCash {
                if someBank.checkMaxUserCash(cash: pay) {
                    someBank.topUpPhoneBalanceCash(pay: pay)
                    someBank.showUserToppedUpMobilePhoneCash(cash: pay)
                } else {
                    someBank.showError(error: .maxUserCash)
                }
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodCashIsWright.rawValue)
            }
        
        case .topUpPhoneBalanceCard(pay: let pay):                                                  // Пополнить баланс телефона картой
            print(DescriptionTypesAvailableOperations.topUpPhoneBalanceCard.rawValue)
            if payment == .byCard {
                if someBank.checkMaxUserCard(withdraw: pay) {
                    someBank.topUpPhoneBalanceCard(pay: pay)
                    someBank.showUserToppedUpMobilePhoneCard(card: pay)
                } else {
                    someBank.showError(error: .maxUserCard)
                }
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodCardIsWright.rawValue)
            }

        case .getCashFromDeposit(cash: let cash):                                                   // Снять деньги со счета
            print(DescriptionTypesAvailableOperations.getCashFromDeposit.rawValue)
            if payment == .byDeposit {
                if someBank.checkMaxUserDeposit(withdraw: cash) {
                    someBank.getCashFromDeposit(cash: cash)
                    someBank.showWithdrawalDeposit(cash: cash)
                } else {
                    someBank.showError(error: .maxUserDeposit)
                }
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodDepositIsWright.rawValue)
            }

        case .getCashFromCard(cash: let cash):                                                      // Снять деньги с карты
            print(DescriptionTypesAvailableOperations.getCashFromCard.rawValue)
            if payment == .byCard {
                if someBank.checkMaxUserCard(withdraw: cash) {
                    someBank.getCashFromCard(cash: cash)
                    someBank.showWithdrawalCard(cash: cash)
                } else {
                    someBank.showError(error: .maxUserCard)
                }
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodCardIsWright.rawValue)
            }

        case .putCashDeposit(topUp: let topUp):                                                     // Положить деньги на счёт
            print(DescriptionTypesAvailableOperations.putCashDeposit.rawValue)
            if payment == .byCash {
                if someBank.checkMaxUserCash(cash: topUp) {
                    someBank.putCashDeposit(topUp: topUp)
                    someBank.showTopUpDeposit(cash: topUp)
                } else {
                    someBank.showError(error: .maxUserCash)
                }
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodCashIsWright.rawValue)
            }

        case .putCashCard(topUp: let topUp):                                                         // Положить деньги на карту
            print(DescriptionTypesAvailableOperations.putCashCard.rawValue)
            if payment == .byCash {
                if someBank.checkMaxUserCash(cash: topUp) {
                    someBank.putCashCard(topUp: topUp)
                    someBank.showTopUpCard(cash: topUp)
                } else {
                    someBank.showError(error: .maxUserCash)
                }
            } else {
                print(DescriptionTypesAvailableOperations.PaymentMethodCashIsWright.rawValue)
            }
        }
    } else {
        someBank.showError(error: .сurrentUser)
    }
}
}

// Создаем экземпляр пользователя
let vasya = User (name: "Василий", cardId: "4000 5000 6000 7000", cardPin: 1234, cardBalance: 35000, bankDeposit: "40817864378549861204", depositBalance: 60000, phone: "8(985)123-45-67", phoneBalance: 450, cash: 3000)

print("""
Наш пользователь \(vasya.userName) в начале своего пути имеет:
- карточку с номером \(vasya.userCardId) (Пин-код от карты - \(vasya.userCardPin)) на которой \(vasya.userCardBalance) р.,
- банковский счёт № \(vasya.userBankDeposit), на котором \(vasya.userDepositBalance) р.,
- телефон \(vasya.userPhoneNumber) с \(vasya.userPhoneBalance) р. на балансе
и \(vasya.userCash) р. в кармане наличными

""")                                                           // Рассказываем о прекрасном парне, что будет тыкать наш банкомат

print("\n-----\"Проверка баланса с ошибкой при наборе пин-кода\"-----")
ATM(userCardId: "4000 5000 6000 7000", userCardPin: 1235, someBank: Bank(user: vasya), action: .balanceCardRequest)

print("\n-----\"Проверка баланса с указанием платежного способа\"-----")
ATM(userCardId: "4000 5000 6000 7000", userCardPin: 1234, someBank: Bank(user: vasya), action: .balanceCardRequest, paymentMethod: .byCash)

print("\n-----\"Проверка баланса карты\"-----")
ATM(userCardId: "4000 5000 6000 7000", userCardPin: 1234, someBank: Bank(user: vasya), action: .balanceCardRequest)

print("\n-----\"Проверка баланса счета\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .balanceDepositRequest)

print("\n-----\"Попытка снять с карты суммы, превышающей баланс на карте\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .getCashFromCard(cash: 40000), paymentMethod: .byCard)

print("\n-----\"Снятие наличных с карты\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .getCashFromCard(cash: 15000), paymentMethod: .byCard)

print("\n-----\"Снятие наличных со счета с ошибкой в источнике снятия\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .getCashFromDeposit(cash: 5000), paymentMethod: .byCard)

print("\n-----\"Снятие наличных со счета\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .getCashFromDeposit(cash: 5000), paymentMethod: .byDeposit)

print("\n-----\"Пополнение телефона с карты без ууказания источника пополнения\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .topUpPhoneBalanceCard(pay: 1000))

print("\n-----\"Пополнение телефона с карты\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .topUpPhoneBalanceCard(pay: 1000), paymentMethod: .byCard)

print("\n-----\"Пополнение телефона наличкой\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .topUpPhoneBalanceCash(pay: 2000), paymentMethod: .byCash)

print("\n-----\"Внесение наличных на счёт\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .putCashDeposit(topUp: 300), paymentMethod: .byCash)

print("\n-----\"Внесение наличных на карту\"-----")
ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .putCashCard(topUp: 300), paymentMethod: .byCash)
