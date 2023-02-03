//
//  LoginView.swift
//  MangaTranslator
//
//  Created by Alaere Nekekpemi on 1/29/23.
//

import SwiftUI
import FirebaseAuth
//
struct Logo : View {
    var body : some View {
        VStack {
            Image("balloon")
        }
    }
}

struct LoginView: View {
    @State var loginStatusMessage = ""
    @StateObject var model = ModelData()

    var body: some View {
        NavigationStack(path: $model.path) {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.green, Color("AccentColor")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 15) {
                  Logo()
                    Text("TranslateMe")
                        .font(Font.custom("Inter-Bold", size: 36))
                        .foregroundColor(Color.white)
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

                    Button(action: { model.signIn() }) {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .frame(width: 200, height: 25)
                            .padding(10)
                            .background(Color(.black))
                            .cornerRadius(15)
                            .navigationDestination(for: String.self) { view in
                                if view == "HomeView" {
                                    ContentView()
                                }
                            }
                    } .onAppear {
                        if Auth.auth().currentUser != nil {
                            model.path.append("HomeView")
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
            LinearGradient(gradient: Gradient(colors: [.green, Color("AccentColor")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center ){
                Text("Create Account")
                    .font(Font.custom("Inter-Bold", size: 36))
                    .foregroundColor(Color.white)
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
                
                Button(action: { model.signUp() }) {
                    Text("Sign up")
                }.foregroundColor(Color.white)
                    .font(.headline)
                    .frame(width: 200, height: 25)
                    .padding(10)
                    .background(Color(.black))
                    .cornerRadius(15)
    
                    .navigationDestination(for: String.self) { view in
                        if view == "HomeView" {
                            ContentView()
                        }
                    }
                }
            }
        }
    



class ModelData: ObservableObject {
    @Published var isCurrentlyLoggedIn = false
    @Published var email = ""
    @Published var password = ""
    @Published var resetEmail = ""
    @Published var reEnterPassword = ""
    @Published var resetPassword = ""
    @Published var isLinkSend = false
    @Published var alert = false
    @Published var path = NavigationPath()
    @Published var alertMsg = ""
    
    @AppStorage("log_Status") var status = false
    
    func signIn() {
        
        Auth.auth().signIn(withEmail: email, password: password){
            (result, err) in if err != nil {
                
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                print("Email or password is incorrect")
                return
            }
            let user = Auth.auth().currentUser
            if !user!.isEmailVerified{
                self.alert.toggle()
                try! Auth.auth().signOut()
                self.path.append("HomeView")
                return
            }
            withAnimation {
                self.status = true
            }
        }
    }
        
    func signUp(){
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.alertMsg = error.localizedDescription
                    self.alert.toggle()
                    print("Email or password is incorrect")
                    return
                } else {
                    print("Success, new user:", result?.user.email ?? "")
                    self.path.append("HomeView")
        
                }
                
            }
        }
    }
}


    struct UserCheck_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
    }
}
