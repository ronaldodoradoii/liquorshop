//
//  MockRequestHandler.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import Foundation

struct MockRequestHandler {
    static func build(statusCode: Int, data: Data?) -> ((URLRequest) throws -> (HTTPURLResponse, Data?))? {
        return { request in
            let response = HTTPURLResponse(url: URL(string: "https://some.url.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
    }
}
