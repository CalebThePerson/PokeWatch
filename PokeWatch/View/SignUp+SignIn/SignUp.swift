//
//  SignUp.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/9/22.
//

import SwiftUI
import Popovers

struct SignUp: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    
    @State var email:String = ""
    @State var password:String = ""
    @State var message:String  = ""
    @State var present:Bool = false
    @State var expanding:Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                Text("Sign Up")
                    .padding(.top, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .foregroundColor(Color.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
            }
            
            Button(action:{
                signUpViewModel.signUp(email: email, password: password){ error in
                    if error != nil{
                        message = error
                        present = true
                    }
                }
                
                //Change the view to like the main app from here or Something
                
            }){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.red)
                        .frame(height: 80)
                        .cornerRadius(25.0)
                    Text("Sign In")
                        .foregroundColor(Color.yellow)
                    
                }
                
            }
            .frame(alignment: .center)
            .padding(.top, geo.size.height-100)
            .popover(
                present: $present,
                attributes: {
                    $0.blocksBackgroundTouches = true
                    $0.rubberBandingMode = .none
                    $0.position = .relative(
                        popoverAnchors: [
                            .center,
                        ]
                    )
                    $0.dismissal.mode = .tapOutside
                    $0.presentation.animation = .easeOut(duration: 0.15)
                    $0.dismissal.mode = .none
                    $0.onTapOutside = {
                        withAnimation(.easeIn(duration: 0.15)) {
                            expanding = true
                        }
                        
                    }
                }
            ){
                alertView(message: $message, present: $present)
            } background:{
                Color.black.opacity(0.2)
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

struct alertView:View{
    @Binding var message: String
    @Binding var present: Bool
    var body: some View{
        VStack(spacing: 0){
            VStack(spacing: 0){
                Text("Error")
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Divider()
                
                Button{
                    present = false
                } label: {
                    Text("Got it")
                }.buttonStyle(PopoverTemplates.AlertButtonStyle())
            }
            .foregroundColor(Color.black)
        }
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(13)
        .popoverContainerShadow()
        .frame(width: 260)
    }
}

