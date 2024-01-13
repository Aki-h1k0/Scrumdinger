//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by  aki-hiko on 2023/02/26.
//

import SwiftUI

struct TrailingIconLabelstyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelstyle {
    static var trailingIcon: Self { Self() }
}
