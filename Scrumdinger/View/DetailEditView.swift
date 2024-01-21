//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by  aki-hiko on 2023/07/01.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    @State private var isPresenting: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 2...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    HStack {
                        Text(attendee.name)
                        Spacer()
                        Image(systemName: "equal")
                    }
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                .onMove(perform: moveRow)
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            let attendees = scrum.attendees
                            if attendees.count > 0 {
                                for attendee in attendees {
                                    if attendee.name == newAttendeeName { isPresenting = true }
                                }
                            }
                            if !isPresenting {
                                scrum.attendees.append(attendee)
                                newAttendeeName = ""
                            }
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
            .alert("", isPresented: $isPresenting) {
                Button("OK") {
                    isPresenting = false
                    newAttendeeName = ""
                }
            } message: {
                Text("attendee name of \"\(newAttendeeName)\" already exsits")
            }
        }
    }
    
    private func moveRow(from source: IndexSet, to destination: Int) {
        scrum.attendees.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.members[0]))
    }
}
