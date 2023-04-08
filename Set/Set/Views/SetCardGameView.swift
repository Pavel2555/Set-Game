//
//  ContentView.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import SwiftUI

struct SetCardGameView: View {
  @StateObject var viewModel = SetCardGame()
  
  static let mainBackgroundColor: Color = .blue
  
  var body: some View {
    Grid(viewModel.cards) { card in
      CardView(card: card)
        .onTapGesture {
          viewModel.choose(card: card)
        }
        .padding(2)
    }
    .padding()
    .onAppear { viewModel.deal() }
    .background(SetCardGameView.mainBackgroundColor)
    
  }
  
  struct CardView: View {
    var card: SetGame<SetCard>.Card
    var borderColors: [Color] = [.red, .black, .yellow]
    
    var body: some View {
      if card.isSelected || !card.isMatched {
        SetCardView(card: card.content)
          .background(.white)
          .cornerRadius(cornerRadius)
          .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
              .stroke(highlightColor(), lineWidth: borderLineWidth)
          )
      }
    }
    
    private let cornerRadius: CGFloat = 20
    private let borderLineWidth: CGFloat = 8
    
    private func highlightColor() -> Color {
      var color: Color = .white
      
      if card.isSelected {
        if card.isMatched {
          color = borderColors[0]
        } else if card.isNotMatched {
          color = borderColors[1]
        } else {
          color = borderColors[2]
        }
      } else {
        color = SetCardGameView.mainBackgroundColor
      }
      return color
    }
  }
}

struct SetCardGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetCardGameView()
  }
}
