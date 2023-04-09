//
//  ShapeSetGame.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import SwiftUI

class SetCardGame: ObservableObject {
  @Published private var model: SetGame<SetCard> = SetCardGame.createSetGame()
  
  static var numberOfCardsForStart = 12
  static var deck = SetCardDeck()
  
  static func createSetGame() -> SetGame<SetCard> {
    deck = SetCardDeck()
    return SetGame<SetCard>(numberOfCardsForStart: numberOfCardsForStart, numberOfCardsInDeck: deck.cards.count) { index in
      deck.cards[index]
    }
  }
  
  var cards: [SetGame<SetCard>.Card] {
    model.cards
  }
  
  // MARK: - Intent(s)
  func choose(card: SetGame<SetCard>.Card) {
    model.choose(card: card)
  }
  
  func deal() {
    model.deal()
  }
 
}
