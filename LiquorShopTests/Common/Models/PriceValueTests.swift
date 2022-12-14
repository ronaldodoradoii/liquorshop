//
//  PriceValueTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest
import Nimble
@testable import LiquorShop

final class PriceValueTests: XCTestCase {

    func testShouldFormatPriceWithDollarSignAndCentsCorrectly() {
        let expectedValues: [(formatted: String, value: Decimal)] = [("$1.00", 1),
                                                                     ("$2.00", 2.0),
                                                                     ("$3.01", 3.01),
                                                                     ("$4.01", 4.012),
                                                                     ("-$5.00", -5),
                                                                     ("$6,789.00", 6789)]
        
        for expectedValue in expectedValues {
            let actualPriceValue = PriceValue(decimalValue: expectedValue.value).withDollarSign()
            expect(actualPriceValue).to(equal(expectedValue.formatted), description: "Expected \(expectedValue.formatted) to formatted correctly")
        }
    }
    
    func testShouldReturnNotAvailableIfValueIsNil() {
        let actualPriceValue = PriceValue(decimalValue: nil).withDollarSign()
        
        expect(actualPriceValue).to(equal("Not available"))
    }
}
