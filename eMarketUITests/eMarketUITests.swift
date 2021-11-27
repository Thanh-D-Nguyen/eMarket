//
//  eMarketUITests.swift
//  eMarketUITests
//
//  Created by Nguyen Van Thanh on 2021/11/25.
//

import XCTest

class eMarketUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testOrderOneProductFollow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        if app.staticTexts["ProductCountLabel"].exists {
            app.buttons["ShowYourCart"].tap()
            app.buttons["Checkout"].tap()
            app.buttons["Back To Home"].tap()
        }
        app.collectionViews.cells["ProductItemCell0"].buttons["Add to cart"].tap()
        app.buttons["ShowYourCart"].tap()
        XCTAssertTrue(app.staticTexts["TotalPriceLabel"].exists)
        app.buttons["Checkout"].tap()
        app.buttons["Back To Home"].tap()
    }
    
    func testOrderTwoProductAndQuantity() throws {
        let app = XCUIApplication()
        app.launch()
        if app.staticTexts["ProductCountLabel"].exists {
            app.buttons["ShowYourCart"].tap()
            app.buttons["Checkout"].tap()
            app.buttons["Back To Home"].tap()
        }
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells["ProductItemCell0"].buttons["Add to cart"].tap()
        collectionViewsQuery.cells["ProductItemCell1"].buttons["Add to cart"].tap()
        app.buttons["ShowYourCart"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells["CartItemCell0"].buttons["iconAdd"].tap()
        tablesQuery.cells["CartItemCell1"].buttons["iconAdd"].tap()
        XCTAssertTrue(app.buttons["Checkout"].staticTexts["Checkout(4)"].exists)
        app.buttons["Checkout"].tap()
        app.buttons["Back To Home"].tap()
        
        
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
