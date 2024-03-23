//
//  ContentView.swift
//  Todo App
//
//  Created by Hưng Trần on 18/3/24.
//

import SwiftUI
import UIKit


struct ContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var manageObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos : FetchedResults<Todo>
    
    @State private var showingSettingView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    //MARK: - BODY
    
    var body: some View{
        NavigationView{
            ZStack {
                List{
                    ForEach(self.todos, id: \.self){todo in
                        HStack{
                            Circle()
                                .frame(width: 12,height: 12,alignment: .center)
                                .foregroundStyle(self.colorize(priority: todo.priority ?? "Normal"))
                            
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundStyle(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2),lineWidth: 0.75)
                                )
                        }
                        
                    }
                    .onDelete(perform: deleteTodo)
                } //: List
                .navigationTitle("Todo")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing, content: {
                        EditButton()
                            
                    })
                    ToolbarItem(placement: .topBarTrailing, content:{
                        Button(action:{
                            self.showingSettingView.toggle()
                        }){
                            Image(systemName: "paintbrush")
                        }
                        
                        .sheet(isPresented: $showingSettingView){
                            SettingView()
                        }
                    })
                    
                    
            }
                .tint(themes[self.theme.themeSettings].themeColor)
                //MARK: - NO TODO ITEMS
                if todos.count == 0 {
                    EmptyListView()
                }
            }//: Zstack
            .sheet(isPresented: $showingAddTodoView){
                AddtodoView().environment(\.managedObjectContext, self.manageObjectContext)
            }
            .overlay(
                ZStack {
                    Group{
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68,height: 68,alignment: .center)
                        
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0, anchor: .center)
                            .frame(width: 88,height: 88,alignment: .center)
                    }
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),value: animatingButton)
                    
                    Button(action:{
                        self.showingAddTodoView.toggle()
                    }){
                        Image(systemName:"plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48,height: 48,alignment: .center)
                }
                    .tint(themes[self.theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                }//: Zstack
                    .padding(.bottom,15)
                    .padding(.trailing,15)
                ,alignment: .bottomTrailing            )
        }
        
        
    }
    
    //MARK: -Fuctions
    private func deleteTodo(at offsets: IndexSet){
        for index in offsets {
            let todo = todos[index]
            manageObjectContext.delete(todo)
            
            do{
                try manageObjectContext.save()
                
            }catch{
                print(error)
            }
        }
    }
    
    private func colorize(priority: String) -> Color{
        switch priority{
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
    
}


#Preview {
    
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
