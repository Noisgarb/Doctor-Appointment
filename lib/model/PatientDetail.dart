import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqq_flutter2/constants.dart';
import 'package:sqq_flutter2/model/ReviewSummary.dart';
import 'package:sqq_flutter2/model/providerTest.dart';

// ignore: must_be_immutable
class PatientDetail extends StatefulWidget {
  String userName;
  String userEmail;
  String userGender;
  PatientDetail({super.key, required this.userName, required this.userEmail, required this.userGender});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: kBlackColor800,),
          ),
        title: Text("Patient Detail", style: TextStyle(fontSize: 24, color: kBlackColor800),),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 19,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Full Name', style: TextStyle(fontSize: 20, color: kBlackColor800, fontWeight: FontWeight.w700),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 380,
                decoration: BoxDecoration(color: kGreyColor400),
                padding: EdgeInsets.only(left: 4, top: 10),
                child: Text(
                  '${widget.userName}',
                  style: TextStyle(color: kBlackColor900, fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),

              SizedBox(height: 19,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Gender', style: TextStyle(fontSize: 20, color: kBlackColor800, fontWeight: FontWeight.w700),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 380,
                decoration: BoxDecoration(color: kGreyColor400),
                padding: EdgeInsets.only(left: 4, top: 10),
                child: Text(
                  '${widget.userGender}',
                  style: TextStyle(color: kBlackColor900, fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),

              SizedBox(height: 19,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email', style: TextStyle(fontSize: 20, color: kBlackColor800, fontWeight: FontWeight.w700),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 380,
                decoration: BoxDecoration(color: kGreyColor400),
                child: Text(
                  '${widget.userEmail}',
                  style: TextStyle(color: kBlackColor900, fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Write Your Problem: ', style: TextStyle(fontSize: 20, color: kBlackColor800, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Please write down your problem....',
                    border: InputBorder.none,
                    fillColor: kGreyColor400,
                    filled: true,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,

                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
              onPressed: () {
                context.read<SummaryData>().assignPatient(widget.userName, widget.userEmail, widget.userGender, _controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => ReviewSummary())),
                );
              }, 
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyle(color: kWhiteColor, fontSize: 16, fontWeight: FontWeight.w200),
                ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
                )
            ],
            ),
        ),
          ),
    );
  }
}