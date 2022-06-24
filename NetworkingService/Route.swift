//
//  Route.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/06.
//

import Foundation

enum Route {
    static let baseUrl = "https://cuddly-clear-september.glitch.me/"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrders
    
    var description: String {
        switch self {
            
        case .fetchAllCategories: return "/dogfoods"
        case .placeOrder(let dishId): return "/orders/\(dishId)"
        case .fetchCategoryDishes(let categoryId): return "/dogfoods/\(categoryId)"
        case .fetchOrders:
            return "/orders"
        }
    }
}
