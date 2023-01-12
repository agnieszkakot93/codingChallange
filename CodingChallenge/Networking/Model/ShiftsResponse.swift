//
//  ShiftsResponse.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 08/01/2023.
//

import Foundation

struct ShiftsResponse: Codable {
    let data: [Data]
}

struct Data: Codable {
    let date: String
    let shifts: [Shift]
}

struct Shift: Codable {
    let shiftID: Int
    let normalizedStartDateTime, normalizedEndDateTime: String
    let premiumRate: Bool
    let shiftKind: ShiftKind
    let withinDistance: Int
    let facilityType: FacilityType
    let localizedSpecialty: LocalizedSpecialty

    enum CodingKeys: String, CodingKey {
        case shiftID = "shift_id"
        case normalizedStartDateTime = "normalized_start_date_time"
        case normalizedEndDateTime = "normalized_end_date_time"
        case premiumRate = "premium_rate"
        case shiftKind = "shift_kind"
        case withinDistance = "within_distance"
        case facilityType = "facility_type"
        case localizedSpecialty = "localized_specialty"
    }
}

struct FacilityType: Codable {
    let id: Int
    let name: FacilityTypeName
}

enum FacilityTypeName: String, Codable {
    case acuteCare = "Acute Care"
    case assistedLivingFacility = "Assisted Living Facility"
    case certifiedNursingAide = "Certified Nursing Aide"
    case dentalClinic = "Dental Clinic"
    case dentalHygienist = "Dental Hygienist"
    case dentistryClinic = "Dentistry Clinic"
    case er = "ER"
    case hospital = "Hospital"
    case licensedVocationalPracticalNurse = "Licensed Vocational/Practical Nurse"
    case longTermAcuteCare = "Long Term Acute Care"
    case longTermCare = "Long Term Care"
    case medSurg = "Med/Surg"
    case medicationAideTech = "Medication Aide/Tech"
    case occupationalTherapist = "Occupational Therapist"
    case outpatientClinic = "Outpatient Clinic"
    case physicalTherapist = "Physical Therapist"
    case physicalTherapistAssistant = "Physical Therapist Assistant"
    case registeredNurse = "Registered Nurse"
    case rehabilitationFacility = "Rehabilitation Facility"
    case respiratoryTherapist = "Respiratory Therapist"
    case skilledNursingFacility = "Skilled Nursing Facility"
    case inPatientRehabHospital = "In-Patient Rehab Hospital"
    case dentalAssistant = "Dental Assistant"
}

// MARK: - LocalizedSpecialty
struct LocalizedSpecialty: Codable {
    let id, specialtyID, stateID: Int
    let name: LocalizedSpecialtyName
    let abbreviation: LocalizedSpecialtyAbbreviation
    let specialty: FacilityType

    enum CodingKeys: String, CodingKey {
        case id
        case specialtyID = "specialty_id"
        case stateID = "state_id"
        case name, abbreviation, specialty
    }
}

enum LocalizedSpecialtyAbbreviation: String, Codable {
    case cma = "CMA"
    case cna = "CNA"
    case dh = "DH"
    case lvn = "LVN"
    case ot = "OT"
    case pt = "PT"
    case pta = "PTA"
    case rcp = "RCP"
    case rn = "RN"
    case rda = "RDA"
    case da = "DA"
}

enum LocalizedSpecialtyName: String, Codable {
    case certifiedMedicationAide = "Certified Medication Aide"
    case certifiedNursingAide = "Certified Nursing Aide"
    case dentalHygienist = "Dental Hygienist"
    case licensedVocationalNurse = "Licensed Vocational Nurse"
    case occupationalTherapist = "Occupational Therapist"
    case physicalTherapist = "Physical Therapist "
    case physicalTherapistAssistant = "Physical Therapist Assistant"
    case registeredNurse = "Registered Nurse"
    case respiratoryCarePractitioner = "Respiratory Care Practitioner"
    case dentalAssistant = "Dental Assistant"
}

enum ShiftKind: String, Codable {
    case dayShift = "Day Shift"
    case eveningShift = "Evening Shift"
    case nightShift = "Night Shift"
}
