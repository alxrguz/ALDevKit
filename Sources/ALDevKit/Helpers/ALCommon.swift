//
//  ALCommon.swift
//  
//
//  Created by Alexandr Guzenko on 03.11.2020.
//

import Foundation

public enum ALCommon {
    public static func wait(time: TimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            completion()
        }
    }
}
