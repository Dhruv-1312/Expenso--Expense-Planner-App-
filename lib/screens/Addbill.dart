import 'package:expenso/Providers/user_provider.dart';
import 'package:expenso/resources/firestore_methods.dart';
import 'package:expenso/utils/colors.dart';
import 'package:expenso/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expenso/Models/users.dart' as models;
import 'package:provider/provider.dart';

class AddBill extends StatefulWidget {
  const AddBill({super.key});

  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  final TextEditingController billAmountControl = TextEditingController();
  Uint8List? _file;
  bool isloading = false;
  selectImage(BuildContext parentContext) async {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29),
            ),
            shadowColor: Colors.black,
            title: const Text('Add Bill'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop;
                  Uint8List file = await pickimage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickimage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  cleatimgae() {
    setState(() {
      _file = null;
    });
  }

  void postBill(String uid, String username) async {
    try {
      setState(() {
        isloading=true;
      });
      String res = await FirestoreMethods()
          .uploadBill(billAmountControl.text, uid, username, _file!);

      if (res == 'success') {
        setState(() {
          isloading = false;
        });
        if (context.mounted) {
          ShowSnackBar('Uploaded', context);
        }
        cleatimgae();
      }
    } catch (e) {
      ShowSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    models.users user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Upload Bill',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ),
            body: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.upload_sharp,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () => selectImage(context),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: () => postBill(user.uid, user.username),
                  child: const Text('Upload',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                )
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: cleatimgae,
              ),
              title: const Text(
                'Edit',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                isloading
                    ? const LinearProgressIndicator(
                        color: kPrimaryColor,
                        backgroundColor: kPrimaryLightColor,
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 2),
                      ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Write the Amount..',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                          controller: billAmountControl,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.center),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                      //   height: size.height *0.35,
                      //   width:double.infinity,
                      //   child: Image.memory(_file!,fit: BoxFit.contain),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
