import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as or;
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/back_leading_icon.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_app_bar.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_utils.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/update_order_bloc/update_order_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/update_order_details_bloc/update_order_details_bloc.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();

  DateTime dateTime = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  File? _updatedImage;

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
                  showSuccess();
                  AutoRouter.of(context).pop(true);
                }
              },
            )
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 25),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await _picker.pickImage(
                            source: ImageSource.gallery);

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
                                    imageUrl: widget.orderDetails.image ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return const Icon(Icons.add_a_photo_outlined);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        labelText: 'notes'.tr(),
                        hintText: 'notes'.tr(),
                      ),
                    ),
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
                date: DateFormat('yyyy/MM/dd').format(dateTime),
                time: DateFormat.Hms().format(dateTime),
              ));
              _updateOrderDetailsBloc.add(UpdateOrderDetailsRequested(
                orderDetailId: widget.orderDetails.id,
                image: _updatedImage,
                price: widget.orderDetails.price
              ));
            },
            child: Text('edit'.tr()),
          ),
        ));
  }
}
