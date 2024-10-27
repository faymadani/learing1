//
//  learing1App.swift
//  learing1
//
//  Created by Fay Turad Madani on 20/04/1446 AH.
//

import SwiftUI

struct Learning: View {
    @State private var currentDate = Date()
    @State private var streakCount = 10
    @State private var frozenDays = 2
    @State private var freezeLimit = 6
    @State private var learnedToday = false
    
    var body: some View {
        VStack {
            // Top Section - Title and Streak
            HStack {
                Text("Learning Swift")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
            }
            .padding()

            // Calendar View
            VStack {
                Text(currentDate, style: .date)
                    .font(.headline)
                    .padding(.bottom, 10)
                
                CalendarView(currentDate: $currentDate)
                    .padding(.bottom, 20)
                
                // Streak and Frozen Days Display
                HStack {
                    VStack {
                        Text("\(streakCount) 🔥")
                        Text("Day streak")
                            .font(.subheadline)
                    }
                    Spacer()
                    VStack {
                        Text("\(frozenDays) ❄️")
                        Text("Day frozen")
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.black.opacity(0.1))
            .cornerRadius(15)
            .padding()

            // Learned Today Button
            Button(action: {
                learnedToday.toggle()
                if learnedToday {
                    streakCount += 1
                }
            }) {
                Text(learnedToday ? "Learned Today" : "Learn Today")
                    .frame(width: 200, height: 200)
                    .background(learnedToday ? Color.orange : Color.gray)
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
            }
            .padding()
            
            // Freeze Day Button
            Button(action: {
                if frozenDays < freezeLimit {
                    frozenDays += 1
                }
            }) {
                Text("Freeze day")
                    .frame(width: 150, height: 50)
                    .background(Color.gray.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text("2 out of \(freezeLimit) freezes used")
                .font(.subheadline)
                .padding(.top, 10)
        }
        .padding()
    }
}

struct CalendarView: View {
    @Binding var currentDate: Date
    
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    var body: some View {
        let today = calendar.startOfDay(for: Date())
        let startDate = calendar.date(byAdding: .day, value: -5, to: today) ?? today
        let endDate = calendar.date(byAdding: .day, value: 6, to: today) ?? today

        let dates = stride(from: startDate, to: endDate, by: 86400).map { $0 }
        
        HStack(spacing: 15) {
            ForEach(dates, id: \.self) { date in
                VStack {
                    Text(self.dateFormatter.string(from: date))
                        .font(.headline)
                        .foregroundColor(self.isToday(date: date) ? .orange : .primary)
                    
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(self.isToday(date: date) ? .orange : .clear)
                }
            }
        }
    }
    
    private func isToday(date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: currentDate)
    }
}


@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
