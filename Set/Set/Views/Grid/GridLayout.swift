//
//  GridLayout.swift
//  Memorize
//
//  Created by CS193p Instructor.
//  Copyright © 2020 Stanford University. All rights reserved.
//
import SwiftUI

struct GridLayout {
  private var size: CGSize
  private var itemCount: Int
  private var rowCount: Int = 0
  private var columnCount: Int = 0
  
  private var spacingValue: CGFloat = .zero
  
  init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize, spacingValue: CGFloat = .zero) {
    self.size = size
    self.itemCount = itemCount
    self.spacingValue = spacingValue
    // if our size is zero width or height or the itemCount is not > 0
    // then we have no work to do (because our rowCount & columnCount will be zero)
    guard size.width != 0, size.height != 0, itemCount > 0 else { return }
    // find the bestLayout
    // i.e., one which results in cells whose aspectRatio
    // has the smallestVariance from desiredAspectRatio
    // not necessarily most optimal code to do this, but easy to follow (hopefully)
    var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
    var smallestVariance: Double?
    let sizeAspectRatio = abs(Double(size.width/size.height))
    for rows in 1...itemCount {
      let columns = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)
      if (rows - 1) * columns < itemCount {
        let itemAspectRatio = sizeAspectRatio * (Double(rows)/Double(columns))
        let variance = abs(itemAspectRatio - desiredAspectRatio)
        if smallestVariance == nil || variance < smallestVariance! {
          smallestVariance = variance
          bestLayout = (rowCount: rows, columnCount: columns)
        }
      }
    }
    rowCount = bestLayout.rowCount
    columnCount = bestLayout.columnCount
  }
  
  public var itemSize: CGSize {
    if rowCount == 0 || columnCount == 0 {
      return CGSize.zero
    } else {
      return CGSize(
        width: (size.width / CGFloat(columnCount) - spacingValue/2),
        height: (size.height / CGFloat(rowCount) - spacingValue/2)
      )
    }
  }
  
  public func location(ofItemAt index: Int) -> CGPoint {
    if rowCount == 0 || columnCount == 0 {
      return CGPoint.zero
    } else {
      let xPaddingValue = paddingValue(for: index, columnCount: columnCount, point: .x)
      let yPaddingValue = paddingValue(for: index, columnCount: columnCount, point: .y)
      return CGPoint(
        x: ((CGFloat(index % columnCount) + 0.5) * itemSize.width) + xPaddingValue,
        y: ((CGFloat(index / columnCount) + 0.5) * itemSize.height) + yPaddingValue
      )
    }
  }
  
  enum CardPoint { case x, y }
  
  private func paddingValue(for index: Int, columnCount: Int, point: CardPoint) -> CGFloat {
    var paddingValue: CGFloat = 0
    
    //dynamic spacing between cards in grid
    let rowIndex = point == .x
    ? (index + columnCount) % columnCount //for rows
    : (index) / (columnCount) //for columns
    
    switch rowIndex {
    case 0:
      paddingValue = 0 //first item in row/column
    case (columnCount - 1):
      paddingValue = spacingValue //last item in row/column
    default:
      let coff = Double(rowIndex) / Double(columnCount - 1)
      let delta = coff * spacingValue
      paddingValue = CGFloat(delta)
    }
    
    return paddingValue
  }
}
