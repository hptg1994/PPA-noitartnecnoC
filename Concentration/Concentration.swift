//
//  Concentration.swift
//  Concentration
//
//  Created by 何品泰高 on 2017/11/29.
//  Copyright © 2017年 何品泰高. All rights reserved.
//

/*
 * 还没完成作业前，这些都是横向按顺序的
 */

import Foundation

class Concentration{
    var cards = [Card]() //Card 的 Array
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    /*
     * All the logic is down below!!!
     */
    func chooseCard(at index : Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //either no cards or no 2 cards are faced up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards:Int){
        for index in 1...numberOfPairsOfCards{
            let card = Card()
            let matchingCard = card
//            cards.append(card)
//            cards.append(matchingCard)
            cards += [card,matchingCard] // 因为这里只有两个
            if index == numberOfPairsOfCards{
                print(cards)
            }
        }
        // TODO：Shuffle the cards
    }
}

