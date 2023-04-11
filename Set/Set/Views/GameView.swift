//
//  GameView.swift
//  Set
//
//  Created by Павел Бескоровайный on 10.04.2023.
//

import SwiftUI

struct GameView: View {
  @ObservedObject var viewModel: SetCardGame
  @Binding var shouldDelay: Bool
  
  var body: some View {
    GeometryReader { geom in
      let cardsSpacingValue = CardDrawingConstants.init(cardsCount: viewModel.cards.count).dynamicLayerValue
      Grid(viewModel.cards, spacingValue: cardsSpacingValue) { card in
        CardView(card: card, cardsCount: viewModel.cards.count)
          .transition(.cardTransition(size: geom.size))
          .animation(Animation.easeInOut(duration: 0.7)
            .delay(transitionDelay(card: card)))
        //                       value: shouldDelay)
          .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 0.7)) {
              viewModel.choose(card: card)
            }
          }.padding(2)
      }.padding(16)
    }
  }
  
  private let cardTransitionDelay: Double = 0.2
  private func transitionDelay(card: SetGame<SetCard>.Card) -> Double {
    guard shouldDelay else { return 0 }
    return Double(viewModel.cards.firstIndex(matching: card)!) * cardTransitionDelay
  }
}

//struct GameView_Previews: PreviewProvider {
//  //  let cardMock =
//  static var previews: some View {
//    GameView(viewModel: SetCardGame(), shouldDelay: <#Binding<Bool>#>)
//  }
//}
