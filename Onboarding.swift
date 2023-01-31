//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 4.02.2023.
//

import SwiftUI

struct Onboarding: View {
    
    let kFirstName = "first name key"
    let kLastName = "last name key"
    let kEmail = "email"
    let kPhoneNumber = "phone number"
    let kIsLoggedIn = "kIsLoggedIn"
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                LittleLemonLogo()
                    .padding()
                VStack {
                    VStack(spacing: -16) {
                        HStack {
                            Text("Little Lemon")
                                .foregroundColor(Color("lemonyellow"))
                                .font(.custom("MarkaziText-Medium", size: 64))
                            Spacer()
                        }
                        HStack {
                            Text("Chigaco")
                                .foregroundColor(Color("lemonwhite"))
                                .font(.custom("MarkaziText-Regular", size: 40))
                            Spacer()
                        }
                        HStack {
                            HStack {
                                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                    .foregroundColor(Color("lemonwhite"))
                                    .font(.custom("Karla-Medium", size: 20))
                                    .fixedSize(horizontal: false, vertical: true)
                            }.padding(.top)
                            Spacer()
                            Image("Hero-image")
                                .resizable()
                                .frame(width: 120.0, height: 140.0)
                                .border(.black)
                                .cornerRadius(16)
                                .padding(.bottom)
                        }
                    }.padding(.all)
                }.background(Color("lemongreen"))
                Spacer()
                VStack {
                    NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                        return EmptyView()
                    }
                    VStack(alignment: .leading) {
                        Text("Name *")
                            .foregroundColor(Color.gray)
                            .font(.custom("Karla-Bold", size: 20))
                        TextField(
                            "", text: $firstName
                        )
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                    }
                    VStack(alignment: .leading) {
                        Text("Last Name")
                            .foregroundColor(Color.gray)
                            .font(.custom("Karla-Bold", size: 20))
                        TextField(
                            "", text: $lastName
                        )
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                    }
                    VStack(alignment: .leading) {
                        Text("Email *")
                            .foregroundColor(Color.gray)
                            .font(.custom("Karla-Bold", size: 20))
                        TextField(
                            "", text: $email
                        )
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .previewLayout(.sizeThatFits)
                    }
                    Spacer()
                    Button(action: {
                        if firstName.isEmpty == false && email.isEmpty == false {
                            UserDefaults.standard.set(firstName, forKey: kFirstName);
                            UserDefaults.standard.set(email, forKey: kEmail);
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                        } else {
                            return
                        }
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }, label: {
                        Text("Register")
                            .font(.custom("Karla-Bold", size: 20))
                            .frame(width: 150)
                            .foregroundColor(Color("lemonyellow"))
                            .padding(.all)
                            .background(Color("lemongreen"))
                            .cornerRadius(6)
                    })
                    Spacer()
                }.padding()
            }
        }.onAppear {
            if (UserDefaults.standard.string(forKey: "kIsLoggedIn") != nil) == true {
                isLoggedIn = true
            } else {
               return
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
