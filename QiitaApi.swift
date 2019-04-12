//
//  QiitaApi.swift
//  qiitaapiTests
//
//  Created by shiroma_daisuke on 2019/04/10.
//  Copyright © 2019 shiroma_daisuke. All rights reserved.
//

import XCTest

struct Calculator {
    static func plus(_ x: Int, addend y: Int) -> Int {
        return x + y
    }
}
class QiitaApi: XCTestCase {

    func test_1足す1が2になること() {
        let result = Calculator.plus(1, addend: 2)
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

    func test_足し算のテスト () {
        XCTContext.runActivity(named: "1 足す 1 が 2 になること") { _ in
            let result = Calculator.plus(1, addend: 1)
            XCTAssertEqual(result, 2) }
        XCTContext.runActivity(named: "5 足す 5 が 10 になること") { _ in let result = Calculator.plus(5, addend: 5)
            XCTAssertEqual(result, 10) }
    }

}



enum Coin: Int {
    case hundred = 100
}
class VendingMachine { var money: Int = 0
    func insert(coin: Coin) { money += coin.rawValue
    }



}
