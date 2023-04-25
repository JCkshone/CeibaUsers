//
//  UsersScreenView.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import SwiftUI

struct UsersScreenView: View {
    @EnvironmentObject private var coordinator: Coordinator<UsersCoordinator>
    @ObservedObject var viewModel: UsersViewModel = UsersViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.headline)
                    .foregroundColor(Color.orange)

                TextField("Buscar", text: $viewModel.search)
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.orange.opacity(0.3), lineWidth: 2)
            )
            
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.users) { user in
                        UserItemView(user: user) { userId in
                            coordinator.show(.showPost(userId: userId))
                        }
                    }
                }
                .padding(.all, 8)
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .padding(.horizontal, 8)
        .onAppear {
            viewModel.viewDidLoad()
        }
    }
}

struct UsersScreenView_Previews: PreviewProvider {
    static var previews: some View {
        UsersScreenView()
    }
}

struct UserItemView: View {
    var user: UserModel
    var action: (Int) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(user.name)
                .font(.headline)
                .fontWeight(.bold)
                .fontDesign(.monospaced)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "iphone")
                    .font(.headline)
                    .foregroundColor(Color.orange)
                Spacer()
                Text(user.phone)
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                Image(systemName: "mail")
                    .font(.headline)
                    .foregroundColor(Color.orange)
                Spacer()
                Text(user.email)
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    action(user.id)
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.headline)
                        .foregroundColor(Color.green)
                }
                
            }
            
        }
        .padding(.all)
        .background(Color.green.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.green, lineWidth: 2)
        )
        .onTapGesture {
            action(user.id)
        }
    }
}
