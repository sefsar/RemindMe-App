import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var backgroundOpacity = 1.0
    
    var body: some View {
        if isActive {
            ContentView()
                .opacity(isActive ? 1 : 0)
                .animation(.easeIn(duration: 1.0), value: isActive)
        } else {
            ZStack {
                Color(.systemBlue)
                    .ignoresSafeArea()
                    .opacity(backgroundOpacity)
                
                VStack {
                    Image("RemindMe_AppIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .scaleEffect(size)
                        .opacity(opacity)
                    
                    Text("RemindMe")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                        .opacity(opacity)
                }
                .onAppear {
                    withAnimation(.spring(response: 0.7, dampingFraction: 0.6)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            self.opacity = 0
                            self.backgroundOpacity = 0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeIn(duration: 1.0)) {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
} 
