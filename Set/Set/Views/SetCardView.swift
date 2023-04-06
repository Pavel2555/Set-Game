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
  
  var body: some View {
    GeometryReader { geom in
      VStack {
        Spacer()
        let cardValue = card.number.rawValue
        ForEach(0..<cardValue, id: \.self) { _ in
          cardShape().frame(height: geom.size.height / 4)
        }
        Spacer()
      }
      .padding(10)
      .foregroundColor(colors[card.color.rawValue - 1])
      .aspectRatio(aspectRatio, contentMode: .fit)
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
      case .v1: shape.stroke()
      case .v2: shape.fillWithBorder()
      case .v3: shape.stripe()
      }
    }
  }
}

//struct SetCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetCardView()
//    }
//}
