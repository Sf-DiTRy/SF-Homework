//
//  TestProjectTests.swift
//  TestProjectTests
//
//  Created by SF on 01.06.2021.
//

import XCTest
@testable import TestProject

class TestProjectTests: XCTestCase {
    
    // Объявляем мок с тестовыми данными
    let mockUserData = UserMock(firstName: "name", lastName: "lastName", bio: "i love sf", city: "city", friends: [], isClosed: false)
    // Объявляем мок данные друга, которого потом добавим в тесте
    let mockFriendData = UserMock(firstName: "friend name", lastName: "friend lastName", bio: "friend bio", city: "friend city", friends: [], isClosed: true)
    // Объявляем имя, которое мы в тесте будем менять используя метод changeName()
    let mockFirstName = "mockFirstName"
    // Аналогично для остальных полей
    let mockLastName = "mockLastName"
    let mockBio = "mockBio"
    let mockCity = "mockCity"

    func testChangeCity() throws {
        mockUserData.changeCity(mockCity)
        XCTAssertTrue(mockUserData.changeCityCalledCount > 0) // Метод вызван хотя бы 1 раз
        XCTAssertTrue(mockUserData.changeCityCalled) // Метод вызван
        XCTAssertTrue(mockUserData.city == mockCity) // Проверка на соответствие
    }
    
    func testChangeClosed() throws {
        var isClosed = mockUserData.isClosed
        isClosed.toggle()
        mockUserData.changeClosed(isClosed)
        XCTAssertTrue(mockUserData.changeClosedCalled) // Метод вызван
        XCTAssertTrue(mockUserData.changeClosedCalledCount > 0) // Метод вызван хотя бы 1 раз
        XCTAssert(mockUserData.isClosed == isClosed) // Проверка на соответствие
    }
    
    func testChangeName() throws {
        mockUserData.changeName(mockFirstName)
        XCTAssertTrue(mockUserData.changeNameCalled) // Метод вызван
        XCTAssertTrue(mockUserData.changeNameCalledCount > 0) // Метод вызван хотя бы 1 раз
        XCTAssertTrue(mockUserData.firstName == mockFirstName) // Проверка на соответствие
    }
    
    func testChangeLastName() throws {
        mockUserData.changeLastName(mockLastName)
        XCTAssertTrue(mockUserData.changeLastNameCalled) // Метод вызван
        XCTAssertTrue(mockUserData.changeLastNameCalledCount > 0) // Метод вызван хотя бы 1 раз
        XCTAssertTrue(mockUserData.lastName == mockLastName) // Проверка на соответствие
    }
    
    func testChangeBio() throws {
        mockUserData.changeBio(mockBio)
        XCTAssertTrue(mockUserData.changeBioCalled) // Метод вызван
        XCTAssertTrue(mockUserData.changeBioCalledCount > 0) // Метод вызван хотя бы 1 раз
        XCTAssertTrue(mockUserData.bio == mockBio) // Проверка на соответствие
    }
    
    func testAddFriend() throws {
        mockUserData.addFriend(mockFriendData)
        XCTAssertTrue(mockUserData.addFriendCalled) // Метод вызван
        XCTAssertTrue(mockUserData.addFriendCalledCount > 0) // Метод вызван хотя бы 1 раз
        XCTAssertTrue(mockUserData.addFriendCalledCount == 1) // Проверка на соответствие
    }
    
}

class UserTests: XCTestCase {
    
    let user = User(firstName: "firstName", lastName: "lastName", bio: "bio", city: "city", friends: [], isClosed: false)
    let friend = User(firstName: "friendsFirstName", lastName: "friendsLastName", bio: "friendsBio", city: "friendsCity", friends: [], isClosed: true)
    let city = "NewCity"
    let firstName = "NewFirstName"
    let lastName = "NewLastName"
    let bio = "NewBio"

    func testChangeCity() {
        user.changeCity(city)
        XCTAssert(user.city == city) // Проверка на соответствие
    }
    
    func testChangeClosed() {
        var isClosed = user.isClosed
        isClosed.toggle()
        user.changeClosed(isClosed)
        XCTAssert(user.isClosed == isClosed) // Проверка на соответствие
    }
    
    func testChangeName() {
        user.changeName(firstName)
        XCTAssert(user.firstName == firstName) // Проверка на соответствие
    }
    
    func testChangeLastName() {
        user.changeLastName(lastName)
        XCTAssert(user.lastName == lastName) // Проверка на соответствие
    }
    
    func testChangeBio() {
        user.changeLastName(lastName)
        XCTAssert(user.lastName == lastName) // Проверка на соответствие
    }
    
    func testAddFriend() {
        user.addFriend(friend)
        XCTAssertTrue(user.friends.count == 1) // Проверка на соответствие
    }
    
}
