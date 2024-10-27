//
//  ContentView.swift
//  learing1
//
//  Created by Fay Turad Madani on 20/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTimeFrame = "Month"
    @State private var learningTopic = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            // Fire emoji icon as in the image
            ZStack {
                Circle()
                    .fill(Color(red: 44/255, green: 44/255, blue: 46/255))

                    .frame(width: 100, height: 100)
                Text("🔥")
                    .font(.system(size: 60))
            }
            Text("he")
            .padding(.top, 50)
            HStack{
                VStack(alignment:.leading){
                    // Greeting Text
                    Text("Hello Learner!")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Subtext description
                    Text("This app will help you learn everyday")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 40)
                }
                Spacer()
            }
            .padding(.top,20)
                // TextField with just a bottom line
                VStack(alignment: .leading, spacing: 3) {
                    Text("I want to learn")
                    
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    VStack {
                        TextField("Swift", text: $learningTopic)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        
                        // Bottom line for the TextField
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 30)
                }.padding(.horizontal, 8)
                
                // Timeframe Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("I want to learn it in a")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                
                
            
                
                    HStack(spacing: 10) { // Even spacing between buttons
                        // Week Button
                        Button(action: {
                            selectedTimeFrame = "Week"
                        }) {
                            Text("Week")
                                .fontWeight(selectedTimeFrame == "Week" ? .semibold : .regular) // Semi-bold when selected
                                .foregroundColor(selectedTimeFrame == "Week" ? .black : .orange) // Black text when selected
                                .frame(width: 80, height: 40)
                                .background(selectedTimeFrame == "Week" ? Color.orange : Color.gray.opacity(0.2)) // Orange background when selected
                                .cornerRadius(6)
                        }
                        
                        // Month Button
                        Button(action: {
                            selectedTimeFrame = "Month"
                        }) {
                            Text("Month")
                                .fontWeight(selectedTimeFrame == "Month" ? .semibold : .regular) // Semi-bold when selected
                                .foregroundColor(selectedTimeFrame == "Month" ? .black : .orange) // Black text when selected
                                .frame(width: 80, height: 40)
                                .background(selectedTimeFrame == "Month" ? Color.orange : Color.gray.opacity(0.2)) // Orange background when selected
                                .cornerRadius(6)
                        }
                        
                        // Year Button
                        Button(action: {
                            selectedTimeFrame = "Year"
                        }) {
                            Text("Year")
                                .fontWeight(selectedTimeFrame == "Year" ? .semibold : .regular) // Semi-bold when selected
                                .foregroundColor(selectedTimeFrame == "Year" ? .black : .orange) // Black text when selected
                                .frame(width: 80, height: 40)
                                .background(selectedTimeFrame == "Year" ? Color.orange : Color.gray.opacity(0.2)) // Orange background when selected
                                .cornerRadius(6)
                        }
                    }
                
                    .padding(.bottom, 40)
                }.padding(.horizontal, 40)
                
                // Start Button
                Button(action: {
                    // Action to start learning process
                }) {
                    
                    Text("Start →")
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .frame(width: 200)
                    
                    
                }
                
                Spacer()
                
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        
        }
    
    }
    
    struct LearningAppView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    
    
    





