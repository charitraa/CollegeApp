import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lbef/utils/utils.dart';
import 'package:lbef/widgets/form_widget/custom_button.dart';
import 'package:lbef/widgets/form_widget/custom_textarea.dart';

import '../../../resource/colors.dart';
import '../../../widgets/form_widget/custom_file_upload.dart';
import '../../../widgets/form_widget/custom_textfield_label.dart';

class EditApplication extends StatefulWidget {
  final String subject;
  final String department;
  final String description;
  final File? image;

  const EditApplication({
    super.key,
    required this.subject,
    required this.department,
    required this.description,
    this.image,
  });

  @override
  State<EditApplication> createState() => _EditApplicationState();
}

class _EditApplicationState extends State<EditApplication> {
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
  void initState() {
    super.initState();
    subjectController.text = widget.subject;
    departmentController.text = widget.department;
    descriptionController.text = widget.description;
    _image = widget.image;
  }

  @override
  void dispose() {
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
          "Edit Application",
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
            width: 70,
            height: 50,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
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
                    "Attachment selected!",
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
              text: 'Update',
              isLoading: false,
              onPressed: () async {
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

                Utils.flushBarSuccessMessage("Application updated!", context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
