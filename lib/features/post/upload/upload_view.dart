import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/post/upload/upload_post.dart';
import 'package:social_app/products/constants/index.dart';
import 'package:social_app/products/models/post_model.dart';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  XFile? image;
  final User? user = FirebaseAuth.instance.currentUser;
  final _captionController = TextEditingController();
  Future<void> _pickImage() async {
    await ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
    )
        .then((value) {
      setState(() {
        image = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 50,
          children: [
            InkWell(
              onTap: () async {
                await _pickImage();
              },
              child: Column(
                children: [
                  Container(
                    width: context.highValue * 4,
                    height: context.highValue * 4.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstants.gainsBoro,
                        width: 2,
                      ),
                    ),
                    child: (image != null)
                        ? Image.file(File(image!.path))
                        : const Center(
                            child: Text(
                              StringConstants.pickAnImage,
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: context.highValue * 4,
              child: TextField(
                controller: _captionController,
                maxLength: 120,
                decoration: const InputDecoration(
                  label: Text(
                    StringConstants.description,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTapOutside: (_) => {FocusScope.of(context).unfocus()},
              ),
            ),
            ElevatedButton(
              onPressed: image != null && _captionController.text.isNotEmpty
                  ? () async {
                      await uploadPostToDatabase(
                        Post(
                          description: _captionController.text,
                          datePublished: DateTime.now(),
                          postUrl: '',
                          publisherName: user?.displayName ?? '',
                          publisherProfileImage: user?.photoURL ?? '',
                          publisherUid: user?.uid ?? '',
                        ),
                        image!,
                      ).whenComplete(() => context.pop());
                    }
                  : null,
              child: Padding(
                padding: context.paddingNormal,
                child: const Text(StringConstants.upload),
              ),
            )
          ],
        ),
      ),
    );
  }
}
