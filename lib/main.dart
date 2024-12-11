import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled/submit.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? filePath;
  var resume;
  final formKey = GlobalKey<FormState>();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController whyApplyController = TextEditingController();
  final TextEditingController expectaionFromRoleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  nullCheck(){
    if(roleController.text.isEmpty || firstController.text.isEmpty || lastController.text.isEmpty 
        || emailController.text.isEmpty || phoneController.text.isEmpty || cityController.text.isEmpty || experienceController.text.isEmpty 
    || bioController.text.isEmpty || whyApplyController.text.isEmpty || expectaionFromRoleController.text.isEmpty){
      return false;
    }
    else{
      return true;
    }
  }
  var urlList = [];
  String? validateName(String? value){
    if(value == null || value.isEmpty){
      return "name is required";
    }
    else if(!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)){
      return "enter a valid name (alphabets and spaces only)";
    }
    return null;
  }

  String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Email is required";
    }
    else if(!RegExp(r'^[a-zA-Z0-9._%+-]+[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
      return "enter a valid email";
    }
    return null;
  }

  String? validatePhone(String? value){
    if(value == null || value.isEmpty){
      return "Phone number is required";
    }
    else if(!RegExp(r'^[6-9]\d{9}$').hasMatch(value)){
      return "enter a valid valid 10 digit phone number";
    }
    return null;
  }

  Future<void> pickFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        
        filePath = result.files.single.path;
        File file = File(filePath!);
        resume = file.readAsBytesSync();
        print("the file path is" + resume.toString());
      });
    } else {
      print("User cancelled ");
    }
  }

  Future<void> sendData()async{
   try{
     final response = await http.post(Uri.parse('https://iotreeminds.com/form-submissions/hiring-formSubmission-create'),
         headers: {
           'X-API-Key' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NmYzZTZjYmRhMTE5ZDAyMTUwYTBlOGMiLCJfcGhvbmVOdW1iZXIiOiI5OTIxMTI5MDI1IiwidXNlclR5cGVJZCI6IjY2ZWQxNzE5Y2EwNGY4MWRjMjM3NTg5NyIsInVzZXJUeXBlIjoibWF0Y2htYWtlciIsImlhdCI6MTcyNzMzMzQwMywiZXhwIjoxNzI3MzU1MDAzfQ.8t33_eVi9hH_-lmKK0i94ISn6NtUvbLf1a8cYHH_AwI'
         },
         body: {

           "roleName": roleController.text.toString(),

           "firstName": firstController.text.toString(),

           "lastName": lastController.text.toString(),
           "email": emailController.text.toString(),

           "phoneNumber": phoneController.text.toString(),

           "currentCity": cityController.text.toString(),

           "experience": experienceController.text.toString(),

           "bio": bioController.text.toString(),

           "whyApply": whyApplyController.text.toString(),

           "expectationFromRole": expectaionFromRoleController.text.toString(),

           "resume": resume.toString(),
           "links": urlList.join(","),
           "form": "669f5dffe97ef3e1cf4affa8",
         }

     );
     print(response.statusCode);
     if(response.statusCode == 200){
       Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitScreen(),));
     }
     else{
       var data = jsonDecode(response.body);
       print(data);
     }
   }catch(e){
     print("error ${e}");
   }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Registration Form",style: TextStyle(color: Colors.yellow),),
            toolbarHeight: 80,
            backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18,),
            Center(child: Text("Update Personal Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            SizedBox(height: 18,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Mention the role you are looking for at IM",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red),)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: roleController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        label: Text("Fill the name of the role"),
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("First Name",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: firstController,
                      validator: validateName,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text("Add first Name"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Last Name",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: lastController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text("Add last Name"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Email id",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text("Add email id"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Phone Number",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: phoneController,
                      maxLength: 10,
                      validator: validatePhone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        counterText: "",
                          fillColor: Colors.white,
                          filled: true,
                          label: Text("Add phone number"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Current City",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text("Add current city"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Your Experience",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: experienceController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          label: Text("Add your experience"),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Your Bio",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: bioController,
                      maxLines: 2,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Add your bio",
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Why do you want to apply for the role ?",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: whyApplyController,
                      maxLines: 2,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                           hintText: "Tell the reason",

                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("What do you expect out of this role and us ",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: expectaionFromRoleController,
                      maxLines: 2,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "please write",
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Upload your file here",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    filePath != null ? 
                        Text(filePath.toString())
                        :
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        pickFile();
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: filePath != "" ? filePath.toString() : "Upload your file here",
                          suffixIcon: Icon(Icons.cloud_upload,color: Colors.yellow,size: 35,),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Other Links",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("*",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            controller: linkController,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Add links",
                                border: OutlineInputBorder(borderRadius:BorderRadius.circular(7), borderSide: BorderSide.none)
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: (){
                                urlList.clear();
                                setState(() {

                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 21),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                backgroundColor: Colors.redAccent.withOpacity(0.8)
                              ),
                              child: Text("Remove",style: TextStyle(color: Colors.white),)),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: (){
                                if(linkController.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a link")));
                                }
                                else{
                                  urlList.add(linkController.text.toString());
                                  linkController.clear();
                                  setState(() {
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 21),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: Colors.yellow.withOpacity(0.8)
                              ),
                              child: Text("Add",style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      itemCount: urlList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(urlList[index].toString()),
                          GestureDetector(
                              child: Icon(Icons.cancel_outlined),
                          onTap: (){
                                urlList.removeAt(index);
                                setState(() {

                                });
                          },)
                        ],
                      );
                    },)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  
                  if(nullCheck() == true){
                    sendData();
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the details")));
                  }

                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.yellow.withOpacity(0.8)
                ),
                child: Text("Submit",style: TextStyle(color: Colors.black,fontSize: 20),)),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
