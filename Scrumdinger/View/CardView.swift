//
//  CardView.swift
//  Scrumdinger
//
//  Created by  aki-hiko on 2023/01/07.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    var body: some View {
        let attendees = scrum.attendees.count
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(attendees)", systemImage: attendees > 2 ? "person.3" : "person.2")
                    .accessibilityLabel("\(attendees) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.members[0]
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
