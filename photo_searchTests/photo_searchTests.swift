//
//  photo_searchTests.swift
//  photo_searchTests
//
//  Created by Rock Chen on 2020/9/24.
//

import XCTest
@testable import photo_search

class photo_searchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testPhotoSearchAPI() throws {
        let promise = expectation(description: "Completion handler PhotoSearchAPI")
        
        let request = PhotoSearchRequest(text: "美食", per_page: 100, page: 1)
        photoProvider.request(.search(request: request)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let model = try response.filterSuccessfulStatusCodes().map(PhotoSearchResponse.self)
                    XCTAssertNotNil(model, "資料錯誤")
                    XCTAssertTrue(model.stat == "ok", model.stat)
                } catch let error {
                    XCTAssert(false, error.localizedDescription)
                }
            case let .failure(error):
                XCTAssert(false, error.localizedDescription)
            }
            
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
