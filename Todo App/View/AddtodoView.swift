//
//  AddtodoView.swift
//  Todo App
//
//  Created by Hưng Trần on 18/3/24.
//

import SwiftUI

struct AddtodoView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High","Normal","Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment:.leading,spacing: 20){
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                        .font(.system(size: 24,weight: .bold,design: .default))
                    
                    // MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                   // MARK: - Save Button
                    Button(action:{
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            do{
                                try self.managedObjectContext.save()
                                //print("New todo: \(todo.name ?? ""), Priority:\(todo.priority ?? "") ")
                            }catch{
                                print(error)
                            }
                        }else{
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make Sure to enter something for new todo item."
                            return
                        }
                        self.dismiss()
                    }){
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor)
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                            .foregroundColor(.white)
                    }
                    
                }//: Vstack
                .padding(.horizontal)
                .padding(.vertical)
                
                Spacer()
            }//: VStack
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action:{
                        self.dismiss()
                    }){
                        Image(systemName: "xmark")
                    }
                }
            }
            .alert(isPresented: $errorShowing){
                Alert(title: Text(errorTitle),message: Text(errorMessage),dismissButton: .default(Text("OK")))
            }
        }//: Navigation
        .tint(themes[self.theme.themeSettings].themeColor)
    }
        
}

#Preview {
    AddtodoView()
}
