import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/models/record/generated_record.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/indexeddb_ser.dart';
import 'package:hkid_validator_web_demo/widgets/common/copied_text_widget.dart';
import 'package:sembast/sembast.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;

class GeneratedRecordWidget extends StatelessWidget {
  const GeneratedRecordWidget({Key? key}) : super(key: key);

  void _saveAsExcel() {
    final res = IndexedDBSer().generatedDBSer().genIDNotifi().value;
    if (res != null) {
      final xls.Workbook workbook = xls.Workbook();
      final xls.Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'generatedHKID';
      sheet.getRangeByName('A1').setText('index');
      sheet.getRangeByName('B1').setText('hkid');
      sheet.getRangeByName('C1').setText('dateTime');
      for (int i = 0; i < res.length; i++) {
        GeneratedRecord? record = res[i];
        sheet.getRangeByName('A${(i + 2).toString()}').setText(i.toString());
        sheet.getRangeByName('B${(i + 2).toString()}').setText(record!.id);
        sheet
            .getRangeByName('C${(i + 2).toString()}')
            .setDateTime(record.createdAt);
      }
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'generatedHKID.xlsx')
        ..click();
    }
  }

  @override
  Widget build(context) {
    return Card(
      color: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.white10,
          width: 0.85,
        ),
      ),
      child: ValueListenableBuilder<List<GeneratedRecord?>?>(
        valueListenable: IndexedDBSer().generatedDBSer().genIDNotifi(),
        builder: ((context, genRecord, child) {
          if (genRecord == null || genRecord.isEmpty) {
            return Center(
              child: Text(
                "noneOfRecords".tr,
                style: GoogleFontSer().arimo(
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 15.0,
                right: 5.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemCount: genRecord.length,
                        itemBuilder: (context, index) {
                          GeneratedRecord? record = genRecord[index];
                          return SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(index.toString(),
                                          style: GoogleFontSer().arimo(
                                            const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14.0,
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      CopiedTextWidget(
                                        text: record!.id,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                        child: Text(
                                          record.id,
                                          style: GoogleFontSer().arimo(
                                            const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      record.date(),
                                      style: GoogleFontSer().arimo(
                                        const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => _saveAsExcel(),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2.5,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 11.5,
                          ),
                          child: Text(
                            'saveAsCSV'.tr,
                            style: GoogleFontSer().arimo(
                              const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
