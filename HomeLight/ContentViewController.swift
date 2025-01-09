//
//  ContentViewController.swift
//  HomeLight
//
//  Created by Vitaly on 07.01.2025.
//

import Foundation
import SwiftUI


final class ContentViewController: ObservableObject {

    @Published var homeStatus = HomeStatus()
    var networkService = NetworkService()
    
//    func test() {
//        Task {
//            let st = try? await networkService.getLightStatus()
//            print("Fetched status: \(String(describing: st))")
//            
//        }
//    }
    
    func toogleLight() async {
        print("toogleLight - \(homeStatus.state)")
        switch homeStatus.state {
        case .on:
            await turnLightOff()
        case .off:
            await turnLightOn()
        case .unknown:
            await getLightStatus()
            break
        }
    }
    @MainActor
    func turnLightOn() async {
        print("turnLightOn - \(homeStatus.state)")
        do {
            try await networkService.turnOnLight()
            homeStatus.state = .on
        } catch {
            homeStatus.state = .unknown
        }
        print("turnLightOn end - \(homeStatus.state)")
    }
    @MainActor
    func turnLightOff() async {
        print("turnLightOff - \(homeStatus.state)")
        do {
            try await networkService.turnOffLight()
            homeStatus.state = .off
        } catch {
            homeStatus.state = .unknown
        }
        print("turnLightOff end - \(homeStatus.state)")
    }
    @MainActor
    func getLightStatus() async {
        print("getLightStatus - \(homeStatus.state)")
        do {
            let lightStatus = try await networkService.getLightStatus()
            homeStatus.state =   HomeState( rawValue: lightStatus) ?? .unknown
        } catch {
            homeStatus.state = .unknown
        }
        print("getLightStatus end - \(homeStatus.state)")
    }
    
}
