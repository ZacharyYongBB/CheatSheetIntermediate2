//
//  TimerExample.swift
//  CheatSheetIntermediate2
//
//  Created by Zachary on 27/10/22.
//

import SwiftUI

struct TimerExample: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Current Time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText:String? = nil
    */
    
    // Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour): \(minute): \(second)"
    }
     */
    
    // Animation counter
    // tabview / carousel advertisement
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
            // circles for animation
            /*
//            HStack (spacing: 15){
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)
             */
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)

            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
        }
        .onReceive(timer) { output in
            
            //Current Time
//            currentDate = output
            
            // Countdown
//            if count <= 1 {
//                finishedText = "WOWSIE!"
//            } else {
//                count -= 1
//            }
            
            // Countdown to date
//            updateTimeRemaining()
            
            // Animation Counter
//            withAnimation(.easeInOut(duration: 1)) {
//                count = count == 3 ? 0 : count + 1
//            }
            
            // Tabviews
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

struct TimerExample_Previews: PreviewProvider {
    static var previews: some View {
        TimerExample()
    }
}
