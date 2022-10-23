//
//  ProductListService.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

protocol ProductListServiceProtocol {
    func fetchProductList() async throws -> [Product]
}

struct ProductListService: ProductListServiceProtocol {
    private let endpoint = "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328"
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchProductList() async throws -> [Product] {
        guard let url = URL(string: endpoint) else {
            throw CustomError.invalidEndpoint
        }
        
        let (data, _) = try await urlSession.data(from: url)
        let productsConainer = try JSONDecoder().decode(Products.self, from: data)
        
        return productsConainer.products
    }
}
