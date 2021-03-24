//
//  LoginView.swift
//  YouUp
//
//  Created by JJ Stephens on 3/22/21.
//

import SwiftUI

struct LoginView: View {
    enum Action {
        case signUp, resetPassword
    }
    @State private var showSheet = false
    @State private var action: Action?
    
    var body: some View {
        VStack {
            SignInWithEmailView(showSheet: $showSheet, action: $action)
            SignInWithAppleView().frame(width: 200, height: 50)
        }
            .sheet(isPresented: $showSheet) {
                if self.action == .signUp {
                    SignUpView()
                } else {
                    ForgotPasswordView()
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
