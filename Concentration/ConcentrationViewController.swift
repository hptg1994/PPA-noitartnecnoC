//
//  ViewController.swift
//  Concentration
//
//  Created by 何品泰高 on 2017/11/29.
//  Copyright © 2017年 何品泰高. All rights reserved.
//

import UIKit


class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards:numberOfPairsOfCards)
    
    private var numberOfPairsOfCards :Int{
            return (CardButtons.count + 1)/2
    }
    
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes : [NSAttributedStringKey:Any] = [
            .strokeWidth:5.0,
            .strokeColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var CardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender){
            game.chooseCard(at:cardNumber)
            updateViewFromModel()
        }else{
            print("Choose card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        if CardButtons != nil {
            for index in CardButtons.indices{
                let button = CardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp{
                    button.setTitle(emoji(for:card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var theme:String? {
        didSet{
            emojiChoice = theme ?? ""
            emoji = [:]
            updateViewFromModel() //in the middle of the game,set the theme
        }
    }
    // private var emojiChoice = ["😘","🧐","😑","😸","🤟","🧠","👥","👷‍♂️","👨‍💼","👨‍👦","👢"]
    private var emojiChoice = "😘🧐😑😸🤟🧠👥👷‍♂👨‍💼👨‍👦👢"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        
        if emoji[card] == nil , emojiChoice.count > 0{
                //let x = 5.arc4random
                // loading up dictionary,randomly choose one into dictionary
                let randomStringIndex = emojiChoice.index(emojiChoice.startIndex, offsetBy: emojiChoice.count.arc4random)
                emoji[card] = String(emojiChoice.remove(at: randomStringIndex)) // Dictionary 的形式 [Int]=String
            }
        /*
        if emoji[card.identifier] != nil{
            return emoji[card.identifier] !
        }else{
            return "?"
        }
        */
        return emoji[card] ?? "?"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//What if Int have a var which gave a random integer?
extension Int {
    var arc4random:Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}



