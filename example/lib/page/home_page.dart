import 'dart:async';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/ser/local_storage_ser.dart';
import 'package:hkid_validator_web_demo/widgets/app_drawer/app_drawer.dart';
import 'package:hkid_validator_web_demo/widgets/common/rounded_btn.dart';
import 'package:hkid_validator_web_demo/widgets/gen_hkid_widget.dart';
import 'package:hkid_validator_web_demo/widgets/validate_hkid_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeStatus();
}

class _HomeStatus extends State<HomePage> with AfterLayoutMixin<HomePage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final ScrollController _scrolContrl =
      ScrollController(initialScrollOffset: 0.0);
  late ValueNotifier<AnimatedStatus> _animatedStatus;
  late ValueNotifier<Section> _sectionNotifi;
  late double _lastOffset;
  late bool? _isForward;

  @override
  void initState() {
    _animatedStatus = ValueNotifier(AnimatedStatus.idle);
    _sectionNotifi = ValueNotifier(Section.generate);
    _lastOffset = 0.0;
    _isForward = null;
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    _animatedStatus.dispose();
    _scrolContrl.dispose();
    _sectionNotifi.dispose();
    super.dispose();
  }

  void _goValidateSection() {
    _sectionNotifi.value = Section.validate;
    LocalStorageSer().setSysConfig('section', 'validate');
    _scrolContrl.jumpTo(MediaQuery.of(context).size.height);
    _reset();
  }

  void _goGenrateSection() {
    _sectionNotifi.value = Section.generate;
    LocalStorageSer().setSysConfig('section', 'generate');
    _scrolContrl.jumpTo(0.0);
    _reset();
  }

  void _reset() {
    _isForward = null;
    _animatedStatus.value = AnimatedStatus.animated;
    _animatedStatus.value = AnimatedStatus.idle;
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        drawer: AppDrawer(
          sectionNotifi: _sectionNotifi,
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notify) {
            if (_animatedStatus.value == AnimatedStatus.idle) {
              if (_lastOffset != _scrolContrl.offset) {
                if (_lastOffset < _scrolContrl.offset) {
                  _isForward = true;
                } else if (_lastOffset > _scrolContrl.offset) {
                  _isForward = false;
                } else {}
                _animatedStatus.value = AnimatedStatus.animating;
              }
            }
            return true;
          },
          child: Stack(
            children: [
              ListView(
                controller: _scrolContrl,
                children: const [
                  GeneratedHKIDWidget(),
                  ValidateHKIDWidget(),
                ],
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<Section>(
                        valueListenable: _sectionNotifi,
                        builder: (context, section, child) {
                          return RoundedBtn(
                            isSelected: section == Section.generate,
                            onTap: () => _goGenrateSection(),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      ValueListenableBuilder<Section>(
                        valueListenable: _sectionNotifi,
                        builder: (context, section, child) {
                          return RoundedBtn(
                            isSelected: section == Section.validate,
                            onTap: () => _goValidateSection(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 10,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  icon: const FaIcon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    String? section = LocalStorageSer().readSysConfig('section');
    if (section == 'validate') {
      _sectionNotifi.value = Section.validate;
      _goValidateSection();
    }
    _animatedStatus.addListener(() {
      _lastOffset = _scrolContrl.offset;
      if (_isForward == true) {
        _goValidateSection();
      } else if (_isForward == false) {
        _goGenrateSection();
      } else {}
    });
  }
}
