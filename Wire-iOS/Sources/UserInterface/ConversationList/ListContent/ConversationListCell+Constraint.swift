//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension UIView {
    func pinEdgesToSuperviewEdges() {
        guard let superview = self.superview else { return }

        let superviewEdges = [
            superview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            superview.topAnchor.constraint(equalTo: self.topAnchor),
            superview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            superview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]

        NSLayoutConstraint.activate(superviewEdges)

    }
}

extension ConversationListCell {
    override open func updateConstraints() {
        if hasCreatedInitialConstraints {
            super.updateConstraints()
            return
        }
        hasCreatedInitialConstraints = true

        let leftMarginConvList: CGFloat = 64


        [itemView, menuDotsView, menuView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}


        itemView.pinEdgesToSuperviewEdges()


        if let superview = menuDotsView.superview {
            let menuDotsViewEdges = [
                superview.leadingAnchor.constraint(equalTo: menuDotsView.leadingAnchor, constant: leftMarginConvList),

                superview.topAnchor.constraint(equalTo: menuDotsView.topAnchor),
                superview.trailingAnchor.constraint(equalTo: menuDotsView.trailingAnchor),
                superview.bottomAnchor.constraint(equalTo: menuDotsView.bottomAnchor),

                ///TODO missing left inset
//                menuView.widthAnchor.constraint(equalTo: menuDotsView.widthAnchor)
            ]

            NSLayoutConstraint.activate(menuDotsViewEdges)
        }

        super.updateConstraints()
    }
}
