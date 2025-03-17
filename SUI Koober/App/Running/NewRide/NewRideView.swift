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

/// This view is presented if a user is signed in and ready to start a new ride.
@available(iOS 16.0, *)
struct NewRideView : View {
    
  @StateObject var viewModel: NewRideViewModel
  
  var body: some View {
      NavigationStack(path: $viewModel.navigationPath) {
        ZStack(alignment: .top) {
          MapView()
          HStack(alignment: .bottom) {
            Spacer()
            Image(systemName: "person")
              .font(.title)
              .padding(.all)
          }
          WhereToButton(action: goToDropoffLocationSelectionScreen)
            .padding(.top, 60)
        }
        .navigationDestination(for: NewRideDestinations.self) { destination in
            switch destination {
            case .dropOffLocation:
                SelectDropoffLocationView()
            }
        }
      }
  }
  
  func goToDropoffLocationSelectionScreen() {
      viewModel.navigationPath.append(NewRideDestinations.dropOffLocation)
  }
}

struct LegacyNewRideView : View {
    
  let userSession: UserSession
  @State var showDropOffLocation: Bool = false
  
  var body: some View {
    ZStack(alignment: .top) {
      MapView()
      HStack(alignment: .bottom) {
        Spacer()
        Image(systemName: "person")
          .font(.title)
          .padding(.all)
      }
      WhereToButton(action: goToDropoffLocationSelectionScreen)
        .padding(.top, 60)
    }
    .sheet(isPresented: $showDropOffLocation, content: {
        SelectDropoffLocationView()
    })
  }
  
  func goToDropoffLocationSelectionScreen() {
      showDropOffLocation.toggle()
  }
}

struct WhereToButton: View {
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text("Where to?")
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 15, leading: 80, bottom: 15, trailing: 80))
        .background(Color.white)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
  }
}

struct MapView: View {
  var body: some View {
    Color.red
  }
}

#if DEBUG
struct NewRideView_Previews : PreviewProvider {
  static var previews: some View {
    LegacyNewRideView(userSession: UserSession.fake)
  }
}
#endif
