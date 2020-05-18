//
//  KeyboardResponsiveModifier.swift
//  HungryStudent
//
//  Taken from https://stackoverflow.com/questions/56491881/move-textfield-up-when-the-keyboard-has-appeared-in-swiftui
//
//  Handles responsivity of keyboard.

import SwiftUI

struct KeyboardResponsiveModifier: ViewModifier {
  @State private var offset: CGFloat = 0
    
    /// Modifies any view so keyboard can move it.
    /// - Parameter content: view to be modifyed
    /// - Returns: new view
  func body(content: Content) -> some View {
    content
      .padding(.bottom, offset)
      .onAppear {
        /// Adds observer for will show keyboard notification.
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
          let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
          let height = value.height
          let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
          self.offset = height - (bottomInset ?? 0)
        }
        /// Adds observer for keyboard hide notification.
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
          self.offset = 0
        }
    }
  }
}

extension View {
  func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
    return modifier(KeyboardResponsiveModifier())
  }
}


