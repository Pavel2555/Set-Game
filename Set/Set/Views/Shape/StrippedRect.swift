//
//  StrippedRect.swift
//  Set
//
//  Created by Павел Бескоровайный on 06.04.2023.
//

import SwiftUI

struct StrippedRect: Shape {
  var spacing: CGFloat = 5
  
  func path(in rect: CGRect) -> Path {
    let start = CGPoint(x: rect.minX, y: rect.minY)
    
    var path = Path()
    path.move(to: start)
    
   
    while path.currentPoint!.x < rect.maxX {
      guard let currentX = path.currentPoint?.x else { return path }
      path.addLine(to: CGPoint(x: currentX, y: rect.maxY))
      path.move(to: CGPoint(x: currentX + spacing, y: rect.minY))
    }
    
    return path
  }
  
  
}

struct StrippedRect_Preview: PreviewProvider {
  static var previews: some View {
    ZStack {
      StrippedRect().stroke().clipShape(Squiggle())
      Squiggle().stroke(lineWidth: 2)
    }.padding()
    
  }
  
}
