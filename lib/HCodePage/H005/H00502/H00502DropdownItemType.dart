import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';

import 'H00502OrdersEnum.dart';

class H00502DropdownItemType {
  String display;
  H00502OrdersEnum value;
  QueryOrders orders;

  H00502DropdownItemType(this.display, this.value,this.orders);
}