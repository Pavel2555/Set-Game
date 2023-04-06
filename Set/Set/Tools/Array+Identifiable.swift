//
//  Array+Identifiable.swift
//  Set
//
//  Created by Павел Бескоровайный on 06.04.2023.
//

import Foundation

extension Array where Element: Identifiable {
  func firstIndex (matching: Element)-> Int? {
    for index in 0..<self.count {
      if self[index].id == matching.id {
        return index
      }
    }
    return nil
  }
}
