/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

/// This view welcomes the user and asks the user to either sign in or sign up.
struct WelcomeView : View {
    @ObservedObject var koober: Koober
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                WelcomeContentView(koober: koober)
                Spacer()
            }
        }
        .navigationBarTitle(Text("Welcome"))
    }
}

#if DEBUG
struct WelcomeView_Previews : PreviewProvider {
  static var previews: some View {
    WelcomeView(koober: Koober())
  }
}
#endif

/// App logo, sign in and sign up buttons.
private struct WelcomeContentView : View {
    @ObservedObject var koober: Koober
    
    var body: some View {
        CenteredContentScrollView {
            AdaptableStack {
                Spacer()
                Image("roo_logo").background(Color("BackgroundColor"))
                SignInSignUpButtons(koober: koober)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct SignInSignUpButtons : View {
    @ObservedObject var koober: Koober
    
    var body: some View {
        VStack(spacing: 24) {
            
            NavigationLink(destination: SignInView(viewModel: SignInViewModel(startSignInUseCase: koober.startSignInUseCase))) {
                Text("Sign In")
                    .bold()
            }
            .accentColor(Color("Text"))
            
            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
                    .bold()
            }
            .accentColor(Color("Text"))
        }
        .padding()
    }
}
