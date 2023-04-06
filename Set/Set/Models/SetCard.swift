//
//  Card.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import Foundation

struct SetCard: Matchable {
  let number: Version
  let color: Version
  let shape: Version
  let fill: Version
  
  var desprition: String {
    return "\(number)-\(color)-\(shape)-\(fill)"
  }
  
  enum Version: Int, CaseIterable, CustomStringConvertible {
    case v1 = 1
    case v2
    case v3
    
    var description: String {
      return String(self.rawValue)
    }
  }
  
  static func match(cards: [SetCard]) -> Bool {
    guard cards.count == 3 else {return false}
    let sum = [
      cards.reduce(0, { $0 + $1.number.rawValue}),
      cards.reduce(0, { $0 + $1.color.rawValue}),
      cards.reduce(0, { $0 + $1.shape.rawValue}),
      cards.reduce(0, { $0 + $1.fill.rawValue})
    ]
    return sum.reduce(true, { $0 && ($1 % 3 == 0) })
  }
}
