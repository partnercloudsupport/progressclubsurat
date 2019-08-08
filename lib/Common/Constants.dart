import 'package:flutter/material.dart';

const String API_URL = "http://pmcapi.studyfield.com/api/PCAPI/";
const Inr_Rupee = "₹";
const Color appcolor = Color.fromRGBO(0, 171, 199, 1);
const Color secondaryColor = Color.fromRGBO(85, 96, 128, 1);

Map<int, Color> appprimarycolors = {
  50: Color.fromRGBO(56, 48, 95, .1),
  100: Color.fromRGBO(56, 48, 95, .2),
  200: Color.fromRGBO(56, 48, 95, .3),
  300: Color.fromRGBO(56, 48, 95, .4),
  400: Color.fromRGBO(56, 48, 95, .5),
  500: Color.fromRGBO(56, 48, 95, .6),
  600: Color.fromRGBO(56, 48, 95, .7),
  700: Color.fromRGBO(56, 48, 95, .8),
  800: Color.fromRGBO(56, 48, 95, .9),
  900: Color.fromRGBO(56, 48, 95, 1)
};

MaterialColor appPrimaryMaterialColor = MaterialColor(0xFF38305F, appprimarycolors);

class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}

class Session{

  static const String MemberId = "Id";
  static const String Mobile = "MobileNo";
  static const String Name = "Name";
  static const String CompanyName = "CompanyName";
  static const String Email = "Email";
  static const String Photo = "Photo";
  static const String Type = "Type";
  static const String VerificationStatus = "VerificationStatus";
  static const String ChapterId = "ChapterId";


  static const String DOB = "DOB";
  static const String Gender = "Gender";
  static const String Address = "Address";
  static const String Pincode = "Pincode";
  static const String HospitalName = "HospitalName";
  static const String HospitalAddress = "HospitalAddress";
  static const String DoctorName = "DoctorName";
  static const String DoctorRegistrationNo = "DoctorRegistrationNo";
  static const String HandicappedNature_DisabilityPercentage = "HandicappedNature_DisabilityPercentage";

  static const String Landline = "Landline";
  static const String RegistrationDate = "RegistrationDate";
  static const String Place = "Place";
  static const String SignImage = "SignImage";
  static const String RailwayCertificate = "RailwayCertificate";
  static const String DisabilityCertificate = "DisabilityCertificate";
  static const String PhotoIdProof = "PhotoIdProof";
  static const String AddressProof = "AddressProof";
  static const String CurrentStatus = "CurrentStatus";
  static const String CardNo = "CardNo";
  static const String IssueDate = "IssueDate";
  static const String ValidTill = "ValidTill";

  //temp store
  //static const String ChapterId = "ChapterId";
  static const String CommitieId = "CommitieId";

  //temp store member click on
  static const String memId = "memId";
  static const String memType = "memType";
}
