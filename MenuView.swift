//
//  Menu.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 4.02.2023.
//

import SwiftUI

struct MenuView: View {
    
    @State var selectedCategory: Category = categories.first!
    @State private var searchText: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let fullMenu = try decoder.decode(MenuList.self, from: data)
                    let menuItems = fullMenu.menu
                    menuItems.forEach { menuItem in
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.price = menuItem.price
                        dish.image = menuItem.image
                        dish.descript = menuItem.description
                        try? viewContext.save()
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack(spacing: -5) {
            Header()
            VStack {
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
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .dynamicTypeSize(.xxxLarge)
                            TextField("", text: $searchText)
                        }
                        .padding(.all, 10)
                        .background(Color(.white))
                        .cornerRadius(6)
                        Spacer()
                    }.padding(.all)
                }.background(Color("lemongreen"))
                HStack {
                    Text("ORDER FOR DELIVERY!")
                        .font(.custom("Karla-ExtraBold", size: 20))
                        .padding()
                    Spacer()
                }.padding(.trailing)
                ScrollView(.horizontal, showsIndicators: false,
                           content: {
                    HStack(spacing: 12) {
                        ForEach(categories) { category in
                            Text(category.title)
                                .font(.custom("Karla-ExtraBold", size: 16))
                                .foregroundColor(selectedCategory.id == category.id ? .white : Color("lemongreen"))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(selectedCategory.id == category.id ? Color("lemongreen")  : Color("lemonwhite"))
                                .clipShape(Capsule())
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selectedCategory = category
                                    }
                                }
                        }
                    }.padding(.leading)
                })
            }
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors())
            { (dishes: [Dish]) in
                List {
                    Spacer()
                    ForEach(dishes) { dish in
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(dish.title ?? "")
                                    .font(.custom("Karla-Bold", size: 18))
                                Spacer()
                                Text(dish.descript ?? "")
                                    .font(.custom("Karla-Regular", size: 16))
                                    .foregroundColor(Color("lemongreen"))
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                Spacer()
                                Text("$\(dish.price ?? "").99")
                                    .font(.custom("Karla-Medium", size: 16))
                                    .foregroundColor(Color("lemongreen"))
                            }
                            Spacer()
                            VStack {
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                            }
                        }.padding()
                    }
                }.listStyle(.plain)
            }.padding(.vertical).onAppear {
                getMenuData()
            }
        } 
    }
}


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


