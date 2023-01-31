//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 4.02.2023.
//

import SwiftUI

struct UserProfileView: View {
    
    @State var navigated = false
    
    @State private var orderChecked = true
    @State private var passwordChecked = true
    @State private var specialChecked = true
    @State private var newsletterChecked = true
    
    @State var isTicking = true
    
    @State private var firstName = UserDefaults.standard.string(forKey: "first name key")!
    @State private var lastName = UserDefaults.standard.string(forKey: "last name key")!
    @State private var email = UserDefaults.standard.string(forKey: "email")!
    @State private var phoneNumber = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    NavigationLink("\(Image("Back"))", destination: HomeView(),isActive: $navigated)
                    Spacer()
                    LittleLemonLogo()
                    Spacer()
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }.padding(.horizontal)
                
                VStack {
                    HStack {
                        Text("Personal information")
                            .font(.custom("Karla-Bold", size: 20))
                        Spacer()
                    }
                }.padding(.bottom, -3).padding([.leading, .top])
                
                VStack(spacing: -11) {
                    HStack {
                        Text("Avatar")
                            .font(.custom("Karla-Bold", size: 15))
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding([.bottom, .leading])
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: -80) {
                            Image("profile-image-placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                            Spacer()
                            HStack(spacing: 20) {
                                Text("Change")
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 18)
                                    .background(Color("lemongreen"))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                Text("Remove")
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 18)
                                    .border(Color("lemongreen"), width: 1)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }.padding(.bottom)
                    }.padding([.bottom, .leading])
                }.padding(.bottom, -25).padding(.top)

                VStack(spacing: -8) {
                    VStack(alignment: .leading) {
                        Text("First name").foregroundColor(.gray)
                        TextField(firstName, text: $firstName)
                            .textFieldStyle(OutlinedTextFieldStyle())
                            .previewLayout(.sizeThatFits)
                            
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Last Name").foregroundColor(.gray)
                        TextField(lastName, text: $lastName)
                            .textFieldStyle(OutlinedTextFieldStyle())
                            .previewLayout(.sizeThatFits)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Email").foregroundColor(.gray)
                        TextField(email, text: $email)
                            .textFieldStyle(OutlinedTextFieldStyle())
                            .previewLayout(.sizeThatFits)
                    }.padding()

                    VStack(alignment: .leading) {
                        Text("Phone number").foregroundColor(.gray)
                        TextField("(217) 555-0113", text: $phoneNumber)
                            .textFieldStyle(OutlinedTextFieldStyle())
                            .previewLayout(.sizeThatFits)
                            .textContentType(.telephoneNumber)
                            .disabled(true)
                    }.padding()
                 
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Email Notifications")
                                .font(.custom("Karla-Bold", size: 20))
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            CheckBoxView(checked: $orderChecked)
                            Text("Order statutes")
                        }
                        Spacer()
                        HStack {
                            CheckBoxView(checked: $passwordChecked)
                            Text("Password changes")
                        }
                        Spacer()
                        HStack {
                            CheckBoxView(checked: $specialChecked)
                            Text("Special offers")
                        }
                        Spacer()
                        HStack {
                            CheckBoxView(checked: $newsletterChecked)
                            Text("Newsletter")
                        }
                    }.padding()
                    
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        
                        VStack {
                            HStack {
                                Spacer()
                                Text("Log out")
                                    .font(.custom("Karla-Bold", size: 20))
                                    .foregroundColor(Color.black)
                                Spacer()
                            }.padding()
                        }.background(Color("lemonyellow"))
                            .cornerRadius(6)
                            .padding()
                    })
                    HStack {
                        Button(action: {
                    //
                        }) {
                            VStack {
                                Text("Discard changes")
                                    .font(.custom("Karla-Bold", size: 20))
                                    .frame(width: 160, height: 20)
                                    .foregroundColor(Color.gray)
                                    .padding(.all)
                                    .background(Color.white)
                                    .border(Color("lemongreen"), width: 3)
                                    .cornerRadius(6)
                            }
                        }.padding()
                        Button(action: {
                            UserDefaults.standard.set(self.firstName, forKey: "first name key")
                            UserDefaults.standard.set(self.lastName, forKey: "last name key")
                            UserDefaults.standard.set(self.email, forKey: "email")
                         
                            
                            UserDefaults.standard.set(orderChecked, forKey: "order statutes key")
                            UserDefaults.standard.set(passwordChecked, forKey: "password changes key")
                            UserDefaults.standard.set(specialChecked, forKey: "special checked key")
                            UserDefaults.standard.set(newsletterChecked, forKey: "newsletter key")

                        }) {
                            VStack {
                                Text("Save changes")
                                    .font(.custom("Karla-Bold", size: 20))
                                    .frame(width: 150, height: 20)
                                    .foregroundColor(Color("lemonwhite"))
                                    .padding(.all)
                                    .background(Color("lemongreen"))
                                    .cornerRadius(6)
                            }.padding(.trailing)
                        }
                    }
                }
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

