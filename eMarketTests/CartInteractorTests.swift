//
//  CartInteractorTests.swift
//  eMarketTests
//
//  Created by Nguyen Van Thanh on 2021/11/25.
//

import XCTest
@testable import eMarket

class CartInteractorTests: XCTestCase {
    
    var interactor: CartInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = CartInteractor()
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
    func testDumplicatedAddProduct() {
        let isDeleted = interactor.deleteAllCartProducts()
        XCTAssertTrue(isDeleted)

        let product = Product(name: "Product 1", price: 200, imageURL: "http://image.com/img.png")
        // add product with id = 1 first time
        let success = interactor.addToCart(product: product, id: 1)
        XCTAssertTrue(success)
        // add product with id = 1 second time
        let success2 = interactor.addToCart(product: product, id: 1)
        XCTAssertFalse(success2)
        
        let isDeleted1 = interactor.deleteAllCartProducts()
        XCTAssertTrue(isDeleted1)
    }
    
    func testAddProductOK() {
        let products = interactor.getProductsInCart()
        let lastProductId = products.last?.id ?? 1000
        let product = Product(name: "Product 12", price: 200, imageURL: "http://image.com/img.png")
        // add product with id = 1 first time
        let success = interactor.addToCart(product: product, id: Int(lastProductId) + 1)
        XCTAssertTrue(success)
        
        let isDeleted1 = interactor.deleteAllCartProducts()
        XCTAssertTrue(isDeleted1)
    }
    
    func testDeliveryAddress() {
        let editedAddress = "東京・日本"
        interactor.updateDeliveryAddress(editedAddress)
        let afterEditAdd = interactor.getDeliveryAddress()
        XCTAssertTrue(editedAddress == afterEditAdd)
    }
    
    func testUpdateProductQuantity() {
        let isDeleted = interactor.deleteAllCartProducts()
        XCTAssertTrue(isDeleted)
        let product = Product(name: "Product 1", price: 200, imageURL: "http://image.com/img.png")
        // add product with id = 1 first time
        let success = interactor.addToCart(product: product, id: 1)
        XCTAssertTrue(success)
        guard let prd = interactor.getProductsInCart().first(where: { $0.id == 1 }) else {
            return
        }
        XCTAssertTrue(prd.quantity == 1)
        interactor.updateProductQuantity(prd, action: .plus) // +1
        let prd2 = interactor.getProductsInCart().first(where: { $0.id == 1 })
        XCTAssertTrue(prd2?.quantity == 2)
        
        let isDeleted1 = interactor.deleteAllCartProducts()
        XCTAssertTrue(isDeleted1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
