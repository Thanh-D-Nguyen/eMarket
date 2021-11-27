//
//  StoreInteractorTests.swift
//  eMarketTests
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import XCTest
@testable import eMarket

class StoreInteractorTests: XCTestCase {
    
    var interactor: StoreInteractor!

    override func setUp() {
        super.setUp()
        interactor = StoreInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Test Data not nil Store API
    func testStoreAPI() {
        let expectation = XCTestExpectation(description: "Completed fetch store infomations")
        interactor.getStoreInfomation { result in
            switch result {
            case .success(let data):
                guard data != nil else {
                    return
                }
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 8.0)
    }
    // Test Data not nil Product API
    func testProductAPI() {
        let expectation = XCTestExpectation(description: "Completed fetch store's products")
        interactor.getProducts { result in
            switch result {
            case .success(let data):
                guard data != nil else {
                    return
                }
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 8.0)
    }
    // Test Order complete or not
    func testOrderAPI() {
        let expectation = XCTestExpectation(description: "Oder completed")
        let product1 = Product(name: "Ice Tea Latte", price: 233, imageURL: "http://emarket.com/icetealatte.png")
        let product2 = Product(name: "Cafe Capuchino", price: 333, imageURL: "http://emarket.com/capuchino.png")
        interactor.order(Order(products: [product1, product2], deliveryAddress: "address")) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_): break
            }
        }
        wait(for: [expectation], timeout: 8.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
