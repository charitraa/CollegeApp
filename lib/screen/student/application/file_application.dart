import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lbef/utils/utils.dart';
import 'package:lbef/widgets/form_widget/custom_button.dart';
import 'package:lbef/widgets/form_widget/custom_label_textfield.dart';
import 'package:lbef/widgets/form_widget/custom_textarea.dart';

import '../../../resource/colors.dart';
import '../../../widgets/form_widget/custom_file_upload.dart';
import '../../../widgets/form_widget/custom_textfield_label.dart';

class FileApplication extends StatefulWidget {
  const FileApplication({super.key});

  @override
  State<FileApplication> createState() => _FileApplicationState();
}

class _FileApplicationState extends State<FileApplication> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final picker = ImagePicker();
  File? _image;
  String error = '';

  Future uploadImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        error = '';
      });
    } else {
      setState(() {
        error = "No image selected";
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    subjectController.dispose();
    departmentController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "File Application",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 18,
        ),
        actions: const [
          Image(
            image: AssetImage('assets/images/lbef.png'),
            width: 56,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            CustomTextfieldLabel(
              hintText: 'Email',
              outlinedColor: Colors.black,
              focusedColor: AppColors.primary,
              width: size.width,
              text: 'Email',
              textController: emailController,
            ),
            const SizedBox(height: 5),
            CustomTextfieldLabel(
              hintText: 'Subject',
              outlinedColor: Colors.black,
              focusedColor: AppColors.primary,
              width: size.width,
              text: 'Subject',
              textController: subjectController,
            ),
            const SizedBox(height: 5),
            CustomTextfieldLabel(
              hintText: 'Department',
              outlinedColor: Colors.black,
              focusedColor: AppColors.primary,
              width: size.width,
              text: 'Department',
              textController: departmentController,
            ),
            const SizedBox(height: 5),
            CustomTextArea(
              hintText: 'Description',
              outlinedColor: Colors.black,
              focusedColor: AppColors.primary,
              width: size.width,
              label: 'Description',
              textController: descriptionController,
            ),
            const SizedBox(height: 5),
            CustomFileUpload(
              upload: "Attachment",
              labelText: "Upload valid attachment!!",
              onPressed: uploadImage,
              label: "Upload valid attachment",
              height: 40,
            ),
            const SizedBox(height: 10),
            if (_image != null)
              Column(
                children: [
                  Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Attachment Selected successfully!",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontFamily: 'poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              )
            else
              Text(
                error,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Submit',
              isLoading: false,
              onPressed: () async {
                final email = emailController.text.trim();
                final subject = subjectController.text.trim();
                final department = departmentController.text.trim();
                final description = descriptionController.text.trim();


                if (subject.isEmpty) {
                  Utils.flushBarErrorMessage("Subject cannot be empty", context);
                  return;
                }
                if (department.isEmpty) {
                  Utils.flushBarErrorMessage("Department cannot be empty", context);
                  return;
                }
                if (description.isEmpty) {
                  Utils.flushBarErrorMessage("Description cannot be empty", context);
                  return;
                }
                Utils.flushBarSuccessMessage("Form submitted!", context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
