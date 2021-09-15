import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:folio/admin/models/RecentFile.dart';
import 'package:folio/menu/bloc/repository/firebase_stock_model.dart';
import 'package:folio/menu/constants/data_converter.dart';
import 'package:folio/public_data.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Les element actuel",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Image"),
                ),
                DataColumn(
                  label: Text("Element"),
                ),
                DataColumn(
                  label: Text("PU"),
                ),
                DataColumn(
                  label: Text("Pu promo"),
                ),
                DataColumn(label: Text("En promo")),
                DataColumn(label: Text("Modifier")),
              ],
              rows: List.generate(globalListOfStock.length, (index) {
                return recentFileDataRow(globalListOfStock[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(FStock item) {
  bool _isSale = item.isSales;
  return DataRow(
    cells: [
      DataCell(
        Image.memory(
          DataConverter.image(item.productImage),
          height: 30,
          width: 30,
        ),
      ),
      DataCell(Flexible(
          child: Text(
        item.productName,
        style: TextStyle(fontSize: 12),
      ))),
      DataCell(Text(DataConverter.currencyConvert(item.productUnitPrice))),
      DataCell(Text(DataConverter.currencyConvert(item.productSalesPrice))),
      DataCell(FlutterSwitch(
         
            value: _isSale,
           
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) {
             _isSale = val;
            },
      )),
      DataCell(IconButton(
          onPressed: () {
            print(item.productName);
          },
          icon: Icon(Icons.edit))),
    ],
  );
}
