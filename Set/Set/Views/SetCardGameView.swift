//
//  ContentView.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import SwiftUI

struct SetCardGameView: View {
  @StateObject var viewModel = SetCardGame()
  
  var body: some View {
    Grid(viewModel.cards) { card in
      CardView(card: card)
        .onTapGesture {
          viewModel.choose(card: card)
        }
        .padding(2)
    }
    .padding()
    .onAppear {
      viewModel.deal()
    }
    
    .background(.blue)
    
  }
  
  struct CardView: View {
    var card: SetGame<SetCard>.Card
    
    var body: some View {
      if card.isSelected || !card.isMatched {
        SetCardView(card: card.content)
          .background(.white)
          .cornerRadius(cornerRadius)
      }
    }
    
    private let cornerRadius: CGFloat = 20
  }
}

struct SetCardGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetCardGameView()
  }
}
