import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ItemQuantity extends StatefulWidget {
  final double price;
  final String itemName;
  final int itemId;
  final Function addToChosenItems;
  final int index;
  final int quantity;

  const ItemQuantity({
    Key? key,
    required this.price,
    required this.itemId,
    required this.itemName,
    required this.addToChosenItems,
    required this.index,
    required this.quantity,
  }) : super(key: key);

  @override
  State<ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<ItemQuantity> {
  int quantity = 1;

  @override
  void initState() {
    widget.addToChosenItems(
        widget.index, widget.itemId, 1, widget.itemName, widget.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              '${widget.itemName}, ${'price'.tr()}: ${widget.price}',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        padding: EdgeInsets.zero),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity -= 1;
                        });
                        widget.addToChosenItems(widget.index, widget.itemId,
                            quantity, widget.itemName, widget.price);
                      }
                    },
                    child: const Icon(Icons.remove)),
              ),
              SizedBox(
                width: 50,
                child: Center(
                  child: Text(
                    '$quantity',
                  ),
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: Center(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          padding: EdgeInsets.zero),
                      onPressed: () {
                        if (widget.quantity >= quantity) {
                          setState(() {
                            quantity += 1;
                          });
                          widget.addToChosenItems(widget.index, widget.itemId,
                              quantity, widget.itemName, widget.price);
                        }
                      },
                      child: const Icon(Icons.add)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
