//
//  ViewController.swift
//  Concentration
//
//  Created by Zhora on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    var flipCount = 0{
        didSet{
            flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    var emojiChoices = ["🎃","🐶","🐷","🦄","🎱","✈️"]
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1;
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("choosen card was not in cardButtons")
        }
    }
    @IBAction func restart1() {
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
    
    @IBOutlet weak var flipCountLable: UILabel!
    
    func updateViewFromModel(){
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
    var emoji = [Int: String]()
    
    func emoji(for card: Card)->String{
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0{
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

