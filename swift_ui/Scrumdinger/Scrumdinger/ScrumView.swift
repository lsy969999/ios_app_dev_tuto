//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by SY L on 1/14/24.
//

import SwiftUI

struct ScrumView: View {
    let scrums: [DailyScrum]
    var body: some View {
        List(scrums) { scrum in
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColor)
        }
    }
}

#Preview {
    ScrumView(scrums: DailyScrum.sampleData)
}
