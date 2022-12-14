import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/models/record/validated_record.dart';
import 'package:hkid_validator_web_demo/ser/google_font_ser.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb/indexeddb_ser.dart';
import 'package:hkid_validator_web_demo/widgets/common/copied_text_widget.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class ValidatedRecordWidget extends StatelessWidget {
  const ValidatedRecordWidget({Key? key}) : super(key: key);

  void _saveAsExcel() {
    final res = IndexedDBSer().validatedDBSer().validatedIDNotifi().value;
    if (res != null) {
      final xls.Workbook workbook = xls.Workbook();
      final xls.Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'validatedHKID';
      sheet.getRangeByName('A1').setText('index');
      sheet.getRangeByName('B1').setText('hkid');
      sheet.getRangeByName('C1').setText('isValid');
      sheet.getRangeByName('D1').setText('dateTime');
      for (int i = 0; i < res.length; i++) {
        ValidatedRecord? record = res[i];
        sheet.getRangeByName('A${(i + 2).toString()}').setText(i.toString());
        sheet.getRangeByName('B${(i + 2).toString()}').setText(record!.id);
        sheet
            .getRangeByName('C${(i + 2).toString()}')
            .setText(record.isValid ? 'valid' : 'invalid');
        sheet
            .getRangeByName('D${(i + 2).toString()}')
            .setDateTime(record.validatedAt);
      }
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'validatedHKID.xlsx')
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
      child: ValueListenableBuilder<List<ValidatedRecord?>?>(
        valueListenable: IndexedDBSer().validatedDBSer().validatedIDNotifi(),
        builder: ((context, validatedRecord, child) {
          if (validatedRecord == null || validatedRecord.isEmpty) {
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
                right: 10.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: validatedRecord.length,
                      itemBuilder: (context, index) {
                        ValidatedRecord? record = validatedRecord[index];
                        return SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      {index + 1}.toString(),
                                      style: GoogleFontSer().arimo(
                                        const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    CopiedTextWidget(
                                      text: record!.id,
                                      style: GoogleFontSer().arimo(
                                        const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
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
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                        width: 18,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Icon(
                                              record.isValid
                                                  ? Icons.check
                                                  : Icons.close,
                                              color: record.isValid
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        )
                                        //  EnvImgWidget(
                                        //   padding: EdgeInsets.all(
                                        //       record.isValid ? 3.0 : 6.0),
                                        //   boxFit: BoxFit.fitHeight,
                                        //   src:
                                        //       "icons/${record.isValid ? 'check' : 'close'}_16x16.png",
                                        //   color: record.isValid
                                        //       ? Colors.green
                                        //       : Colors.red,
                                        // ),
                                        )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    record.date(dateTime: record.validatedAt),
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
