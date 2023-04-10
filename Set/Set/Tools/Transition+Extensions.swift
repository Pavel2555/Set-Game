//
//  Transition+Extensions.swift
//  Set
//
//  Created by Павел Бескоровайный on 09.04.2023.
//

import SwiftUI

extension AnyTransition {
  static func cardTransition(size: CGSize) -> AnyTransition {
    let insertion = AnyTransition.offset(flyFrom(for: size))
    let removal = AnyTransition.offset(flyTo(for: size))
      .combined (with: AnyTransition.scale(scale: 0.5))
    return .asymmetric(insertion: insertion, removal: removal)
  }
  
  static func flyFrom(for size: CGSize) -> CGSize {
    CGSize(width: 0.0,
           height: 2 * size.height)
  }
  
  static func flyTo(for size: CGSize) -> CGSize {
    CGSize (width: CGFloat.random(in: -3*size.width...3*size.width),
            height: CGFloat.random(in: -2*size.height...(-size.height)))
  }
}
