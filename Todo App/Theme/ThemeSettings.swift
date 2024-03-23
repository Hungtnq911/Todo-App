//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Hưng Trần on 23/3/24.
//

import SwiftUI

final public class ThemeSettings: ObservableObject{
    @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme"){
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    private init(){}
    public static let shared = ThemeSettings()
}
