//
//  EmojiMemorizeGame.swift
//  MemorizeGame
//
//  Created by Kris on 22/10/2020.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    @Published private var model: MemorizeGame<String> = EmojiMemorizeGame.createMemorizeGame()
    
    static func createMemorizeGame() -> MemorizeGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷"]
        return MemorizeGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Acess to the model
    
    var cards: Array<MemorizeGame<String>.Card> {
        model.cards //one line of code, don't need a return
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemorizeGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}
