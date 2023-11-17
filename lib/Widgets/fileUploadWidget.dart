import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsic/api_call.dart';
import 'package:open_file_plus/open_file_plus.dart';

class FileUploadWidget extends StatefulWidget {
  final String title;
  final String sizeText;
  final String size;
  final String companyId;

  const FileUploadWidget(
      {Key? key,
      required this.title,
      required this.sizeText,
      required this.size,
      required this.companyId})
      : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {

  void openFile(String path) {
    OpenFile.open(path);
  }
  bool isUploaded = false;
  bool isUploading = false;
  bool onceUploaded = false;
  String path = "";

  @override
  Widget build(BuildContext context) {
    return isUploading
        ? Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        : Column(
            children: [
              onceUploaded?
              InkWell(
                onTap: () {
                  openFile(path);
                },
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isUploaded ? Colors.green : Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.upload,
                          color: isUploaded ? Colors.green : Colors.black,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: isUploaded
                                        ? Colors.green
                                        : Colors.black),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.sizeText,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: isUploaded
                                        ? Colors.green
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Your entered Document will be removed',
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        ElevatedButton(
                                            onPressed: () async {

                                              setState(() {
                                                isUploading = true;
                                              });
                                              int error = await ApiCall().deleteUploadedDetailsDocuments(widget.companyId, widget.title);
                                              setState(() {
                                                isUploading = false;
                                              });

                                              if(error ==4){
                                                setState(() {
                                                  path = "";
                                                  isUploaded = false;
                                                });

                                                setState(() {
                                                  onceUploaded= false;
                                                });
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Text('Confirm')),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[400],
                            ))
                      ],
                    )),
              ):
              InkWell(
                onTap: () async {
                  final results = await FilePicker.platform.pickFiles(
                      allowedExtensions: ["jpg" ,"png", "gif", "pdf","jpeg"],
                      type: FileType.custom,
                      allowMultiple: false);
                  if (results == null) {
                    return;
                  }
                  else {
                    if (double.parse(results.files.first.size.toString()) < double.parse(widget.size) * 1024 * 1024) {
                      setState(() {
                        isUploading = true;
                      });
                      String result = await ApiCall().uploadDocuments(
                        widget.companyId,
                          results.files.first.path.toString(),
                          results.files.first.name,
                          widget.title);
                      setState(() {
                        path = results.files.first.path.toString();
                        isUploading = false;
                      });
                      if (int.parse(result) != 200) {
                        Get.defaultDialog(
                            title: "Error",
                            middleText:
                            "There was Some error from our end pls try again",
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Try Again"))
                            ]);
                      }
                      else {
                        Get.defaultDialog(
                            title: "Success",
                            middleText: "Your File has been uploaded.",
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    setState(() {
                                      onceUploaded= true;
                                    });
                                  },
                                  child: Text("Okay"))
                            ]);
                        setState(() {
                          isUploaded = true;
                        });
                      }
                    }
                    else {
                      Get.defaultDialog(
                          title: "Size Too Big",
                          middleText: "Size Should be under ${widget.size} MB",
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Got It"))
                          ]);
                    }
                  }
                },
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isUploaded ? Colors.green : Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.upload,
                          color: isUploaded ? Colors.green : Colors.black,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: isUploaded
                                        ? Colors.green
                                        : Colors.black),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.sizeText,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: isUploaded
                                        ? Colors.green
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
  }
}
