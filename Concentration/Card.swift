//
//  Card.swift
//  Concentration
//
//  Created by 何品泰高 on 2017/11/29.
//  Copyright © 2017年 何品泰高. All rights reserved.
//

import Foundation

struct Card:Hashable{
    var hashValue: Int{
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false;
    var isMatched = false;
    private var identifier : Int // unic indeti
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
