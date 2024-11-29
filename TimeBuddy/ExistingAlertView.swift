//
//  ExistingAlertView.swift
//  TimeBuddy
//
//  Created by Weerawut Chaiyasomboon on 29/11/2567 BE.
//

import SwiftUI

struct ExistingAlertView: View {
//    @Environment(\.dismiss) var dismiss
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack{
            Text("Selected time zone already in the list!")
                .font(.headline)
            
            Button("Dismiss"){
                showAlert = false
            }
        }
        .padding()
    }
}

#Preview {
    ExistingAlertView(showAlert: .constant(false))
}
