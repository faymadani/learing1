import SwiftUI

struct WeeklyCalendarView: View {
    @State var background = Color.black
    @State private var currentWeekOffset = 0
    @State private var selectedDate: Date?
    @State private var isFrozen = false // حالة لتتبع تجميد اليوم
    @State private var isLearnedToday = false // حالة لتتبع تعلم اليوم
    @State private var dayStreak = 10
    @State private var freezeDaysUsed = 2
    private let maxFreezeDays = 6

    private let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    private var currentWeek: [Date] {
        let calendar = Calendar.current
        let today = Date()
        
        if let startOfWeek = calendar.startOfWeek(for: today) {
            return (0..<7).compactMap { dayOffset in
                calendar.date(byAdding: .day, value: dayOffset + currentWeekOffset * 7, to: startOfWeek)
            }
        } else {
            return []
        }
    }
    
    private var currentDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM"
        return formatter.string(from: Date())
    }

    private var currentMonthAndYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentWeek.first ?? Date())
    }

    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(currentDateString.uppercased())
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text("Learning Swift")
                            .foregroundColor(.white)
                            .font(.title.bold())
                    }
                    Spacer()
                    
                    // أيقونة موجي في الأعلى
                    Image(systemName: "waveform.path.ecg")
                        .foregroundColor(.orange)
                        .font(.title)
                }
                .padding(.horizontal)

                VStack {
                    HStack {
                        Text(currentMonthAndYear)
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                currentWeekOffset -= 1
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 5)
                            }

                            Button(action: {
                                currentWeekOffset += 1
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 5)
                            }
                        }
                    }
                    .padding(.horizontal)

                    HStack(spacing: 0) {
                        ForEach(currentWeek.indices, id: \.self) { index in
                            VStack(spacing: 5) {
                                Text(daysOfWeek[index])
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                
                                if !currentWeek.isEmpty {
                                    let day = currentWeek[index]
                                    let dayNumber = Calendar.current.component(.day, from: day)
                                    
                                    Circle()
                                        .fill(day == selectedDate ? Color.orange : Color.clear)
                                        .frame(width: 30, height: 30)
                                        .overlay(
                                            Text("\(dayNumber)")
                                                .foregroundColor(day == selectedDate ? .white : .orange)
                                        )
                                        .onTapGesture {
                                            selectedDate = day
                                            isLearnedToday = false
                                            isFrozen = false // إعادة تعيين عند اختيار يوم جديد
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical, 10)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                        .padding(.vertical, 10)

                    HStack {
                        VStack {
                            Text("\(dayStreak) 🔥")
                                .font(.title)
                                .foregroundColor(.orange)
                            Text("Day streak")
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)

                        Rectangle()
                            .frame(width: 1, height: 40)
                            .foregroundColor(.gray)

                        VStack {
                            Text("\(freezeDaysUsed) 🧊")
                                .font(.title)
                                .foregroundColor(.blue)
                            Text("Day frozen")
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)

                // دائرة تتغير حسب الحالة
                ZStack {
                    Circle()
                        .fill(isFrozen ? Color(red: 2/255, green: 31/255, blue: 61/255) : (isLearnedToday ? Color(red: 66/255, green: 40/255, blue: 0/255) : Color.orange))
                        .frame(width: 280, height: 280)
                        .onTapGesture {
                            isLearnedToday = true
                            isFrozen = false
                        }

                    Text(isFrozen ? "Day Freezed" : (isLearnedToday ? "Learned Today" : "Log today as Learned"))
                        .foregroundColor(isFrozen ? .blue : (isLearnedToday ? .orange : .black))
                        .font(.largeTitle.bold())
                }
                .padding(.top, 20)

                // زر Freeze day
                Button(action: {
                    if freezeDaysUsed < maxFreezeDays && !isLearnedToday {
                        isFrozen = true
                        isLearnedToday = false // تأكد من إلغاء "Learned Today"
                        freezeDaysUsed += 1
                    }
                }) {
                    Text("Freeze day")
                        .foregroundColor(isFrozen || isLearnedToday ? .gray : .blue)
                        .font(.headline)
                        .frame(width: 150, height: 50)
                        .background(isFrozen || isLearnedToday ? Color(red: 44/255, green: 44/255, blue: 46/255) : Color.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)

                Text("\(freezeDaysUsed) out of \(maxFreezeDays) freezes used")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding()
        }
    }
}

extension Calendar {
    func startOfWeek(for date: Date) -> Date? {
        var components = self.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        components.weekday = 1
        return self.date(from: components)
    }
}

struct WeeklyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCalendarView()
    }
}

