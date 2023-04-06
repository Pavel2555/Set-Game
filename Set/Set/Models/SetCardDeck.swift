//
//  Card=Deck.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import Foundation

struct SetCardDeck {
  private(set) var cards = [SetCard]()
  
  init() {
    for number in SetCard.Version.allCases {
      for color in SetCard.Version.allCases {
        for shape in SetCard.Version.allCases {
          for fill in SetCard.Version.allCases {
            cards.append(SetCard(number: number,
                                 color: color,
                                 shape: shape,
                                 fill: fill))
          }
        }
      }
    }
    cards.shuffle()
  }
  
  mutating func draw() -> SetCard? {
    cards.count > 0
    ? cards.remove(at: Int.random(in: 0..<cards.count))
    : nil
  }
}
