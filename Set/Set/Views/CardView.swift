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
  // сделать динамические границы и радиус в зависимости от количества карт
  
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

//struct CardView_Previews: PreviewProvider {
//  //  let cardMock =
//  static var previews: some View {
//   CardView()
//  }
//}
