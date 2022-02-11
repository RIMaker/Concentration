//
//  Card.swift
//  Concentration
//
//  Created by Zhora on 31.01.2022.
//

import Foundation

struct Card: Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    var hashValue: Int{ return identifier }
    
    static func == (lhs: Self, rhs: Self) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    var isMatched = false
    var isFaceUp = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
