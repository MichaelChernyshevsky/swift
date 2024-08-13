import SwiftUI

struct TimerView: View {
    @State private var timeSave = 60
    @State private var timeRemaining = 60
    @State private var timerIsRunning = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("Time Remaining: \(timeString(time: timeRemaining))")
                .font(.largeTitle)
                .padding()
            
            HStack {
                Button(action: startTimer) {
                    Text("Start")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: stopTimer) {
                    Text("Stop")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: resetTimer) {
                    Text("Reset")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            HStack {
                Button(action: increase) {
                    Text("+1")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                if (timeSave > 60){
                    Button(action: decrease) {
                        Text("-1")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
               
                
                
            }
        }
    }
    
    func startTimer() {
        if !timerIsRunning {
            timerIsRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    stopTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timerIsRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timeRemaining = timeSave
    }
    
    func increase() {
       
        timeRemaining += 60
        timeSave += 60
    }
    
    func decrease() {
        timeRemaining  -= 60
        timeSave  -= 60
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
