import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/const/const.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/widgets/app_drawer/locales_btn.dart';
import 'package:hkid_validator_web_demo/widgets/app_drawer/record_widget/generated_record_widget.dart';
import 'package:hkid_validator_web_demo/widgets/app_drawer/record_widget/validated_record_widget.dart';

class AppDrawer extends StatefulWidget {
  final ValueNotifier<Section> sectionNotifi;
  const AppDrawer({
    Key? key,
    required this.sectionNotifi,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['generator', 'validator'];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return ValueListenableBuilder<Section>(
      valueListenable: widget.sectionNotifi,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: Text(
                    'hkidValidator'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFontSer().arimo(
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.45),
                              width: 1.0,
                            ),
                          ),
                          child: Theme(
                            data: ThemeData(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                            child: TabBar(
                              controller: _tabController,
                              automaticIndicatorColorAdjustment: true,
                              physics: const NeverScrollableScrollPhysics(),
                              isScrollable: false,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.amber[900],
                              ),
                              unselectedLabelColor: Colors.black38,
                              labelColor: Colors.white,
                              labelStyle: GoogleFontSer().arimo(
                                const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                              unselectedLabelStyle: GoogleFontSer().arimo(
                                const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                              ),
                              tabs: _tabs.map(
                                (tab) {
                                  return SizedBox(
                                    height: 50,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        tab.tr,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 8.0,
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        GeneratedRecordWidget(),
                        ValidatedRecordWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LocalesBtn(),
        ],
      ),
      builder: (context, section, child) {
        _tabController.index =
            widget.sectionNotifi.value == Section.generate ? 0 : 1;
        return Container(
          width: 350,
          height: MediaQuery.of(context).size.height,
          color: section == Section.generate
              ? const Color.fromRGBO(85, 193, 133, 1.0)
              : const Color.fromRGBO(85, 184, 193, 1.0),
          child: child,
        );
      },
    );
  }
}
