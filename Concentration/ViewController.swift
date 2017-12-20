//
//  ViewController.swift
//  Concentration
//
//  Created by 何品泰高 on 2017/11/29.
//  Copyright © 2017年 何品泰高. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards:(CardButtons.count + 1)/2)
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips:\(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var CardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender){
            game.chooseCard(at:cardNumber)
            updateViewFromModel()
        }else{
            print("Choose card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in CardButtons.indices{
            let button = CardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                 button.setTitle(emoji(for:card), for: UIControlState.normal)
                 button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoice = ["😘","🧐","😑","😸","🤟","🧠","👥","👷‍♂️","👨‍💼","👨‍👦","👢"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        
        if emoji[card.identifier] == nil , emojiChoice.count > 0{
                // loading up dictionary,randomly choose one into dictionary
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
                emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
            }
        /*
        if emoji[card.identifier] != nil{
            return emoji[card.identifier] !
        }else{
            return "?"
        }
        */
        return emoji[card.identifier] ?? "?"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

