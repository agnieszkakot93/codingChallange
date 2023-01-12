//
//  ShiftsView.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI

struct ShiftsView: View {

    var body: some View {
        VStack {
            calendarView
            Spacer()
            avaliableShifts
        }
        .sheet(isPresented: $viewModel.isModalPresenter) {
            if let data = viewModel.modalViewData {
                ModalView(modalViewData: data) {
                    viewModel.isModalPresenter = false
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchDataSubject.send(Date())
        }
    }
    
    @ObservedObject var viewModel: ShiftsViewModel

    init(viewModel: ShiftsViewModel) {
        self.viewModel = viewModel
    }
}

private extension ShiftsView {

    var calendarView: some View {
        ZStack {
            let enumerated = Array(viewModel.currentWeekViewData.enumerated())
            HStack(spacing: 5) {
                ForEach(enumerated, id: \.0) { index, day in
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Text(day.stringDayName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(viewModel.isSameDayAndMonth(date1: viewModel.currentDate,
                                                                                 date2: day.date) ? .green : .primary)
                                Text(day.stringDayNumber)
                                    .font(.subheadline)
                                    .foregroundColor(viewModel.isSameDayAndMonth(date1: viewModel.currentDate,
                                                                                 date2: day.date) ? .green : .primary)
                            }
                        }
                    }
                    .onTapGesture {
                        viewModel.currentDate = day.date
                    }
                    .frame(width: 40)
                    .background(
                        Rectangle()
                            .fill(.white)
                    )
                }
            }
        }
    }

    @ViewBuilder private var avaliableShifts: some View {
        if let selectedDateShifts = viewModel.shiftsForCurrentDay?.shifts {
            List {
                ForEach(selectedDateShifts) { rowData in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(rowData.facilityName)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .center) {
                            bottomDetails(data: rowData)
                            Spacer()
                            VStack {
                                Button(action: {
                                    viewModel.isModalPresenter.toggle()
                                    viewModel.selectedShiftViewData.send(rowData)
                                }) {
                                    Text("Details")
                                        .font(.subheadline)
                                        .padding(8.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(lineWidth: 2.0)
                                                .shadow(color: .blue, radius: 10.0)
                                        )
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                }
            }
            .listStyle(.plain)
        } else {
            Text("No shifts avaliable or loading in progress")
                .font(.headline)
            Spacer()
        }
    }

    func bottomDetails(data: ShiftViewData) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(data.timeRange)
                    .font(.footnote)
            }
            HStack {
                HStack {
                    Image(systemName: "car.circle")
                        .frame(width: 15, height: 15)
                        .foregroundColor(.orange)
                    Text(data.withinDistance)
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
                .padding(.all, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(.orange)
                )
                Text(data.localizedSpecialty)
                    .font(.footnote)
                    .foregroundColor(.cyan)
                    .padding(.all, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.cyan)
                    )
            }
        }
    }
}
