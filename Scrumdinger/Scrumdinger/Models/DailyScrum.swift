//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by  aki-hiko on 2022/12/03.
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map{ Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}

extension DailyScrum {
    static let members: [DailyScrum] = [
        DailyScrum(title: "Organizers", attendees: ["Takeuchi", "Kuroda"], lengthInMinutes: 20, theme: .yellow),
        DailyScrum(title: "Members", attendees: ["Kurita", "Akiyoshi", "Hirai", "Yokota", "Matsuda", "Nagasawa"], lengthInMinutes: 20, theme: .orange)
    ]
}
