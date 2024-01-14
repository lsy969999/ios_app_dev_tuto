//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by SY L on 1/14/24.
//

import SwiftUI
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: TrailingIconLabelStyle {TrailingIconLabelStyle()}
}
