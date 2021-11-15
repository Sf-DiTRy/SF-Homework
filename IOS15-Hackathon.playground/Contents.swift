import UIKit
import Darwin

protocol UserData {
  var userName: String { get }                //Имя пользователя
  var userCardId: String { get }              //Номер карты
  var userCardPin: Int { get }                //Пин-код
  var userPhone: String { get }               //Номер телефона
  var userCash: Float { get set }             //Наличные
  var userBankDepositNumber: String { get }   //Номер банковского счета
  var userBankDeposit: Float { get set }      //Банковский счет
  var userPhoneBalance: Float { get set }     //Баланс телефона
  var userCardBalance: Float { get set }      //Баланс карты
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
    mutating func putCashCard(topUp: Float)             // Положить деньги накарту
}

// Создаем класс пользователя, удовлетворяющий протоколу UserData
class User: UserData {
    var userName: String                 //Имя пользователя
    var userCardId: String               //Номер карты
    var userCardPin: Int                 //Пин-код
    var userPhone: String                //Номер телефона
    var userCash: Float                  //Наличные
    var userBankDepositNumber: String    //Номер банковского счета
    var userBankDeposit: Float           //Банковский счет
    var userPhoneBalance: Float          //Баланс телефона
    var userCardBalance: Float           //Баланс карты
   
    init(name userName: String, cardId userCardId: String, cardPin userCardPin: Int, phone userPhone: String, cash userCash: Float, bankDepositNumber userBankDepositNumber: String, bankDeposit userBankDeposit: Float, phoneBalance userPhoneBalance: Float, cardBalance userCardBalance: Float) {
        self.userName = userName
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.userPhone = userPhone
        self.userCash = userCash
        self.userBankDepositNumber = userBankDepositNumber
        self.userBankDeposit = userBankDeposit
        self.userPhoneBalance = userPhoneBalance
        self.userCardBalance = userCardBalance
    }
}

// Создаем класс Банк, удовлетворяющий протоколу BankApi
class Bank: BankApi {
    var user: User
    init(user: User) {
        self.user = user
    }
    
    func showUserCardBalance() {                                            // Показать баланс на карте
        // Тут скоро будет код
    }
    func showUserDepositBalance() {                                         // Показать баланс на депозите
        // Тут скоро будет код
    }
    func showUserToppedUpMobilePhoneCash(cash: Float) {                     // Показать пользователю баланс пополненного телефона
        // Тут скоро будет код
    }
    func showUserToppedUpMobilePhoneCard(card: Float) {                     // Показать пользователю баланс пополненной карты
        // Тут скоро будет код
    }
    func showWithdrawalCard(cash: Float) {                                  // Показать сумму, доступную для снятия с карты
        // Тут скоро будет код
    }
    func showWithdrawalDeposit(cash: Float) {                               // Показать сумму, доступную для снятия со счета
        // Тут скоро будет код
    }
    func showTopUpCard(cash: Float){                                        // Показать сумму пополнения карты "На карту № зачислено ... р."
        // Тут скоро будет код
    }
    func showTopUpDeposit(cash: Float) {                                    // Показать сумму пополнения счета "На счет № зачислено ... р."
        // Тут скоро будет код
    }
    func showError(error: TextErrors){                                      // Показать ошибки
        // Тут скоро будет код
    }

    func checkUserPhone(phone: String) -> Bool {                            // Проверка телефона пользователя
        // Тут скоро будет код
        return true
    func checkMaxUserCash(cash: Float) -> Bool {                            // Проверить максимально возможную сумму для снятия
        // Тут скоро будет код
        return true
    }
    func checkMaxUserCard(withdraw: Float) -> Bool {
        // Тут скоро будет код
        return true
    }
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {   // Проверка текущего пользователя
        // Тут скоро будет код
        return true
    }
 
    func topUpPhoneBalanceCash(pay: Float) {     // Пополнить баланс телефона наличными
        // Тут скоро будет код
    }
    func topUpPhoneBalanceCard(pay: Float) {     // Пополнить баланс телефона картой
        // Тут скоро будет код
    }
    func getCashFromDeposit(cash: Float) {       // Снять деньги со счета
        // Тут скоро будет код
    }
    func getCashFromCard(cash: Float) {          // Снять деньги с карты
        // Тут скоро будет код
    }
    func putCashDeposit(topUp: Float) {          // Положить деньги на счёт
        // Тут скоро будет код
    }
    func putCashCard(topUp: Float) {             // Положить деньги накарту
        // Тут скоро будет код
    }
}

// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
    private let userCardId: String // Карта, которую вставляет пользователь
    private let userCardPin: Int // Пин-код, который вводит пользователь
    private var someBank: BankApi
    private let action: UserActions
    private let paymentMethod: PaymentMethod?
 
    public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
        // Тут скоро будет код
    }
    init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        self.action = action
        self.paymentMethod = paymentMethod
        sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod)
    }
}

// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case balanceRequest // запрос баланса по карте и на банковском депозите;
    case cashWithdrawal // снятие наличных с карты или банковского депозита;
    case cardReplenishment // пополнение карты и банковского депозита наличными;
    case phonePayment   // пополнение баланса телефона наличными или с карты.
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case chooseBalance = "Запрос баланса"
    case chooseCashWithdrawal = "Снятие наличных"
    case chooseCardReplenishment = "Пополнение счета"
    case choosePhonePayment = "Пополнение баланса телефона"
}

// Способ оплаты/пополнения наличными, картой или через депозит
enum PaymentMethod {
    case byCash, byCard, byDeposit // Наличкой, картой, со счета
}

// Возможные ошибки при работе с банкоматом
enum TextErrors: String {
    case noMoney = "Не хватает денег на счете"
    case wrongPin = "Не верный пин-код"
    case wrongSumm = "Ввведена некорректная сумма"
}

// Создаем экземпляр пользователя
let vasya = User (name: "Василий", cardId: "4000 5000 6000 7000", cardPin: 1234, phone: "8(985)123-45-67", cash: 10000, bankDepositNumber: "40817864378549861204", bankDeposit: 50000, phoneBalance: 650, cardBalance: 35000)

// Создаем экземпляр банкомата
//let atm = ATM(userCardId: vasya.userCardId, userCardPin: 1234, someBank: Bank(user: vasya), action: .balanceRequest)
//
//ATM(userCardId: "4000 5000 6000 7000", userCardPin: 1234, someBank: Bank(user: vasya), action: .balanceRequest, paymentMethod: nil)
