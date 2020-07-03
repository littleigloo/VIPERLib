//
//  Enums.swift
//  VIPER Implementation
//
//  Created by Vitalis on 15/05/20.
//  Copyright © 2020 Neiron Digital. All rights reserved.
//

public enum ControllerPresentationStyle {
    case presented
    case pushed(PushedStyle)
    // ...........
    public enum PushedStyle {
        case `default`
        case fade
        case slide
    }
}
