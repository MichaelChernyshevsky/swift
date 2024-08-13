//
//  screen.swift
//  SwiftMobile
//
//  Created by Mihail_Ch on 13.08.2024.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                
                
                Text("Welcome to App")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                VStack {
                    NavigationLink(destination: EconomyView()) {
                        Text("Economy")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: TimerView()) {
                        Text("Timer")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
