import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Models/CartProductModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class CartProductCard extends StatelessWidget {
  final CartProductModel product;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  CartProductCard({this.product, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: MyColor.dividerLight),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 75,
              width: 75,
              child: CachedNetworkImage(
                fadeOutDuration: Duration(milliseconds: 0),
                fadeInDuration: Duration(milliseconds: 0),
                fadeInCurve: Curves.linear,
                fit: BoxFit.cover,
                imageUrl: product.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        style: MyTypography.heading6SB.copyWith(
                          color: MyColor.neutralBlack,
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "\$${product.price}",
                        style: MyTypography.smallText,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Size: ",
                      style: MyTypography.smallText,
                      children: [
                        TextSpan(
                          text: " ${product.size}",
                          style: MyTypography.smallText.copyWith(
                            color: MyColor.neutralGrey3,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Color: ",
                      style: MyTypography.smallText,
                      children: [
                        TextSpan(
                          text: " ${product.color}",
                          style: MyTypography.smallText.copyWith(
                            color: MyColor.neutralGrey3,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Quantity: ",
                      style: MyTypography.smallText,
                      children: [
                        TextSpan(
                          text: " ${product.quantity}",
                          style: MyTypography.smallText.copyWith(
                            color: MyColor.neutralGrey3,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      secondaryActions: <Widget>[
        GestureDetector(
          onTap: () {
            if (onDelete != null) onDelete();
          },
          child: Container(
            color: MyColor.primaryRed,
            child: Center(
              child: SvgPicture.asset(
                "assets/svg_icons/trash-2.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
