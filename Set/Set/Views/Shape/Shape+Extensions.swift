//
//  Shape+Extensions.swift
//  Set
//
//  Created by Павел Бескоровайный on 06.04.2023.
//

import SwiftUI

extension Shape {
  func stripe(_ lineWidth: CGFloat = 3) -> some View {
    ZStack {
      StrippedRect().stroke().clipShape(self)
      self.stroke(lineWidth: lineWidth)
    }
  }
  
  func blur(_ lineWidth: CGFloat = 3) -> some View {
    ZStack {
      self.fill().opacity(0.3)
      self.stroke(lineWidth: lineWidth)
    }
  }
  
  func fillWithBorder(_ lineWidth: CGFloat = 3) -> some View {
    ZStack {
      self.fill()
      self.stroke(lineWidth: lineWidth)
    }
  }
}
