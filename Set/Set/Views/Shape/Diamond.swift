//
//  Diamond.swift
//  Set
//
//  Created by Павел Бескоровайный on 06.04.2023.
//

import SwiftUI

struct Diamond: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let top = CGPoint(x: rect.midX, y: rect.maxY)
    let right = CGPoint(x: rect.maxX, y: rect.midY)
    let bottom = CGPoint(x: rect.midX, y: rect.minY)
    let left = CGPoint(x: rect.minX, y: rect.midY)
    
    path.move(to: bottom)
    path.addLine(to: left)
    path.addLine(to: top)
    path.addLine(to: right)
    path.addLine(to: bottom)
    
    return path
  }
  
  
}

struct Diamond_Preview: PreviewProvider {
  static var previews: some View {
    Diamond().padding()
  }
  
}

