import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class SelectFiles extends StatefulWidget {
  final void Function(List<File> images) getImages;
  const SelectFiles({
    required this.getImages,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectFiles> createState() => _SelectFilesState();
}

class _SelectFilesState extends State<SelectFiles> {
  List<File> _images = [];

  void _pickImages() async {
    try {
      await _openModalSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _openModalSheet() async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                var file = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (file == null) return;
                _addImages([file]);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Photos'),
              onTap: () async {
                var files = await ImagePicker().pickMultiImage(
                  maxWidth: 600,
                  imageQuality: 75,
                );
                if (files == null || files.isEmpty) return;
                _addImages(files);
              },
            ),
          ],
        );
      },
    );
  }

  void _addImages(List<XFile> files) {
    List<File> images = [];
    files.forEach((file) {
      images.add(File(file.path));
    });

    setState(() {
      _images = [..._images, ...images];
    });
    widget.getImages(_images);

    Navigator.of(context).pop();
  }

  void _deleteImages() {
    setState(() {
      _images = [];
    });
    widget.getImages(_images);
  }

  void _deleteImg(int index) {
    setState(() {
      _images.removeAt(index);
    });
    widget.getImages(_images);
  }

  @override
  Widget build(BuildContext context) {
    return _images.isNotEmpty
        ? ProductImages(
            images: _images,
            pickImages: _pickImages,
            deleteImages: _deleteImages,
            deleteImg: _deleteImg,
          )
        : GestureDetector(
            onTap: _pickImages,
            child: DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [10, 4],
              radius: const Radius.circular(10),
              strokeCap: StrokeCap.round,
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.folder_open,
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Select Product Images',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class ProductImages extends StatefulWidget {
  final List<File> images;
  final VoidCallback pickImages;
  final VoidCallback deleteImages;
  final Function(int index) deleteImg;

  const ProductImages({
    required this.images,
    required this.pickImages,
    required this.deleteImages,
    required this.deleteImg,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView(
            children: widget.images
                .asMap()
                .entries
                .map(
                  (image) => Stack(
                    children: [
                      Image.file(
                        image.value,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () => widget.deleteImg(image.key),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(blurStyle: BlurStyle.normal)
                              ],
                            ),
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: widget.pickImages,
              icon: const Icon(Icons.image),
              label: const Text('Add Image'),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: widget.deleteImages,
              icon: const Icon(Icons.delete),
              label: const Text('Delete Images'),
            )
          ],
        )
      ],
    );
  }
}
