//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by SY L on 1/14/24.
//

import SwiftUI

struct ScrumView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrum")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) {  newPhase in
            if newPhase == .inactive{
                self.saveAction()
            }
        }
        
    }
}

#Preview {
    ScrumView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
}
