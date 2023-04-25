//
//  PostsScreenView.swift
//  CeibaUsers
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import SwiftUI

struct PostsScreenView: View {
    @ObservedObject private var viewModel: PostsViewModel = .init()
    @EnvironmentObject private var coordinator: Coordinator<UsersCoordinator>
    private var userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.green)
                    .font(.system(size: 30))
                    .padding(.all)
                    .onTapGesture {
                        coordinator.pop()
                    }
                Spacer()

            }
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 30) {
                    ForEach(viewModel.posts) { post in
                        VStack {
                            Text(post.title.capitalized)
                                .font(.headline)
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            Divider()
                                .frame(height: 2)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.3))
                                .padding(.horizontal)
                            
                            VStack(spacing: 20) {
                                Text(post.body)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .fontDesign(.monospaced)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .padding(.all)
                            .background(Color.green.opacity(0.05))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.green, lineWidth: 2)
                            )
                            .padding(.horizontal)
                        }
                    }
                }
                
            }
        }
        .onAppear {
            viewModel.viewDidLoad()
            viewModel.dispatchLoadPost(with: userId)
        }
    }
}

struct PostsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PostsScreenView(userId: 1)
    }
}
