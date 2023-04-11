//
//  ContentView.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import SwiftUI

struct SetCardGameView: View {
  @StateObject var viewModel = SetCardGame()
  @State var shouldDelay: Bool = true
  
  static let mainBackgroundColor: Color = .blue
  
  var body: some View {
    VStack {
      GameView(viewModel: viewModel, shouldDelay: $shouldDelay).onAppear {
        withAnimation(Animation.easeInOut(duration: 0.7)) {
          deal()
        }
      }
      
      HStack(spacing: 40) {
        VStack {
          Text("Deck: \(viewModel.cardsInDeck)")
          Text("Screen: \(viewModel.cards.count)")
        }
        Button("New Game") { newGame() }.foregroundColor(.white)
        Button("Deal+3") { dealPlusThree() }.foregroundColor(.white)
        
      }
      
    }
    .padding(2)
    .background(SetCardGameView.mainBackgroundColor)
  }
  
  private func deal() {
    viewModel.deal()
    DispatchQueue.main.async {
      shouldDelay = false
    }
  }
  
  private func newGame() {
    viewModel.resetGame()
    shouldDelay = true
    DispatchQueue.main.async {
      deal()
    }
  }
  
  private func dealPlusThree() {
    shouldDelay = true
    viewModel.dealMore()
    DispatchQueue.main.async {
      shouldDelay = false
    }
  }
}


struct SetCardGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetCardGameView()
  }
}
