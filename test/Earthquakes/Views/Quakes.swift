/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The views of the app, which display details of the fetched earthquake data.
*/

import SwiftUI

let staticData: [Quake] = [
    Quake(magnitude: 0.8,
          place: "Shakey Acres",
          time: Date(timeIntervalSinceNow: -1000),
          code: "nc73649170",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!),
    Quake(magnitude: 2.2,
          place: "Rumble Alley",
          time: Date(timeIntervalSinceNow: -5000),
          code: "hv72783692",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!)
    ]

struct Quakes: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @EnvironmentObject var provider: QuakesProvier
    @State var quakes = staticData
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(quakes) { quake in
                    NavigationLink(destination: QuakeDetail(quake: quake)) {
                        QuakeRow(quake: quake)
                    }
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
            .refreshable {
                await fetchQuakes()
            }
            .task {
                await fetchQuakes()
            }
        }
        
    }
}

extension Quakes {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }

    func deleteQuakes(at offsets: IndexSet) {
//        quakes.remove(atOffsets: offsets)
        provider.deleteQuakes(atOffsets: offsets)
    }
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    func fetchQuakes() async {
        isLoading = true
        do {
            try await provider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970
        } catch {
//            self.error = error as? QuakeError ?? .unexpectedError(error: error)
//                        self.hasError = true
        }
        
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

struct Quakes_Previews: PreviewProvider {
    static var previews: some View {
        Quakes()
            .environmentObject(
                            QuakesProvier(client:
                                            QuakeClient(downloader: TestDownloader())))
    }
}
