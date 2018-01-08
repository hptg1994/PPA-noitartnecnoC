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

struct Concentration{

    private(set) var cards = [Card]() //Card 的 Array
    
    /*
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    */
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            let ch = "hello".oneAndOnly //return nil because it has five element
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
//            let faceUpCardIndices = cards.indices.filter{cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set(newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    /*
     * All the logic is down below!!!
     */
    mutating func chooseCard(at index : Int){
        
        assert(cards.indices.contains(index),"Concentration.chooseCard(at:\(index)):chosen index not in the cards")
        
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                //either no cards or no 2 cards are faced up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards:Int){
        assert(numberOfPairsOfCards > 0,"Concentration.init(\(numberOfPairsOfCards)):you must have at least one pair of cards")
        for index in 1...numberOfPairsOfCards{
            let card = Card()
            let matchingCard = card
//            cards.append(card)
//            cards.append(matchingCard)
            cards += [card,matchingCard] // 因为这里只有两个
            if index == numberOfPairsOfCards{
//                print(cards)
            }
        }
        // TODO：Shuffle the cards
    }
}

extension Collection {
    var oneAndOnly:Element?{
        return count == 1 ? first : nil
    }
}

