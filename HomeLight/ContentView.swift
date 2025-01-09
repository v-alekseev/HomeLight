//
//  ContentView.swift
//  HomeLight
//
//  Created by Vitaly on 07.01.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vc: ContentViewController
    
    let backgroundImages: [HomeState: String] = [
        .off: "house1",
        .on: "house2",
        .unknown: "house3"
    ]
    let buttonTitles: [HomeState: String] = [
        .off: "On",
        .on: "Off",
        .unknown: "Connect"
    ]
    let buttonImages: [HomeState: String] = [
        .off: "power.circle",
        .on: "poweroff",
        .unknown: "network.slash"
    ]
    let buttonColors: [HomeState: Color] = [
        .off: .green,
        .on: .red,
        .unknown: .orange
    ]
    
    var backgroundImage: String {
        backgroundImages[vc.homeStatus.state] ?? "hlon_test"
    }
    var buttonTitle: String {
        buttonTitles[vc.homeStatus.state] ?? "Unknown"
    }
    var buttonImage: String {
        buttonImages[vc.homeStatus.state] ?? "lightbulb.min.badge.exclamationmark"
    }
    var buttonColor: Color {
        buttonColors[vc.homeStatus.state] ?? .gray
    }
    
    var body: some View {
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0)
                .edgesIgnoringSafeArea(.all)
            Button(action: toogleLight)
            {
                HStack {
                    Text(buttonTitle)
                        .font(.title)
                    Image(systemName: buttonImage)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(buttonColor )
                .cornerRadius(20)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }

    private func getStatus() {
        withAnimation {
            print("press \(vc.homeStatus.isLightOn)")
            Task {
                await vc.getLightStatus()
            }
            
        }
    }
    
    private func toogleLight() {
        withAnimation {
            print("toogleLight \(vc.homeStatus.isLightOn)")
            Task {
                await vc.toogleLight()
            }
        }
    }
}

#Preview {
    ContentView(vc: ContentViewController())
}
