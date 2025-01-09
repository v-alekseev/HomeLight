//
//  HomeStatus.swift
//  HomeLight
//
//  Created by Vitaly on 07.01.2025.
//

import SwiftUI

enum HomeState: Int {
    case on = 1
    case off = 0
    case unknown = 100
}

struct HomeStatus: Hashable {
    var state : HomeState = .unknown
    
    var isLightOn: Bool {
        state == .on
    }
    
    var isConnected: Bool {
        state != .unknown
    }
    
    func getString(on: String, off: String, unknown: String) -> String {
        switch state {
        case .on:
            return on
        case .off:
            return off
        case .unknown:
            return unknown
        }
    }
    
    func getColors(on: Color, off: Color, unknown: Color) -> Color {
        switch state {
        case .on:
            return on
        case .off:
            return off
        case .unknown:
            return unknown
        }
    }
    
    // debug
    mutating func invertState() {
        if(state == .on) {
            state = .off
        }
        else {
            state = .on
        }
    }
}
