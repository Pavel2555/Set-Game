//
//  CardView.swift
//  Set
//
//  Created by Павел Бескоровайный on 10.04.2023.
//

import SwiftUI

struct CardView: View {
  var card: SetGame<SetCard>.Card
  
  var borderColors: [Color] = [.green, .red, .yellow]
  var cardsCount: Int = 12
  private var cardDrawingConstants: CardDrawingConstants {
    CardDrawingConstants(cardsCount: cardsCount)
  }
  
  var body: some View {
    if card.isSelected || !card.isMatched {
      SetCardView(card: card.content, cardItemsRatio: cardDrawingConstants.dynamicRatio)
        .background(.white)
        .cornerRadius(cardDrawingConstants.cornerRadius)
        .overlay(
          RoundedRectangle(cornerRadius: cardDrawingConstants.cornerRadius)
            .stroke(highlightColor(), lineWidth: cardDrawingConstants.borderLineWidth)
        )
    }
  }
  
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
    }
    return color
  }
}
