import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/order_details.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/routes/router.dart';
import 'package:gulf_sky_provider/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_text_rich_widget.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/error_view.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/shimmer.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/building_list_bloc/building_list_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/order_details_bloc/order_details_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/supervisor_list_bloc/supervisor_list_bloc.dart';
import 'package:gulf_sky_provider/presentation/order/widgets/service_widget.dart';
import 'package:gulf_sky_provider/presentation/order/widgets/sub_service_widget.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as or;

class OrderDetailsListItemWidget extends StatefulWidget {
  final or.Order order;
  final void Function() onEdit;

  const OrderDetailsListItemWidget({
    Key? key,
    required this.order,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<OrderDetailsListItemWidget> createState() =>
      _OrderDetailsListItemWidgetState();
}

class _OrderDetailsListItemWidgetState
    extends State<OrderDetailsListItemWidget> {
  final OrderDetailsListBloc _orderDetailsListBloc =
      getIt<OrderDetailsListBloc>();

  @override
  void initState() {
    _orderDetailsListBloc.add(OrderDetailsRequested(
      orderId: widget.order.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsListBloc, BaseState<List<OrderDetails>>>(
      bloc: _orderDetailsListBloc,
      builder: (context, state) {
        if (state.isInProgress) {
          return const ShimmerWidget(
            width: double.infinity,
            height: 120,
          );
        } else if (state.isFailure) {
          return SizedBox(
            height: 160,
            child: Center(
              child: ErrorView(
                failure: state.failure,
                onRetry: () {
                  _orderDetailsListBloc.add(OrderDetailsRequested(
                    orderId: widget.order.id,
                  ));
                },
              ),
            ),
          );
        }
        if (state.item?.isNotEmpty ?? false) {
          return Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 16,
              right: 16,
            ),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) {
                          return Assets.images.logo.image(
                            width: 40,
                            height: 40,
                          );
                        },
                        placeholder: (context, s) => const Loader(),
                        imageUrl: state.item![0].image ?? '',
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextRickWidget(
                            title: 'name'.tr(),
                            description: widget.order.name ?? ''),
                        CustomTextRickWidget(
                            title: 'date'.tr(),
                            description: widget.order.date ?? ''),
                        CustomTextRickWidget(
                            title: 'time'.tr(),
                            description: widget.order.time ?? ''),
                        if (widget.order.isTanent != null)
                          CustomTextRickWidget(
                              title: 'tenant'.tr(),
                              description: widget.order.isTanent == 0
                                  ? 'no'.tr()
                                  : 'yes'.tr()),
                        if (BlocProvider.of<BuildingListBloc>(context)
                            .state
                            .isSuccess)
                          CustomTextRickWidget(
                              title: 'building'.tr(),
                              description: BlocProvider.of<BuildingListBloc>(
                                          context)
                                      .state
                                      .item
                                      ?.firstWhere((element) =>
                                          element.id == widget.order.buildingId)
                                      .name ??
                                  ''),
                        if (widget.order.roomNumber != null)
                          CustomTextRickWidget(
                              title: 'room_number'.tr(),
                              description: widget.order.roomNumber ?? ''),
                        if (widget.order.taxNumber != null)
                          CustomTextRickWidget(
                              title: 'tax_number'.tr(),
                              description: widget.order.taxNumber ?? ''),
                        if (widget.order.priority != null)
                          CustomTextRickWidget(
                              title: 'priority'.tr(),
                              description: widget.order.priority ?? ''),
                        CustomTextRickWidget(
                            title: 'created_at'.tr(),
                            description: DateFormat('yyyy-MM-dd hh:mm a')
                                .format(state.item![0].createdAt!)),
                        if (widget.order.orderNumber != null)
                          CustomTextRickWidget(
                              title: 'order_number'.tr(),
                              description: widget.order.orderNumber ?? ''),
                        if (widget.order.totalPrice != null)
                          CustomTextRickWidget(
                              title: 'total_price'.tr(),
                              description:
                                  widget.order.totalPrice?.toString() ?? ''),
                        if (widget.order.isDraft != null)
                          CustomTextRickWidget(
                              title: 'is_draft'.tr(),
                              description: widget.order.isDraft == 0
                                  ? 'no'.tr()
                                  : 'yes'.tr()),
                        if (widget.order.notes != null)
                          CustomTextRickWidget(
                              title: 'notes'.tr(),
                              description: widget.order.notes ?? ''),
                        if (widget.order.status != null)
                          CustomTextRickWidget(
                              title: 'status'.tr(),
                              description: widget.order.status ?? ''),
                        if (BlocProvider.of<SupervisorListBloc>(context)
                            .state
                            .isSuccess)
                          CustomTextRickWidget(
                              title: 'user'.tr(),
                              description:
                                  BlocProvider.of<SupervisorListBloc>(context)
                                          .state
                                          .item
                                          ?.firstWhere((element) =>
                                              element.id == widget.order.userId)
                                          .fullName ??
                                      ''),
                        if (widget.order.isRepeated != null)
                          CustomTextRickWidget(
                              title: 'is_repeated'.tr(),
                              description: widget.order.isRepeated == 0
                                  ? 'no'.tr()
                                  : 'yes'.tr()),
                        CustomTextRickWidget(
                            title: 'address'.tr(),
                            description: widget.order.address ?? ''),
                        if (state.item![0].servicesId != null)
                          ServiceWidget(serviceId: state.item![0].servicesId!),
                        if (state.item![0].subServiceId != null)
                          SubServiceWidget(
                              subServiceId: state.item![0].subServiceId!),
                        CustomTextRickWidget(
                            title: 'price'.tr(),
                            description:
                                state.item![0].price?.toString() ?? ''),
                        if (state.item![0].duration != null)
                          CustomTextRickWidget(
                              title: 'duration'.tr(),
                              description:
                                  state.item![0].duration?.toString() ?? ''),
                      ],
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    //height: 100,
                    child: IconButton(
                        onPressed: () {
                          AutoRouter.of(context)
                              .push(EditOrderPageRoute(
                                  order: widget.order,
                                  orderDetails: state.item![0]))
                              .then((value) {
                            if (value != null && (value as bool) == true) {
                              widget.onEdit();
                            }
                          });
                        },
                        icon: const Icon(Icons.edit)))
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
