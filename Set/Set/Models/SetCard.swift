//
//  Card.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import Foundation

struct SetCard {
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
}
