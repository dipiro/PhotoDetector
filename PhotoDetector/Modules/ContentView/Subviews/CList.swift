//
//  CList.swift
//  PhotoDetector
//
//  Created by piro2 on 6/2/24.
//

import SwiftUI

struct CList<Item: Hashable & Identifiable, Label: View>: View {
    var items: [Item]
    var label: (Item) -> Label
    
    // MARK: - Body
    var body: some View {
        List(items) { item in
           label(item)
        }
        .scrollContentBackground(.hidden)
    }
}
