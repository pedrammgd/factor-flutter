import 'package:flutter/material.dart';

class CameraOrGalleryBottomSheet {
  static final CameraOrGalleryBottomSheet _instance =
      CameraOrGalleryBottomSheet.internal();

  CameraOrGalleryBottomSheet.internal();

  factory CameraOrGalleryBottomSheet() => _instance;

  static void chooseCameraOrGallery(
    BuildContext context, {
    String? title,
    Function()? cameraButtonFunction,
    Function()? galleryButtonFunction,
  }) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 70,
              margin: const EdgeInsets.only(bottom: 30, left: 50, right: 50),
              child: Material(
                color: Theme.of(context).primaryColor,
                elevation: 20,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: cameraButtonFunction,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 35,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text(
                              'دوربین',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: galleryButtonFunction,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.photo,
                              size: 35,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text(
                              'گالری',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return _buildNewTransition(context, anim1, anim2, child);
      },
    );
  }
}

Widget _buildNewTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0.0),
  ).animate(animation);
  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
