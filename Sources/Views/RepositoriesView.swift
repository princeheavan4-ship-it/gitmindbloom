import SwiftUI

struct RepositoriesView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var repositories: [GitHubRepository] = []
    @State private var isLoading = false
    @State private var error: String?
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else if let error = error {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.orange)
                    
                    Text("Error Loading Repositories")
                        .font(.headline)
                    
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Button("Try Again") {
                        loadRepositories()
                    }
                    .padding(.top, 8)
                }
                .padding()
            } else if repositories.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "folder")
                        .font(.system(size: 32))
                        .foregroundColor(.gray)
                    
                    Text("No Repositories Found")
                        .font(.headline)
                    
                    Text("You don't have any public repositories yet")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            } else {
                List(repositories) { repo in
                    NavigationLink(destination: RepositoryDetailView(repository: repo)) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(repo.name)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .font(.caption)
                                        .foregroundColor(.yellow)
                                    
                                    Text(String(repo.stars))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            if let description = repo.description, !description.isEmpty {
                                Text(description)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(spacing: 12) {
                                if let language = repo.language {
                                    Label(language, systemImage: "circle.fill")
                                        .font(.caption2)
                                        .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                Link(destination: URL(string: repo.url)!) {
                                    Image(systemName: "link")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadRepositories()
        }
    }
    
    private func loadRepositories() {
        guard let user = authManager.user,
              let token = KeychainManager.shared.retrieveToken() else {
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let repos = try await GitHubAPIClient.shared.fetchUserRepositories(
                    token: token,
                    username: user.login
                )
                
                await MainActor.run {
                    self.repositories = repos
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}

struct RepositoryDetailView: View {
    let repository: GitHubRepository
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(repository.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if let description = repository.description, !description.isEmpty {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 16) {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(repository.stars))
                            .fontWeight(.semibold)
                    }
                    
                    if let language = repository.language {
                        VStack(alignment: .center, spacing: 4) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.blue)
                            Text(language)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(8)
                
                Link(destination: URL(string: repository.url)!) {
                    HStack {
                        Image(systemName: "link")
                        Text("Open on GitHub")
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RepositoriesView()
            .environmentObject(AuthenticationManager())
    }
}
