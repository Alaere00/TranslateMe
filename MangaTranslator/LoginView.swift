//
//  LoginView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State var loginStatusMessage = ""
    @StateObject var model = ModelData()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray, Color("cornflower")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 15) {
                    
                    
                    Text("Login")
                        .font(Font.custom("Inter-Bold", size: 36))
                        .foregroundColor(Color.black)
                    
                    
                    Image("manga")
                        .resizable()
                        .frame(width: 140, height: 100)
                        .padding([.top, .bottom], 40)
                    
                    
                    Group {
                        TextField("Email", text: $model.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .background(Color.white)
                        
                        
                        SecureField("Password", text: $model.password)
                    }.padding(12)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(15)
                    VStack {
                        NavigationLink(destination: ContentView()) {
                            Button(action: { model.signIn() }) {
                                Text("Login")
                            }.foregroundColor(Color.white)
                                .font(.headline)
                                .frame(width: 200, height: 25)
                                .padding(10)
                                .background(Color(.black))
                                .cornerRadius(15)
                        }
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Create new account")
                                .foregroundColor(.black)
                                .underline()
                            
                        }.navigationBarBackButtonHidden(true)
                        
                    } .onAppear {
                        if Auth.auth().currentUser != nil {
                            model.path.append("HomeView")
                        }
                    }
                }
            }
        }
    }
}



    struct SignUpView: View {
        @StateObject var model = ModelData()
        @State var signUpStatusMessage = ""
        
        var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray, Color("cornflower")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center ){
                    Text("Create Account")
                        .font(Font.custom("Inter-Bold", size: 36))
                        .foregroundColor(.black)
                        .padding([.top, .bottom], 40)
                    
                    Group {
                        TextField("Email", text: $model.email)
                        
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $model.password)
                        SecureField("re-enter Password", text: $model.reEnterPassword)
                        
                    }.padding(12)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(15)
                    
                    NavigationLink(destination: ContentView()) {
                        Button(action: { model.signUp() }) {
                            Text("Sign up")
                        }.foregroundColor(Color.white)
                            .font(.headline)
                            .frame(width: 200, height: 25)
                            .padding(10)
                            .background(Color(.black))
                            .cornerRadius(15)
                    }
                    
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Returning user? login in here")
                            .foregroundColor(.black)
                            .underline()
                    }

                }
                    

                }.navigationBarBackButtonHidden(true)
            }
        }
    
    



    class ModelData: ObservableObject {
        @Published var isCurrentlyLoggedIn = false
        @Published var email = ""
        @Published var password = ""
        @Published var reEnterPassword = ""
        @Published var StatusMessage = ""
        @Published var path = NavigationPath()
        @Published var shouldShowLoginAlert = false
        @Published var alert = false
        
        
         func signIn() {
             Auth.auth().signIn(withEmail: email, password: password) { result, err in
                 if let err = err {
                     print("Failed to login user:", err)
                     self.StatusMessage = "Failed to login user: \(err)"
                     self.shouldShowLoginAlert = true
                     return
                 }
     
                 let user = Auth.auth().currentUser
                 if !user!.isEmailVerified{
                     self.alert.toggle()
                     try! Auth.auth().signOut()
                     self.path.append("HomeView")
                     return
                 }
     
                 print("Successfully logged in")
     
                 self.StatusMessage = "Successfully logged"
     
                 self.isCurrentlyLoggedIn = true
             }
         }
        func signUp(){
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print("Failed to create user")
                    self.StatusMessage = "Failed to create user: \(error)"
                    return
                } else {
                    print("Success, new user:", result?.user.email ?? "")
                    self.StatusMessage = "Successfully created"

                }
            }
        }
    }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
    }
}
