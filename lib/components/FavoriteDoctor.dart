import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Favorite with ChangeNotifier{
  String? doctorName;
  String? doctorSpecialty;
  double? doctorRating;
  String? doctorHospital;
  String? userEmail;
  String? favoriteDoctorId;
  String? doctorImage;
  String? doctorNumberOfPatient;
  String? doctorYearOfExperience;
  String? doctorDescription;
  String? doctorIsOpen;
  

  Map<String, dynamic> ToFirestore() => {
    "doctorName": doctorName,
    "doctorSpecialty": doctorSpecialty,
    "doctorRating": doctorRating,
    "doctorHospital": doctorHospital,
    "favoriteDoctorId": favoriteDoctorId,
    "userEmail": userEmail,
    "doctorImage": doctorImage,
    "doctorNumberOfPatient": doctorNumberOfPatient,
    "doctorDescription": doctorDescription,
    "doctorYearOfExperience": doctorYearOfExperience,
    "doctorIsOpen": doctorIsOpen,

  };

  void setInfo(String doctorName, String doctorSpecialty, double doctorRating, String doctorHospital, String? userEmail, String? doctorImage, String? doctorNumberOfPatient, String? doctorDescription, String? doctorYearOfExperience, String? doctorIsOpen) {
    this.doctorName = doctorName;
    this.doctorSpecialty = doctorSpecialty;
    this.doctorRating = doctorRating;
    this.doctorHospital = doctorHospital;
    this.userEmail = userEmail;
    this.doctorImage = doctorImage;
    this.doctorNumberOfPatient = doctorNumberOfPatient;
    this.doctorDescription = doctorDescription;
    this.doctorIsOpen = doctorIsOpen;
    this.doctorYearOfExperience = doctorYearOfExperience;
  }

  Future createFavorite() async {
    final docUser = FirebaseFirestore.instance.collection("Favorite").doc();
    favoriteDoctorId = docUser.id;
    await docUser.set(this.ToFirestore());
  }
}