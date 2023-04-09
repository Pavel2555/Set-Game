//
//  ContentView.swift
//  Set
//
//  Created by Павел Бескоровайный on 05.04.2023.
//

import SwiftUI

struct SetCardGameView: View {
  @StateObject var viewModel = SetCardGame()
  @State var shouldDelay: Bool = true
  
  static let mainBackgroundColor: Color = .blue
  
  var body: some View {
    GeometryReader { geom in
      Grid(viewModel.cards) { card in
        CardView(card: card)
          .transition(AnyTransition.asymmetric(
            insertion: AnyTransition.offset(flyFrom(for: geom.size)),
            removal: AnyTransition.offset(flyTo(for: geom.size)))
            .combined(with: AnyTransition.scale(scale: 0.5)))
          .animation(Animation.easeInOut(duration: 0.5)
            .delay(transitionDelay(card: card)), value: 0)
           
          .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
              viewModel.choose(card: card)
            }
          }
          .padding(2)
      }
      .onAppear {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
          deal()
        }
      }
      .padding(2)
      .background(SetCardGameView.mainBackgroundColor)
    }
  }
  
  private func deal() {
    viewModel.deal()
    DispatchQueue.main.async {
      shouldDelay = false
    }

  }
  
  private func flyFrom(for size: CGSize) -> CGSize {
    CGSize(width: 0.0, height: size.height)
  }
  
  private func flyTo(for size: CGSize) -> CGSize {
    CGSize(width: CGFloat.random(in: -3*size.width...3*size.width), height: CGFloat.random(in: -2*size.height...(-size.height)))
  }
  
  private let cardTransitionDelay: Double = 0.2
  
  private func transitionDelay(card: SetGame<SetCard>.Card) -> Double {
    guard shouldDelay else { return 0 }
    return Double(viewModel.cards.firstIndex(matching: card)!) * cardTransitionDelay
  }
  
  struct CardView: View {
    var card: SetGame<SetCard>.Card
    var borderColors: [Color] = [.red, .black, .yellow]
    
    var body: some View {
      if card.isSelected || !card.isMatched {
        SetCardView(card: card.content)
          .background(.white)
          .cornerRadius(cornerRadius)
          .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
              .stroke(highlightColor(), lineWidth: borderLineWidth)
          )
      }
    }
    
    private let cornerRadius: CGFloat = 20
    private let borderLineWidth: CGFloat = 8
    
    private func highlightColor() -> Color {
      var color: Color = .white
      
      if card.isSelected {
        if card.isMatched {
          color = borderColors[0]
        } else if card.isNotMatched {
          color = borderColors[1]
        } else {
          color = borderColors[2]
        }
      } else {
        color = SetCardGameView.mainBackgroundColor
      }
      return color
    }
  }
}

struct SetCardGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetCardGameView()
  }
}
