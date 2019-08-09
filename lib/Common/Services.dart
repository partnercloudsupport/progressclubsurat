import 'dart:convert';

import 'package:flutter/material.dart';

//Common Dart File

import 'package:progressclubsurat/Common/Constants.dart';

//HTTP Request
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ClassList.dart';

Dio dio = new Dio();

class Services {
  //login funtion
  static Future<List> MemberLogin(String mobileNo) async {
    String url = API_URL + 'GetLogin?mobile=$mobileNo';
    print("MemberLogin URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("MemberLogin Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("MemberLoginById Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Download From Server
  static Future<List> GetDownload() async {
    String url = API_URL + 'GetDownload';
    print("Download URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Download: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Download : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Event From Server
  static Future<List> GetEvent() async {
    String url = API_URL + 'GetEvent';
    print("Event URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Event Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Event Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get EventGallery From Server
  static Future<List> GetEventGalleryById(int eventId) async {
    String url = API_URL + 'GetEventGalleryById?id=$eventId';
    print("EventGallery URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("EventGallery Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("EventGallery Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Ask List From Server
  static Future<List> GetAsk() async {
    String url = API_URL + 'GetAskData';
    print("Ask List URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Ask List Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Ask List Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static Future<List> getSearchMember(String keyword) async {
    String url = API_URL + 'SearchMember?keyword=$keyword';
    print("getSearchMember URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("getSearchMember Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("getSearchMember Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Directory From Server
  static Future<List> GetDirectory() async {
    String url = API_URL + 'GetChapterList';
    print("Download URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Download URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Download URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Chapter Member List From Server
  static Future<List> GetChapterMemberList(String chapterid) async {
    String url = API_URL + 'GetChapterMemberList?chapterId=$chapterid';
    print("Chapter Member List URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Chapter Member List URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Chapter Member List URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Commities List From Server
  static Future<List> GetCommitiesList(String chapterid) async {
    String url = API_URL + 'GetChapterCommitete?chapterId=$chapterid';
    print("Commities List URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Commities List URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Commities List URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //sign up guest
  static Future<SaveDataClass> guestSignUp(body) async {
    print(body.toString());
    String url = API_URL + 'PostGuest';
    print("SaveMember url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("SaveMember Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error Kap1");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }


  //get member Profile From Server
  static Future<List> GetMemberProfile(String memberId) async {
    String url = API_URL + 'GetMemberProfile?MemberId=$memberId';
    print(" member Profile URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print(" member Profile URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("member Profile URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static Future<SaveDataClass> sendOtpCode(String mobileno, String code) async {
    String url = API_URL +
        'SendVerificationCode?mobileNo=$mobileno&code=$code';
    print("Update User Details URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("SaveMember Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Update User Details Check Login Erorr : " + e.toString());
      throw Exception(e);
    }
  }



  static Future<SaveDataClass> CodeVerification(String MemberId) async {
    String url = API_URL +
        'CodeVerification?id=$MemberId';
    print("CodeVerification URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("CodeVerification Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("CodeVerification Check Login Erorr : " + e.toString());
      throw Exception(e);
    }
  }


  /*static Future<SaveDataClass> getAssigment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String memberId = prefs.getString(Session.MemberId);
    String chapterId = prefs.getString(Session.ChapterId);

    String url = API_URL +
        'GetMeetingData?ChapterId=$chapterId&MemberId=$memberId';
    print("CodeVerification URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("CodeVerification Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("CodeVerification Check Login Erorr : " + e.toString());
      throw Exception(e);
    }
  }*/



  //get Commities List From Server
  static Future<List> getAssigment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String memberId = prefs.getString(Session.MemberId);
    String chapterId = prefs.getString(Session.ChapterId);

    String url = API_URL +
        'GetMeetingData?ChapterId=$chapterId&MemberId=$memberId';
    print("CodeVerification URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Commities List URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Commities List URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }



  static Future<SaveDataClass> sendFeedback(body) async {
    print(body.toString());
    String url = API_URL + 'GetFeedBack';
    print("SaveMember url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("SaveMember Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error Kap1");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }



  static Future<SaveDataClass> sendEventAttendance(body) async {
    print(body.toString());
    String url = API_URL + 'EventAttendance';
    print("SaveMember url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("SaveMember Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error Kap1");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }


  //get Commities List From Server
  static Future<List> getCompletedAssi(String meetingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String memberId = prefs.getString(Session.MemberId);

    String url = API_URL +
        'GetCompletedAssignment?MeetingId=$meetingId&MemberId=$memberId';
    print("CodeVerification URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Commities List URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Commities List URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }


  static Future<SaveDataClass> updatePendingTask(body) async {
    print(body.toString());
    String url = API_URL + 'AddUpdateMemberAssignment';
    print("AddUpdateMemberAssignment url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("AddUpdateMemberAssignment Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("AddUpdateMemberAssignment");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  //get Commities List From Server
  static Future<List> SendTokanToServer(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String memberId = prefs.getString(Session.MemberId);

    String url = API_URL +
        'UpdateFCMToken?memberId=$memberId&fcmToken=$fcmToken';
    print("CodeVerification URL: " + url);
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List list = [];
        print("Commities List URL: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Commities List URL : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static Future<SaveDataClass> sendMemberDetails(body) async {
    print(body.toString());
    String url = API_URL + 'UpdateProfilePersonal';
    print("UpdateProfilePersonal url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("UpdateProfilePersonal Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("UpdateProfilePersonal Url");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }


  //updated Guest Info
  static Future<SaveDataClass> sendGuestDetails(body) async {
    print(body.toString());
    String url = API_URL + 'UpdateGuest';
    print("UpdateProfilePersonal url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("UpdateProfilePersonal Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("UpdateProfilePersonal Url");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> sendBusinessMemberDetails(body) async {
    print(body.toString());
    String url = API_URL + 'UpdateProfileBusiness';
    print("UpdateProfilePersonal url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("UpdateProfilePersonal Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("UpdateProfilePersonal Url");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> sendMoreInfoMemberDetails(body) async {
    print(body.toString());
    String url = API_URL + 'UpdateProfileOther';
    print("UpdateProfileOther url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("UpdateProfileOther Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("UpdateProfileOther Url");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }



  //upload member profile image
  /*static Future<SaveDataClass> UploadMemberImage(body) async {
    print(body.toString());
    String url = API_URL + 'UpdateProfilePhoto';
    print("UpdateProfilePhoto url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false,IsRecord: false, Data: null);

        print("UpdateProfilePhoto Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("UpdateProfilePhoto Url");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("UpdateProfilePhoto ${e.toString()}");
      throw Exception(e.toString());
    }
  }*/

  static Future<SaveDataClass> UploadMemberImage(body) async {
    print(body.toString());
    String url = API_URL + 'UpdateProfilePhoto';
    print("SaveOffer : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: '0');

        print("SaveOffer Response: " + response.data.toString());
        var memberDataClass = response.data;

        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.IsRecord = memberDataClass["IsRecord"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error Kap1");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error Kap ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  //get Event From Server
  static Future<List> GetDashboard(String chapterId,String startdate, String enddate) async {
    String url = API_URL + 'GetDashboardEvent?chapterId=$chapterId&startdate=$startdate&enddate=$enddate';
    print("GetDashboardEvent URL: " + url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetDashboardEvent Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("GetDashboardEvent Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Event From Server
  static Future<List> GetMeetingListByDate(String chapterId,String date) async {
    String url = API_URL + 'GetMeetingListByDate?chapterId=$chapterId&eventdate=$date';
    print("GetMeetingListByDate URL: " + url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetMeetingListByDate Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("GetMeetingListByDate Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //get Event From Server
  static Future<List> GetEventByDate(String date) async {
    String url = API_URL + 'GetEventByDate?eventdate=$date';
    print("GetEventByDate URL: " + url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetEventByDate Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["IsRecord"] == true) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("GetEventByDate Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }
}
