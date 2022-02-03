//
//  ViewController.swift
//  Concentration
//
//  Created by Zhora on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private (set) var flipCount = 0{
        didSet{
            flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    private var emojiChoices = ["🎃","🐶","🐷","🦄","🎱","✈️"]
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount+=1;
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("choosen card was not in cardButtons")
        }
    }
    @IBAction private func restart1() {
        if flipCount > 0{
            emojiChoices.removeAll()
            emojiChoices += ["🎃","🐶","🐷","🦄","🎱","✈️"]
            //game.cards = game.cards.shuffled()
            for index in cardButtons.indices{
                game.cards[index].isMatched = false
                game.cards[index].isFaceUp = false
                let button = cardButtons[index]
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        cardButtons = cardButtons.shuffled()
        flipCount = 0
        game.indexOfOneAndOnlyFaceUpCard = nil
        
    }
    
    @IBOutlet private weak var flipCountLable: UILabel!
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card)->String{
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0{
                let randomIndex = emojiChoices.count.arc4random
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
    
}
extension Int{
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self == 0 {
            return 0
        }else{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        
    }
}
