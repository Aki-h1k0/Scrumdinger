//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by  aki-hiko on 2023/02/26.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment (\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    @State private var showDeleteAllDialog = false
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($scrums) { $scrum in
                    NavigationLink (destination: DetailView(scrum: $scrum)) {
                        CardView(scrum: scrum)
                    }
                    .listRowBackground(scrum.theme.mainColor)
                }
                .onDelete { index in
                    scrums.remove(atOffsets: index)
                }
            }
            .navigationTitle("Daily Scrum")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    showDeleteAllDialog = true
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .alert("Confirm", isPresented: $showDeleteAllDialog) {
            Button("OK") {
                scrums.removeAll()
                showDeleteAllDialog = false
            }
            Button("Cancel") {
                showDeleteAllDialog = false
            }
        } message: {
            Text("Are you sure to delete all?")
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.members), saveAction: {})
    }
}
