//
//  SetCardView.swift
//  Set
//
//  Created by Павел Бескоровайный on 06.04.2023.
//

import SwiftUI

struct SetCardView: View {
  var card: SetCard
  var colors: [Color] = [.orange, .green, .cyan]
  var aspectRatio: CGFloat = 3/4
  var cardItemsRatio: Double = 4
  
  var body: some View {
    GeometryReader { geom in
      VStack {
        ForEach(0..<card.number.rawValue, id: \.self) { _ in
          cardShape().frame(height: geom.size.height / cardItemsRatio)
        }
      }
      .padding(10)
      .foregroundColor(colors[card.color.rawValue - 1])
      .aspectRatio(aspectRatio, contentMode: .fit)
      .position(x: geom.frame(in: .local).midX,
                y: geom.frame(in: .local).midY)
    }
  }
  
  private func cardShape() -> some View {
    ZStack {
      switch card.shape {
      case .v1: shapeFill(shape: Capsule())
      case .v2: shapeFill(shape: Diamond())
      case .v3: shapeFill(shape: Squiggle())
      }
    }
  }
  
  private func shapeFill<setShape>(shape: setShape) -> some View where setShape: Shape {
    ZStack {
      switch card.fill {
      case .v1: shape.stroke(lineWidth: 3)
      case .v2: shape.fillWithBorder()
      case .v3: shape.stripe()
      }
    }
  }
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        SetCardView(card: SetCard(number: .v2, color: .v1, shape: .v3, fill: .v2))
        SetCardView(card: SetCard(number: .v2, color: .v1, shape: .v3, fill: .v2))
      }
      
    }
}
