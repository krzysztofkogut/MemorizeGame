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
        VStack {
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.75)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
                }
                .padding()
                .foregroundColor(Color.orange)
            .font(Font.largeTitle)
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View {
    var card: MemorizeGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: (card.bonusTimeRemaining))) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
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
