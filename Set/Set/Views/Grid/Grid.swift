//
//  Grid.swift
//  Memorize
//
//  Created by CS193P Instructor on 04/06/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//
import SwiftUI

struct Grid <Item, ItemView>: View where Item: Identifiable, ItemView: View {
  var items: [Item]
  var viewForItem: (Item) -> ItemView
  var spacingValue: CGFloat = .zero
  
  init(_ items: [Item], spacingValue: CGFloat, viewForItem: @escaping (Item) -> ItemView ){
    self.items = items
    self.spacingValue = spacingValue
    self.viewForItem = viewForItem
  }
  
  var body: some View {
    GeometryReader { geometry in
      self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size, spacingValue: spacingValue))
    }
  }
  
  func body(for layout: GridLayout)-> some View {
    ForEach(items) {item in
      self.body(for: item, in: layout)
    }
  }
  
  func body(for item: Item, in layout: GridLayout) -> some View {
    let index = items.firstIndex(matching: item)!
    return viewForItem (item)
      .frame(width: layout.itemSize.width, height: layout.itemSize.height)
      .position (layout.location(ofItemAt: index))
  }
}
