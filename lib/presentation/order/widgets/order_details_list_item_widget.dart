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
import 'package:gulf_sky_provider/presentation/core/widgets/error_view.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/shimmer.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/order_details_bloc/order_details_bloc.dart';
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
                        if (state.item![0].servicesId != null)
                          ServiceWidget(serviceId: state.item![0].servicesId!),
                        if (state.item![0].subServiceId != null)
                          SubServiceWidget(
                              subServiceId: state.item![0].subServiceId!),
                        Text(
                          state.item![0].price?.toString() ?? '',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd hh:mm a')
                              .format(state.item![0].createdAt!),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
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
                          AutoRouter.of(context).push(EditOrderPageRoute(
                              order: widget.order,
                              orderDetails: state.item![0])).then((value) {
                                if((value as bool)==true){
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
