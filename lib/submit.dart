import 'package:flutter/material.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Registration Form",style: TextStyle(color: Colors.yellow),),
        toolbarHeight: 80,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 80,),
          Center(child: Text("FORM SUBMITTED SUCCESSFULLY",textAlign: TextAlign.center, style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),)),
          SizedBox(height: 20,),
          Center(
            child: Text("We have received your form submission. You can fill another form again",textAlign: TextAlign.center,),
          ),
          Expanded(child: SizedBox(),),
          ElevatedButton(
              onPressed: (){Navigator.pop(context);},
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.yellow.withOpacity(0.8)
              ),
              child: Text("Fill a form",style: TextStyle(color: Colors.black,fontSize: 20),)),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}
