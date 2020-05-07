import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junto_beta_mobile/app/custom_icons.dart';
import 'package:junto_beta_mobile/app/expressions.dart';
import 'package:junto_beta_mobile/app/logger/logger.dart';
import 'package:junto_beta_mobile/backend/repositories/expression_repo.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/screens/create/create_actions/create_actions.dart';
import 'package:junto_beta_mobile/screens/create/create_actions/widgets/create_expression_scaffold.dart';
import 'package:junto_beta_mobile/utils/junto_overlay.dart';
import 'package:junto_beta_mobile/utils/time_logger.dart';
import 'package:junto_beta_mobile/widgets/dialogs/single_action_dialog.dart';
import 'package:junto_beta_mobile/widgets/image_cropper.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

/// Create using photo form
class CreatePhoto extends StatefulWidget {
  const CreatePhoto({Key key, this.address, this.expressionContext})
      : super(key: key);

  final ExpressionContext expressionContext;
  final String address;

  @override
  State<StatefulWidget> createState() {
    return CreatePhotoState();
  }
}

// State for CreatePhoto class
class CreatePhotoState extends State<CreatePhoto> {
  File imageFile;
  TextEditingController _captionController;
  bool _showBottomNav = true;

  Future<void> _onPickPressed({@required String source}) async {
    try {
      File image;
      if (source == 'Gallery') {
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
      } else if (source == 'Camera') {
        image = await ImagePicker.pickImage(source: ImageSource.camera);
      }

      if (image == null) {
        setState(() => imageFile = null);
        return;
      }
      final cropped = await _cropPhoto(image);
      print("Cropped Sized:  ${cropped.lengthSync() * 0.000001}");
      if (cropped != null) {
        await _compressImage(cropped);
      } else {
        await _compressImage(image);
      }
      _toggleBottomNav(false);
    } catch (e, s) {
      logger.logException(e, s);
    }
  }

  Future<File> _cropPhoto(final image) async {
    assert(image != null);
    final File cropped = await ImageCroppingDialog.show(context, image,
        aspectRatios: <String>[
          '1:1',
          '2:3',
          '3:2',
          '3:4',
          '4:3',
          '4:5',
          '5:4',
          '9:16',
          '16:9'
        ]);
    if (cropped == null) {
      return null;
    }
    _toggleBottomNav(false);
    return cropped;
  }

  Future<void> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    JuntoLoader.showLoader(
      context,
      color: Colors.white54,
    );
    final tL = TimeLogger("Compress Time");
    tL.startRecoder();
    CompressObject compressObject = CompressObject(
      imageFile: file,
      path: dir.path,
      quality: 80,
      step: 8,
      autoRatio: true,
    );
    Luban.compressImage(compressObject).then((_path) {
      setState(() {
        JuntoLoader.hide();
        imageFile = File(_path);
        tL.logTime();
        logger.logDebug("Compressed ${imageFile.lengthSync() * 0.000001}");
      });
    });
  }

  /// Creates a [PhotoFormExpression] from the given data entered
  /// by the user.
  Map<String, dynamic> createExpression() {
    return <String, dynamic>{
      'image': imageFile,
      'caption': _captionController.value.text
    };
  }

  bool _validate() {
    if (imageFile != null) {
      return true;
    } else {
      return false;
    }
  }

  void _onNext() {
    if (_validate() == true) {
      final Map<String, dynamic> expression = createExpression();
      Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return CreateActions(
              expressionType: ExpressionType.photo,
              address: widget.address,
              expressionContext: widget.expressionContext,
              expression: expression,
            );
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => const SingleActionDialog(
          dialogText: 'Please add a photo.',
        ),
      );
      return;
    }
  }

  void _toggleBottomNav(bool value) {
    setState(() {
      _showBottomNav = value;
    });
  }

  @override
  void initState() {
    super.initState();

    _captionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateExpressionScaffold(
      expressionType: ExpressionType.photo,
      onNext: _onNext,
      showBottomNav: _showBottomNav,
      child: Expanded(
        child: Column(
          children: <Widget>[
            Expanded(
              child: imageFile == null
                  ? Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          _onPickPressed(source: 'Gallery');
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              CustomIcons.add,
                              size: 75,
                            ),
                          ],
                        ),
                      ),
                    )
                  : _captionPhoto(),
            ),
            if (imageFile == null) _uploadPhotoOptions()
          ],
        ),
      ),
    );
  }

  Widget _uploadPhotoOptions() {
    return Container(
      margin: const EdgeInsets.only(bottom: 75),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .75,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              _onPickPressed(source: 'Gallery');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: MediaQuery.of(context).size.width * .5,
              alignment: Alignment.center,
              child: Text(
                'LIBRARY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.7,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _onPickPressed(source: 'Camera');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: MediaQuery.of(context).size.width * .5,
              alignment: Alignment.center,
              child: Text(
                'CAMERA',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _captionPhoto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              Image.file(imageFile),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextField(
                  controller: _captionController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'write a caption..',
                    border: InputBorder.none,
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 1,
                  maxLines: null,
                  style: Theme.of(context).textTheme.caption,
                  keyboardAppearance: Theme.of(context).brightness,
                ),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    imageFile = null;
                  });
                  _toggleBottomNav(true);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  color: Colors.transparent,
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                ),
              ),
              InkWell(
                onTap: () async => _cropPhoto(imageFile),
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  color: Colors.transparent,
                  child: Icon(
                    Icons.crop,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
