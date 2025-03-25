import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:logistic_driver/services/extensions.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  File? _imageFile;
  bool _isCameraInitialized = false;
  List<CameraDescription>? cameras;
  int _cameraId = 0;
  double _currentZoomLevel = 1.0;
  double _maxZoomLevel = 3.0;
  double _minZoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeCamera(_cameraId);
  }

  Future<void> _initializeCamera(int cameraIndex) async {
    cameras = await availableCameras();
    _controller = CameraController(cameras![cameraIndex], ResolutionPreset.high);
    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _switchCamera() async {
    if (cameras!.length > 1) {
      _cameraId = _cameraId == 0 ? 1 : 0;
      await _initializeCamera(_cameraId);
    }
  }

  void _zoomIn() {
    if (_currentZoomLevel < _maxZoomLevel) {
      setState(() {
        _currentZoomLevel++;
        _controller.setZoomLevel(_currentZoomLevel);
      });
    }
  }

  void _zoomOut() {
    if (_currentZoomLevel > _minZoomLevel) {
      setState(() {
        _currentZoomLevel--;
        _controller.setZoomLevel(_currentZoomLevel);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isLoading = false;

  Future<void> _takePicture() async {
    setState(() {
      isLoading = true;
    });
    if (!_controller.value.isInitialized) {
      return;
    }

    if (_controller.value.isTakingPicture) {
      return;
    }

    try {
      XFile picture = await _controller.takePicture();
      File imageFile = File(picture.path);

      img.Image originalImage = img.decodeImage(imageFile.readAsBytesSync())!;

      int boxWidth = 400;
      int boxHeight = 50;
      int xPosition = 10;
      int yPosition = originalImage.height - boxHeight - 10;

      img.fillRect(originalImage, color: img.ColorRgb8(255, 255, 255), x1: xPosition, y1: yPosition, x2: xPosition + boxWidth, y2: yPosition + boxHeight);

      img.drawString(
        originalImage,
        'Date: ${DateTime.now().dateTime}',
        color: img.ColorRgb8(0, 0, 0),
        font: img.arial24,
        x: xPosition + 10,
        y: yPosition + 10,
      );

      // Save the image with location details
      File newImageFile = File(picture.path)..writeAsBytesSync(img.encodeJpg(originalImage));

      setState(() {
        _imageFile = newImageFile;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _imageFile == null
                    ? Stack(
                        children: [
                          CameraPreview(_controller),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  _switchCamera();
                                },
                                icon: Icon(
                                  Icons.cameraswitch_outlined,
                                  size: 24,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                          if (isLoading)
                            const Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                        ],
                      )
                    : Image.file(_imageFile!),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      _imageFile != null
                          ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          : IconButton(
                              onPressed: _zoomOut,
                              icon: Icon(
                                Icons.zoom_out_map,
                                color: Colors.white,
                              ),
                            ),
                      const Spacer(flex: 3),
                      _imageFile == null
                          ? GestureDetector(
                              onTap: _takePicture,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.grey, borderRadius: const BorderRadius.all(Radius.circular(100)), border: Border.all(color: Colors.white, width: 2)),
                              ),
                            )
                          : const SizedBox(),
                      const Spacer(flex: 3),
                      _imageFile != null
                          ? IconButton(
                              icon: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context, _imageFile);
                              },
                            )
                          : IconButton(
                              onPressed: _zoomIn,
                              icon: Icon(
                                Icons.zoom_in_map,
                                color: Colors.white,
                              ),
                            ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
