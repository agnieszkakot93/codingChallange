//
//  ModalView.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 12/01/2023.
//

import MapKit
import SwiftUI

struct ModalView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack {
                Text("Details")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
                Text("Close X")
                    .font(.caption2)
                    .padding(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                    .onTapGesture {
                        if let dismiss = dismissModal {
                            dismiss()
                        }
                    }
            }
            .padding()
            Map(coordinateRegion: $region)
            Text(modalViewData.title)
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(.secondary)
                .padding()

            List {
                createRow(text: modalViewData.distance, iconName: "triangle.fill")

                if modalViewData.isPremiumPay {
                    createRow(text: "Premium Pay", iconName: "dollarsign.circle.fill")
                }
                createRow(text: modalViewData.shiftType, iconName: "clock.arrow.circlepath")
                createRow(text: modalViewData.careType, iconName: "pills.circle.fill")
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4)
    }

    var modalViewData: ModalViewData
    let dismissModal: (() -> Void)?

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.7766642,
                                                                                  longitude:  -96.79698789999999),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    init(modalViewData: ModalViewData, dismissModal: (() -> Void)? = nil) {
        self.modalViewData = modalViewData
        self.dismissModal = dismissModal
    }

    private func createRow(text: String, iconName: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: iconName)
                .foregroundColor(.primary)
                .padding(.trailing, 24)
            Text(text)
                .font(.footnote)
                .foregroundColor(.primary)
        }
    }

}
