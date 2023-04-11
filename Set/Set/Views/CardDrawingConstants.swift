//
//  CardDrawingConstants.swift
//  Set
//
//  Created by Павел Бескоровайный on 10.04.2023.
//

import Foundation

struct CardDrawingConstants {
  var cardsCount: Int
  
  private let maxCardsCount = 81
  private let minCardsCount = 3
  private let minCardItemRatio = 4
  private let maxCardItemRatio = 6
  
  var dynamicLayerValue: CGFloat {
    let dynamic = (maxCardsCount/minCardsCount/2) - (cardsCount - minCardsCount)/minCardsCount/2
    return CGFloat(dynamic)
  }
  
  var cornerRadius: CGFloat {
    dynamicLayerValue
  }
  
  var borderLineWidth: CGFloat {
    dynamicLayerValue/2
  }
  
  var dynamicRatio: Double {
    let maxDeltaRatio = maxCardItemRatio - minCardItemRatio
    let cardsDelta = maxCardsCount - cardsCount
    
    let dynamicRatio = Double(minCardItemRatio) + (1 - Double(cardsDelta)/Double(maxCardsCount)) * Double(maxDeltaRatio)
    
    return dynamicRatio
  }
  
}
