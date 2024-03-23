//
//  SettingView.swift
//  Todo App
//
//  Created by Hưng Trần on 21/3/24.
//

import SwiftUI

struct SettingView: View {
    //MARK: - Properties
    @AppStorage("currentIndex") private var currentIndex = 0
    
    @Environment(\.dismiss) var dismiss
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    
    private let customIcons: [String] = [
        "AppIcon-Blue",
        "AppIcon-Blue-Dark",
        "AppIcon-Blue-Light",
        "AppIcon-Pink",
        "AppIcon-Pink-Dark",
        "AppIcon-Pink-Light",
        "AppIcon-Green",
        "AppIcon-Green-Dark",
        "AppIcon-Green-Light"
    ]
    
    //MARK: - BODY
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                Form{
                    //MARK: Section 1
                    Section(header: Text("Choose the app icon")){
                        Picker(selection: $currentIndex, label: HStack {
                            Image(systemName: "paintbrush.fill")
                            Text("App Icons")
                        }){
                            ForEach(customIcons.indices, id: \.self){index in
                                
                                Image("\(customIcons[index])-Preview")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .onChange(of: currentIndex){
                            UIApplication.shared.setAlternateIconName(customIcons[currentIndex]){
                                error in
                                if let error = error {
                                    print("Failed request to update the app's icon: \(String(describing: error.localizedDescription))")
                                }else{
                                    print("Succes! you have changed the app's icon")
                                }
                            }
                        }
                    }
                        .padding(.vertical,3)
                        
                    //MARK: SECTION 2
                    Section(header: HStack {
                        Text("Choose the app Theme")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(themes[self.theme.themeSettings].themeColor)
                    }){
                        List(themes, id:\.id) { theme in
                            
                            Button(action:{
                                self.theme.themeSettings = theme.id
                                
                            }){
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(theme.themeColor)
                                    Text(theme.themeName)
                                }
                                
                            }
                            .tint(Color.primary)
                        }
                        
                    }
                    
                    
                    //MARK: SECTION 3
                        Section(header: Text("About the application")){
                            FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                            FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "Iphone,Ipad")
                            FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Hung T.N.Q")
                            FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                            FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        }
                        .padding(.vertical,3)
                    }
                    //: Form
                    
                    //MARK: - FOOTER
                    
                    
                }//:Vstack
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color("ColorBackground").ignoresSafeArea())
                .toolbar{
                    ToolbarItem(placement:.topBarTrailing){
                        Button(action:{
                            self.dismiss()
                        }){
                            Image(systemName:"xmark")
                        }
                    }
                }
            }//:NavigationStack
        .tint(themes[self.theme.themeSettings].themeColor)
        }
    }
#Preview {
    SettingView()
}
