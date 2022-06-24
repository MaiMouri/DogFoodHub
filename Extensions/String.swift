//
//  String.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/07.
//

import Foundation


extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
    func capitalizaionFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}

