//
//  Fixtures.swift
//  CodingChallengeTests
//
//  Created by Agnieszka Kot on 12/01/2023.
//

@testable import CodingChallenge

extension  ShiftsResponse {
    static func fixture(data: [Data] = [.fixture()]) -> ShiftsResponse {
        ShiftsResponse(data: data)
    }
}

extension Data {
    static func fixture(date: String = "2022-01-31T02:22:40+00:00", shifts: [Shift] = [.fixture()]) -> Data {
        Data(date: date, shifts: shifts)
    }
}

extension Shift {
    static func fixture(shiftID: Int = 1,
                        normalizedStartDateTime: String = "2023-01-17 23:00:00",
                        normalizedEndDateTime: String = "2023-01-17 24:00:00",
                        premiumRate: Bool = true,
                        shiftKind: ShiftKind = .dayShift,
                        withinDistance: Int = 100,
                        facilityType: FacilityType = .fixture(),
                        localizedSpecialty: LocalizedSpecialty = .fixture()) -> Shift {
        Shift(shiftID: shiftID,
              normalizedStartDateTime: normalizedStartDateTime,
              normalizedEndDateTime: normalizedEndDateTime,
              premiumRate: premiumRate,
              shiftKind: shiftKind,
              withinDistance: withinDistance,
              facilityType: facilityType,
              localizedSpecialty: localizedSpecialty)
    }
}

extension FacilityType {
    static func fixture(id: Int = 20, name: FacilityTypeName = .dentalHygienist) -> FacilityType {
        FacilityType(id: id, name: name)
    }
}

extension LocalizedSpecialty {
    static func fixture(id: Int = 0,
                        specialtyID: Int = 0,
                        stateID: Int = 0,
                        name: LocalizedSpecialtyName = .occupationalTherapist,
                        abbreviation: LocalizedSpecialtyAbbreviation = .lvn,
                        specialty: FacilityType = .fixture()) -> LocalizedSpecialty {
        LocalizedSpecialty(id: id,
                           specialtyID: specialtyID,
                           stateID: stateID,
                           name: name,
                           abbreviation: abbreviation,
                           specialty: specialty)
    }
}
