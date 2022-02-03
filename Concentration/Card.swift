//
//  Card.swift
//  Concentration
//
//  Created by Zhora on 31.01.2022.
//

import Foundation

struct Card{
    var isMatched = false
    var isFaceUp = false
    var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
