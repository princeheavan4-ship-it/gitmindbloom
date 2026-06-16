import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showSignOutConfirmation = false
    
    var body: some View {
        NavigationStack {
            if let user = authManager.user {
                VStack(spacing: 16) {
                    // User Profile Card
                    VStack(spacing: 12) {
                        HStack(spacing: 16) {
                            if let avatarUrl = user.avatarUrl,
                               let url = URL(string: avatarUrl) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        Circle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 60)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.name ?? user.login)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Text("@\(user.login)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                if let bio = user.bio, !bio.isEmpty {
                                    Text(bio)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                        
                        // Stats
                        HStack(spacing: 16) {
                            StatItem(label: "Repos", value: String(user.publicRepos))
                            StatItem(label: "Followers", value: String(user.followers))
                            StatItem(label: "Following", value: String(user.following))
                        }
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Quick Actions
                    VStack(spacing: 12) {
                        NavigationLink(destination: RepositoriesView()) {
                            HStack {
                                Image(systemName: "folder.fill")
                                    .foregroundColor(.blue)
                                Text("My Repositories")
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(12)
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                        }
                        
                        Button(action: { showSignOutConfirmation = true }) {
                            HStack {
                                Image(systemName: "arrow.backward.circle.fill")
                                    .foregroundColor(.red)
                                Text("Sign Out")
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(12)
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                        }
                    }
                    
                    Spacer()
                }
                .padding(16)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Sign Out", isPresented: $showSignOutConfirmation) {
                    Button("Cancel", role: .cancel) { }
                    Button("Sign Out", role: .destructive) {
                        authManager.signOut()
                    }
                } message: {
                    Text("Are you sure you want to sign out?")
                }
            } else {
                SignInView()
            }
        }
    }
}

struct StatItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationManager())
}
