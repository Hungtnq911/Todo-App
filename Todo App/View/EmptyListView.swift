//
//  EmptyListView.swift
//  Todo App
//
//  Created by Hưng Trần on 20/3/24.
//

import SwiftUI

struct EmptyListView: View {
    //MARK: - PROPERTIES
    @State private var isAnimated:Bool = false
    
    let images: [String] = [
    "illustration-no1",
    "illustration-no2",
    "illustration-no3"
    ]
    let tips:[String] = [
    "Use your time wisely.",
    "Slow and steady wins the race.",
    "Keep it short and sweet.",
    "Put hard tasks first.",
    "Reward yourself after work.",
    "Collect tasks ahead of time.",
    "Each night schedule for tomorrow."
    ]
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment:.center,spacing: 20) {
                Image("\(images.randomElement() ?? self.images[0])")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256,idealWidth: 280,maxWidth: 360,minHeight: 256,idealHeight: 280,maxHeight: 360,alignment: .center)
                    .layoutPriority(1)
                    .foregroundStyle(themes[self.theme.themeSettings].themeColor)
                    
                
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline,design: .rounded))
                    .foregroundStyle(themes[self.theme.themeSettings].themeColor)
            }//: Vstack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.linear(duration: 1.5),value: isAnimated)
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }//: Zstack
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
        .background(Color.colorBase)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    EmptyListView()
}
