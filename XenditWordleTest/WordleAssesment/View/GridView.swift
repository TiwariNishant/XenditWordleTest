//
//  GridView.swift
//  WordleAssesment
//
//  Created by webwerks on 17/03/22.
//

import SwiftUI


struct GridView<Content: View>: View {

    typealias GridItemFactory = (_ row: Int, _ column: Int) -> Content

    let width: Int
    let height: Int
    let spacing: CGFloat
    let gridItemFactory: GridItemFactory

    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: width)
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: spacing) {
            ForEach(0..<height) { row in
                ForEach(0..<width) { column in
                    gridItemFactory(row, column)
                        .id("MatrixGrid_Item_\(row)×\(column)")
                }
            }
        }
    }
}
