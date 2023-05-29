import 'package:flutter/material.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/order_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:provider/provider.dart';

import '../../../base/custom_snackbar.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  final double price;
  final bool kmWiseFee;
  DeliveryOptionButton({required this.value, required this.title, required this.kmWiseFee, required this.price});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return Row(
          children: [
            Radio(
              value: value,
              groupValue: order.orderType,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (String? values) {
                if(values == 'delivery'){
                  if(price >= 300){
                    order.setOrderType(values!);
                  }else{
                    showCustomSnackBar('Minimum order amount is 300 for Delivery, You have ${price} in your cart, please add more item.', context,isError: true);
                  }
                }else {
                  order.setOrderType(values!);
                }
              },
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

            Text(title, style: poppinsRegular),
            SizedBox(width: 5),

            kmWiseFee ? SizedBox() : Text('(${value == 'delivery' ? getTranslated('free', context) : getTranslated('free', context)})', style: poppinsMedium),

          ],
        );
      },
    );
  }
}
