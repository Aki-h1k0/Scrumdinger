//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by aki on 2024/01/06.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumView: Bool
    @State private var controlState: ControlState = .defaultState
    @State private var isPresentingAlertDialog = false
    
    enum ControlState {
        case titleEmpty
        case titleDuplicated
        case attendeesNotEnough
        case defaultState
    }
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            checkInputInfo()
                            if !isPresentingAlertDialog {
                                scrums.append(newScrum)
                                isPresentingNewScrumView = false
                            }
                        }
                    }
                }
                .alert("", isPresented: $isPresentingAlertDialog) {
                    Button("OK") {
                        controlState = .defaultState
                    }
                } message: {
                    switch controlState {
                    case .titleEmpty:
                        Text("input any title")
                    case .titleDuplicated:
                        Text("title of \"\(newScrum.title)\" what already exsits")
                    case .attendeesNotEnough:
                        Text("You need more attendees. Do not be lonely...")
                    default:
                        Text("")
                    }
                }
        }
    }
    
    private func checkInputInfo() {
        isPresentingAlertDialog = false
        
        if newScrum.attendees.count < 2 { controlState = .attendeesNotEnough }
//        ForEach(scrums) { scrum in
//            if scrum.title == newScrum.title { controlState = .titleDuplicated }
//        }
        if newScrum.title.isEmpty { controlState = .titleEmpty }
        
        if controlState != .defaultState { isPresentingAlertDialog = true }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(scrums: .constant(DailyScrum.members),
                      isPresentingNewScrumView: .constant(true))
    }
}
