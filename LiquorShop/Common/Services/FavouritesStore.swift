//
//  FavouritesStore.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

protocol FavouritesStoreProtocol {
    func addFavourite(id: String)
    func removeFavourite(id: String)
    func toggleFavourite(id: String)
    func checkIfFavourite(id: String) -> Bool
}

class FavouritesStore: FavouritesStoreProtocol {
    static let shared = FavouritesStore()
    
    var favourites = [String]()
    
    func toggleFavourite(id: String) {
        checkIfFavourite(id: id) ? removeFavourite(id: id) : addFavourite(id: id)
    }
    
    func addFavourite(id: String) {
        if !checkIfFavourite(id: id) {
            favourites.append(id)
        }
    }
    
    func removeFavourite(id: String) {
        guard let index = favourites.firstIndex(of: id) else {
            return
        }
        
        favourites.remove(at: index)
    }
    
    func checkIfFavourite(id: String) -> Bool {
        favourites.contains(id)
    }
}

#if DEBUG
class FavouritesStoreStub: FavouritesStoreProtocol {
    var favourites = [String]()
    
    func toggleFavourite(id: String) {
        checkIfFavourite(id: id) ? removeFavourite(id: id) : addFavourite(id: id)
    }
    
    func addFavourite(id: String) {
        favourites.append(id)
    }
    
    func removeFavourite(id: String) {
        guard let index = favourites.firstIndex(of: id) else {
            return
        }
        
        favourites.remove(at: index)
    }
    
    func checkIfFavourite(id: String) -> Bool {
        favourites.contains(id)
    }
}
#endif

