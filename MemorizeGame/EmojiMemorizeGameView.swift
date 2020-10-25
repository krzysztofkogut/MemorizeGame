//
//  EmojiMemorizeGameView.swift
//  MemorizeGame
//
//  Created by Kris on 22/10/2020.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemorizeGame<String>.Card
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    }
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemorizeGame()
        game.choose(card: game.cards[0])
        return EmojiMemorizeGameView(viewModel: game)
    }
}
