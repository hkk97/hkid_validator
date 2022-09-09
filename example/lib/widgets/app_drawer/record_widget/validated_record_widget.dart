import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkid_validator_web_demo/model/record/generated_record.dart';
import 'package:hkid_validator_web_demo/model/record/validated_record.dart';
import 'package:hkid_validator_web_demo/ser/indexeddb_ser.dart';
import 'package:hkid_validator_web_demo/widgets/common/copied_text_widget.dart';
import 'package:sembast/sembast.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'dart:html';

class ValidatedRecordWidget extends StatelessWidget {
  const ValidatedRecordWidget({Key? key}) : super(key: key);

  void _saveAsExcel() {
    final snapshots = IndexedDBSer().validatedRCDNotifi().value;
    if (snapshots != null) {
      final xls.Workbook workbook = xls.Workbook();
      final xls.Worksheet sheet = workbook.worksheets[0];
      sheet.name = 'validatedHKID';
      sheet.getRangeByName('A1').setText('index');
      sheet.getRangeByName('B1').setText('hkid');
      sheet.getRangeByName('C1').setText('isValid');
      sheet.getRangeByName('D1').setText('dateTime');
      for (int i = 0; i < snapshots.length; i++) {
        ValidatedRecord record = ValidatedRecord.fromJson(snapshots[i]!.value);
        sheet
            .getRangeByName('A${(i + 2).toString()}')
            .setText(snapshots[i]!.key.toString());
        sheet.getRangeByName('B${(i + 2).toString()}').setText(record.id);
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
      child: ValueListenableBuilder<List<RecordSnapshot?>?>(
        valueListenable: IndexedDBSer().validatedRCDNotifi(),
        builder: ((context, snapshots, child) {
          if (snapshots == null || snapshots.isEmpty) {
            return Center(
              child: Text(
                "noneOfRecords".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
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
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: snapshots.length,
                      itemBuilder: (context, index) {
                        ValidatedRecord record =
                            ValidatedRecord.fromJson(snapshots[index]!.value);
                        return SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      snapshots[index]!.key.toString(),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    CopiedTextWidget(
                                      text: record.id,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                      child: Text(
                                        record.id,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: FittedBox(
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
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    record.date(),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.0,
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
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
