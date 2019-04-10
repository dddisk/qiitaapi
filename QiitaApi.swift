//
//  QiitaApi.swift
//  qiitaapiTests
//
//  Created by shiroma_daisuke on 2019/04/10.
//  Copyright © 2019 shiroma_daisuke. All rights reserved.
//

import XCTest

struct Calculator {
    static func plus(_ x: Int, addent y: Int) -> Int {
        return x + y
    }
}
class QiitaApi: XCTestCase {

    func test_1足す1が2になること() {
        let result = Calculator.plus(1, addent: 2)
        XCTAssertEqual(result, 3) //なぜか機能していない？ command control u なら聴いてる？　とりあえずここは片山さんに聴いてみる
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
