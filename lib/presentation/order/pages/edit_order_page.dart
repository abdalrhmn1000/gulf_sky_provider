import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/inventory.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as or;
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/domain/order/usecases/create_order_detail_item_use_case.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/back_leading_icon.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_app_bar.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/error_view.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_utils.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/create_order_detail_item_bloc/create_order_detail_item_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/inventory_list_bloc/inventory_list_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/update_order_bloc/update_order_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/update_order_details_bloc/update_order_details_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/widgets/edit_order/item_quantity.dart';
import 'package:image_picker/image_picker.dart';

class EditOrderPage extends StatefulWidget {
  final or.Order order;
  final OrderDetails orderDetails;

  const EditOrderPage({
    Key? key,
    required this.order,
    required this.orderDetails,
  }) : super(key: key);

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage>
    with ScreenUtils<EditOrderPage>, ScreenLoader {
  final UpdateOrderBloc _updateOrderBloc = getIt<UpdateOrderBloc>();
  final UpdateOrderDetailsBloc _updateOrderDetailsBloc =
      getIt<UpdateOrderDetailsBloc>();
  final CreateOrderDetailItemBloc _createOrderDetailItemBloc =
      getIt<CreateOrderDetailItemBloc>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();

  DateTime dateTime = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  File? _updatedImage;

  final InventoryListBloc _inventoryListBloc = getIt<InventoryListBloc>();

  List<Inventory>? chosenItems = [];
  List<int> quantities = [];

  void addToChosenItems(int index, int id, int q, String name, double price) {
    chosenItems!.insert(
        index, Inventory(id: id, name: name, quantity: q, price: price));

    chosenItems!.removeAt(index + 1);
  }

  @override
  void initState() {
    _inventoryListBloc.add(InventoryListRequested());
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: const BackLeadingIcon(),
          title: Text('edit'.tr()),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<UpdateOrderBloc, BaseState<String>>(
              bloc: _updateOrderBloc,
              listener: (context, state) {
                if (state.isInProgress) {
                  startLoading();
                } else if (state.isFailure) {
                  showError(failure: state.failure);
                  stopLoading();
                } else if (state.isSuccess) {}
              },
            ),
            BlocListener<UpdateOrderDetailsBloc, BaseState<String>>(
              bloc: _updateOrderDetailsBloc,
              listener: (context, state) {
                if (state.isInProgress) {
                } else if (state.isFailure) {
                  showError(failure: state.failure);
                  stopLoading();
                } else if (state.isSuccess) {
                  stopLoading();
                }
              },
            ),
            BlocListener<CreateOrderDetailItemBloc, BaseState<String>>(
              bloc: _createOrderDetailItemBloc,
              listener: (context, state) {
                if (state.isInProgress) {
                } else if (state.isFailure) {
                  showError(failure: state.failure);
                  stopLoading();
                } else if (state.isSuccess) {
                  stopLoading();
                  showSuccess();
                  AutoRouter.of(context).pop(true);
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 25),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Assets.images.logo.image(
                      width: 224,
                      height: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.order.status!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'choose_image'.tr(),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final image = await _picker.pickImage(
                                source: ImageSource.camera);

                            setState(() {
                              _updatedImage =
                                  image == null ? null : File(image.path);
                            });
                          },
                          child: Container(
                            width: 75,
                            height: 75,
                            margin: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Builder(
                              builder: (context) {
                                if (_updatedImage != null) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _updatedImage!,
                                        fit: BoxFit.cover,
                                      ));
                                } else {
                                  if (widget.orderDetails.image != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            widget.orderDetails.image ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else {
                                    return const Icon(
                                        Icons.add_a_photo_outlined);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        labelText: 'notes'.tr(),
                        hintText: 'notes'.tr(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      alignment: (context.locale.toString() == 'en')
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Text(
                        'choose_items'.tr(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    BlocBuilder<InventoryListBloc, BaseState<List<Inventory>>>(
                      bloc: _inventoryListBloc,
                      builder: (context, state) {
                        if (state.isInProgress) {
                          // return const ShimmerWidget(
                          //   width: double.infinity,
                          //   height: 120,
                          // );
                        } else if (state.isFailure) {
                          return SizedBox(
                            height: 160,
                            child: Center(
                              child: ErrorView(
                                failure: state.failure,
                                onRetry: () {
                                  _inventoryListBloc
                                      .add(InventoryListRequested());
                                },
                              ),
                            ),
                          );
                        }
                        if (state.isSuccess) {
                          return DropdownSearch<Inventory>.multiSelection(
                            items: state.item!,
                            itemAsString: (item) => '${item.name}, ${'price'.tr()}: ${item.price??0.0}',
                            popupProps: PopupPropsMultiSelection.bottomSheet(
                                showSearchBox: true,
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        'items'.tr(),
                                        style: const TextStyle(fontSize: 20),
                                      )),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                      hintText: 'search'.tr(),
                                      suffixIcon: const Icon(Icons.search)),
                                )),
                            onSaved: (newValue) {
                              setState(() {
                                chosenItems = newValue;
                              });
                            },
                            onChanged: (newValue) {
                              setState(() {
                                chosenItems = newValue;
                              });
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: chosenItems!.length,
                        itemBuilder: (context, index) {
                          return ItemQuantity(
                            itemId: chosenItems!.elementAt(index).id,
                            itemName: chosenItems!.elementAt(index).name ?? '',
                            price: chosenItems!.elementAt(index).price ?? 0.0,
                            quantity:
                                chosenItems!.elementAt(index).quantity ?? 0,
                            addToChosenItems: addToChosenItems,
                            index: index,
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 50,
                      ),
                      child: DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'date'.tr(),
                        timeLabelText: 'hour'.tr(),
                        onChanged: (val) {
                          dateTime = DateTime.parse(val);
                        },
                        validator: (val) {
                          return null;
                        },
                        onSaved: (val) {},
                      ),
                    ),
                  ],
                )),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
            left: 17,
            right: 17,
            bottom: 30,
          ),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) return;
              _updateOrderBloc.add(UpdateOrderRequested(
                orderId: widget.order.id,
                notes: _noteController.text,
                date: DateFormat('dd/MM/yyyy').format(dateTime),
                time: DateFormat.Hm().format(dateTime),
                maintenanceCost: 110,
              ));
              _updateOrderDetailsBloc.add(UpdateOrderDetailsRequested(
                  orderDetailId: widget.orderDetails.id,
                  image: _updatedImage,
                  price: widget.orderDetails.price));
              if (chosenItems?.isNotEmpty ?? false) {
                List<CreateOrderDetailItemUseCaseParams> items = [];
                for (var c in chosenItems!) {
                  items.add(CreateOrderDetailItemUseCaseParams(
                      orderDetailId: widget.orderDetails.id,
                      inventoryId: c.id,
                      quantity: c.quantity,
                      vat: 110));
                }
                _createOrderDetailItemBloc
                    .add(CreateOrderDetailItemRequested(items: items));
              }
            },
            child: Text('edit'.tr()),
          ),
        ));
  }
}
