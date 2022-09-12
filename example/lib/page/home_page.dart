import 'dart:async';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/ser/app_ser.dart';
import 'package:hkid_validator_web_demo/widgets/app_drawer/app_drawer.dart';
import 'package:hkid_validator_web_demo/widgets/common/bottom_indicator_btn.dart';
import 'package:hkid_validator_web_demo/widgets/common/env_img_widget.dart';
import 'package:hkid_validator_web_demo/widgets/gen_hkid_widget.dart';
import 'package:hkid_validator_web_demo/widgets/validate_hkid_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeStatus();
}

class _HomeStatus extends State<HomePage> with AfterLayoutMixin {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final ScrollController _scrolContrl =
      ScrollController(initialScrollOffset: 0.0);
  late ValueNotifier<AnimatedStatus> _animatedStatus;
  late ValueNotifier<Section> _sectionNotifi;
  late ValueNotifier<double> _lastOffsetNotifi;
  late bool? _isForward;

  @override
  void initState() {
    _animatedStatus = ValueNotifier(AnimatedStatus.idle);
    _sectionNotifi = ValueNotifier(Section.generate);
    _lastOffsetNotifi = ValueNotifier(0.0);
    _isForward = null;
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    _lastOffsetNotifi.dispose();
    _animatedStatus.dispose();
    _scrolContrl.dispose();
    _sectionNotifi.dispose();
    super.dispose();
  }

  Future goSection(
    BuildContext context,
    Section section,
  ) async {
    await AppSer().indexedDBSer().sysDBSer().write(
        sec: section == Section.validate ? Section.validate : Section.generate);
    _sectionNotifi.value = section;
    shiftSection(section);
    AppSer().themeContrl().updateTheme(section: _sectionNotifi.value);
    _reset();
  }

  void shiftSection(Section section) => _scrolContrl.jumpTo(
      section == Section.validate ? MediaQuery.of(context).size.height : 0.0);

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
              if (_lastOffsetNotifi.value != _scrolContrl.offset) {
                if (_lastOffsetNotifi.value < _scrolContrl.offset) {
                  _isForward = true;
                } else if (_lastOffsetNotifi.value > _scrolContrl.offset) {
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
                children: [
                  const GeneratedHKIDWidget(),
                  ValidateHKIDWidget(
                    lastOffsetNotifi: _lastOffsetNotifi,
                    animatedStatus: _animatedStatus,
                    bottomIndicatorBtn: BottomIndicatorBtn(
                      sectionNotifi: _sectionNotifi,
                      onTapGoSection: (section) async =>
                          await goSection(context, section),
                    ),
                    reverse: () => _isForward = false,
                  ),
                ],
              ),
              ValueListenableBuilder<Section>(
                valueListenable: _sectionNotifi,
                builder: (context, section, child) {
                  return section == Section.generate
                      ? Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: BottomIndicatorBtn(
                            sectionNotifi: _sectionNotifi,
                            onTapGoSection: (section) async =>
                                await goSection(context, section),
                          ),
                        )
                      : const SizedBox();
                },
              ),
              Positioned(
                left: 30,
                top: 25,
                child: InkWell(
                  onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  child: const EnvImgWidget(
                    src: 'icons/menu_32x32.png',
                    width: 25,
                    height: 25,
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
  FutureOr<void> afterFirstLayout(context) async {
    final sysNotifi = AppSer().indexedDBSer().sysDBSer().sysNotifi();
    await goSection(context, sysNotifi.value!.sec ?? Section.generate);

    _animatedStatus.addListener(() async {
      _lastOffsetNotifi.value = _scrolContrl.offset;
      if (_isForward == true) {
        await goSection(context, Section.validate);
      } else if (_isForward == false) {
        await goSection(context, Section.generate);
      } else {}
    });
  }
}
