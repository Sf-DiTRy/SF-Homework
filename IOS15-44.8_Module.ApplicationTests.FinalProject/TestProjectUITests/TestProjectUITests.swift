//
//  TestProjectUITests.swift
//  TestProjectUITests
//
//  Created by SF on 01.06.2021.
//

import XCTest

class TestProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUIbyRecord() {
        let app = XCUIApplication()
        app.tables["TableView"]/*@START_MENU_TOKEN@*/.staticTexts["0"]/*[[".cells.matching(identifier: \"tableViewCell\")",".staticTexts[\"Иванов Иван\"]",".staticTexts[\"0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["FullNameLabel"]/*[[".otherElements[\"SecondVCView\"]",".staticTexts[\"Иванов Иван\"]",".staticTexts[\"FullNameLabel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.otherElements["SecondVCView"]/*@START_MENU_TOKEN@*/.swipeDown()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
    }
    
    func testUIbyHands() {
        let app = XCUIApplication()
        
        XCTAssert(app.tables["TableView"].waitForExistence(timeout: 1.0))   // Проверяем подгрузилась ли таблица
        let tableView = app.tables["TableView"] // Получаем таблицу по идентификатору "TableView"
        XCTAssert(tableView.cells.count != 0)   // Проверяем таблицу на наличие ячеек
        let cellLabelText = tableView.cells["tableViewCell"].staticTexts["0"].label // // Берем текст 1го элемента массива ячеек
        tableView.cells["tableViewCell"].staticTexts["0"].tap() //  // Нажимаем на 1 ячейку элемента массива
        
        // Переходим на SecondViewController
        XCTAssert(app.staticTexts["FullNameLabel"].waitForExistence(timeout: 1.0))  // Проверяем появился ли второй экран с лейблом "FullNameLabel"
        XCTAssertEqual(app.staticTexts["FullNameLabel"].label, cellLabelText)    // Проверяем, что текст лейбла соответствует тексту лейбла ячейки, на которое ранее было совершено нажатие
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
