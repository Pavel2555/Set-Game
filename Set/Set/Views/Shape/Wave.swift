//
//  Wave.swift
//  Set
//
//  Created by Павел Бескоровайный on 06.04.2023.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
      let sqdx = rect.width * 0.1
      let sqdy = rect.height * 0.2
      
      path.move(to: CGPoint(x: rect.minX, y: rect.midY))
      
      path.addCurve(to: CGPoint(x: rect.minX + rect.width * 1/2,
      y: rect.minY + rect.height / 8),
                    control1: CGPoint(x: rect.minX,y: rect.minY),
                    control2: CGPoint(x: rect.minX + rect.width * 1/2 - sqdx,
      y: rect.minY + rect.height / 8 - sqdy))

      path.addCurve(to: CGPoint(x: rect.minX + rect.width * 4/5,
                                y: rect.minY + rect.height / 8),
                    control1: CGPoint(x: rect.minX + rect.width * 1/2 + sqdx,
                                      y: rect.minY + rect.height / 8 + sqdy),
                    control2: CGPoint(x: rect.minX + rect.width * 4/5 - sqdx,
                                      y: rect.minY + rect.height / 8 + sqdy))
      
      path.addCurve(to: CGPoint(x: rect.minX + rect.width,
                                y: rect.minY + rect.height / 2),
                    control1: CGPoint(x: rect.minX + rect.width * 4/5 + sqdx,
                                      y: rect.minY + rect.height / 8 - sqdy),
                    control2: CGPoint(x: rect.minX + rect.width,
                                      y: rect.minY))
      var mirrorPath = path
      mirrorPath = mirrorPath.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
      mirrorPath = mirrorPath.applying(CGAffineTransform.identity.translatedBy(x: rect.size.width, y: rect.size.height))
      path.move(to: CGPoint(x: rect.minX,
      y: rect.midY))
      path.addPath(mirrorPath)
      
      return path
    }
}



struct Squiggle_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      Squiggle().opacity(0.4)
      Squiggle().foregroundColor(.red)
      Squiggle().stroke()
    }.padding()
    
  }
  
}
