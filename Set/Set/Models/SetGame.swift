//
//  SetGame.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import Foundation
protocol Matchable {
  static func match(cards: [Self]) -> Bool
}

struct SetGame<CardContent> where CardContent: Matchable {
  private(set) var cards: [Card]
  private(set) var deck = [Card]()
  
  let numberOfCardsToMatch = 3
  var numberOfCardsForStart = 12
  
  private var selectedIndices: [Int] {
    cards.indices.filter({cards[$0].isSelected})
  }
  private var matchedIndices: [Int] {
    cards.indices.filter({cards[$0].isSelected && cards[$0].isMatched})
  }
  
  init(numberOfCardsForStart: Int, numberOfCardsInDeck: Int, cardContentFactory: (Int) -> CardContent) {
    cards = [Card]()
    deck = [Card]()
    
    for ind in 0..<numberOfCardsForStart {
      let content = cardContentFactory(ind)
      deck.append(Card(content: content, id: ind))
    }
    deck.shuffle()
  }
  
  mutating func deal(_ numberOfCards: Int? = nil) {
    let n = numberOfCards ?? numberOfCardsForStart
    for _ in 0..<n {
      cards.append(deck.remove(at: 0))
    }
  }
  
  mutating func choose(card: Card) {
    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
       !cards[chosenIndex].isSelected,
       !cards[chosenIndex].isMatched {
      
      if selectedIndices.count == 2 {
        cards[chosenIndex].isSelected = true
        if CardContent.match(cards: selectedIndices.map{cards[$0].content}) {
          //MATCHED
          for index in selectedIndices {
            cards[index].isMatched = true
          }
        } else {
          //NOT MATCHED
          for index in selectedIndices {
            cards[index].isNotMatched = true
          }
        }
      } else {
        if selectedIndices.count == 1 || selectedIndices.count == 0 {
          cards[chosenIndex].isSelected = true
        } else {
          changeCards()
          onlySelectedCard(chosenIndex)
        }
      }
    }
  }
  
  private mutating func onlySelectedCard(_ onlyIndex: Int) {
    cards.indices.forEach({
      cards[$0].isMatched = $0 == onlyIndex
      cards[$0].isNotMatched = false
    })
  }
  
  private mutating func changeCards() {
    guard matchedIndices.count == numberOfCardsToMatch else { return }
    let replaceIndices = matchedIndices
    if deck.count >= numberOfCardsToMatch && cards.count == numberOfCardsForStart {
      //REPLACE MATCHED CARDS
      for index in replaceIndices {
        cards.remove(at: index)
        cards.insert(deck.remove(at: 0), at: index)
      }
    } else {
      //REMOVE MATCHED CARDS
      cards = cards.enumerated().filter({!replaceIndices.contains($0.offset)}).map({$0.element})
    }
  }
  
  
  struct Card: Identifiable {
    var isSelected: Bool = false
    var isMatched: Bool = false
    var isNotMatched: Bool = false
    var content: CardContent
    var id: Int
  }
}
