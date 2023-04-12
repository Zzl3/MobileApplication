//
//  Animations.swift
//  Music
//
//  Created by sihhd on 2023/4/12.
//

import SwiftUI

var debugAnimations = false

extension Animation {
    static var openCard: Animation { debugAnimations ? debug : .spring(response: 0.5, dampingFraction: 0.7) }

    static var closeCard: Animation { debugAnimations ? debug : .spring(response: 0.6, dampingFraction: 0.8) }

    static var blur: Animation { debugAnimations ? debug : .linear(duration: 0.25) }
    
    static var debug: Animation { .linear }
}
