//
//  Date.Extension.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/17.
//

import Foundation


extension Date {
    var asStringDate: String? {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return formatter.string(from: self)
    }
}
