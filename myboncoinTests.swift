//
//  myboncoinTests.swift
//  myboncoinTests
//
//  Created by James Tapping on 03/04/2023.
//

import XCTest
@testable import myboncoin

final class myboncoinTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListingDecodesCorrectly() throws {
        let decoder = JSONDecoder()
        let listing = try decoder.decode([Listing].self, from: mockJSONData)
        XCTAssertEqual(listing[0].id, 1461267313)
        XCTAssertEqual(listing[0].price, 140)
        XCTAssertEqual(listing[0].imagesURL.thumb, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
        XCTAssertEqual(listing[0].imagesURL.small, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
        XCTAssertEqual(listing[0].creationDate, "2019-11-05T15:56:59+0000")
        XCTAssertFalse(listing[0].isUrgent)
        XCTAssertNil(listing[0].siret)
    }
}

extension myboncoinTests {
    
    var mockJSONData: Data {
        return getData(name: "listing_test")
    }
    
    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
}
