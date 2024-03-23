//
//  RowStaticView.swift
//  Todo App
//
//  Created by Hưng Trần on 21/3/24.
//

import SwiftUI

struct FormRowStaticView: View {
    // MARK: - PROPERTIES
    var icon: String
    var firstText: String
    var secondText: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8 ,style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText).foregroundStyle(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

#Preview {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
}
