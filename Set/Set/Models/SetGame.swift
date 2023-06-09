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
    
    self.numberOfCardsForStart = numberOfCardsForStart
    
    for ind in 0..<numberOfCardsInDeck {
      let content = cardContentFactory(ind)
      deck.append(Card(content: content, id: ind))
    }
    deck.shuffle()
  }
  
  mutating func deal(_ numberOfCards: Int? = nil) {
    guard deck.count > 0 else { return }
    let n = numberOfCards ?? numberOfCardsForStart
    for _ in 0..<n {
      cards.append(deck.remove(at: 0))
    }
  }
  
  mutating func choose(card: Card) {
    if let chosenIndex = cards.firstIndex(matching: card),
       !cards[chosenIndex].isSelected,
       !cards[chosenIndex].isMatched {
      
      if selectedIndices.count == 2 {
        cards[chosenIndex].isSelected = true
        if CardContent.match(cards: selectedIndices.map{cards[$0].content}) {
          //MATCHED
          for index in selectedIndices {
            cards[index].isMatched = true
            changeCards()
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
          onlySelectedCard(chosenIndex)
        }
      }
    } else if let chosenIndex = cards.firstIndex(matching: card),
              cards[chosenIndex].isSelected,
              !cards[chosenIndex].isMatched,
              !cards[chosenIndex].isNotMatched {
      cards[chosenIndex].isSelected = false
    }
  }
  
  private mutating func onlySelectedCard(_ onlyIndex: Int) {
    for index in cards.indices {
      cards[index].isSelected = index == onlyIndex
      cards[index].isNotMatched = false
    }
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
      cards = cards.enumerated()
        .filter({!replaceIndices.contains($0.offset)})
        .map({$0.element})
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
