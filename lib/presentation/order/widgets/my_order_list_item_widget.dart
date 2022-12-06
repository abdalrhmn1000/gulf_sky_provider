import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/error_view.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_loader.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/screen_utils.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/shimmer.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/my_order_list_bloc/my_order_list_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/order.dart' as order;
import 'package:gulf_sky_provider/presentation/order/widgets/order_details_list_item_widget.dart';

class MyOrderListItemWidget extends StatefulWidget {
  const MyOrderListItemWidget({Key? key}) : super(key: key);

  @override
  State<MyOrderListItemWidget> createState() => _MyOrderListItemWidgetState();
}

class _MyOrderListItemWidgetState extends State<MyOrderListItemWidget>
    with ScreenUtils<MyOrderListItemWidget>, ScreenLoader {
  final MyOrderListBloc _myOrderListBloc = getIt<MyOrderListBloc>();

  @override
  void initState() {
    _myOrderListBloc.add(MyOrderListRequested());
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.background,
      onRefresh: () async {
        _myOrderListBloc.add(MyOrderListRequested());
      },
      child: BlocBuilder<MyOrderListBloc, BaseState<List<order.Order>>>(
        bloc: _myOrderListBloc,
        builder: (context, state) {
          if (state.isInProgress) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: ListView.builder(
                  itemCount: 15,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const ShimmerWidget(
                      width: double.infinity,
                      height: 120,
                      marginButton: 8,
                    );
                  }),
            );
          } else if (state.isFailure) {
            return SizedBox(
              height: 160,
              child: Center(
                child: ErrorView(
                  failure: state.failure,
                  onRetry: () {
                    _myOrderListBloc.add(MyOrderListRequested());
                  },
                ),
              ),
            );
          }
          if (state.item?.isNotEmpty ?? false) {
            return ListView.builder(
                itemCount: state.item!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderDetailsListItemWidget(
                    order: state.item![index],
                    onEdit: () {
                      _myOrderListBloc.add(MyOrderListRequested());
                    },
                  );
                });
          } else {
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.only(right: 4.0, left: 3.0),
                  minWidth: 40,
                  height: 40,
                  color: Theme.of(context).cardColor,
                  onPressed: () {
                    _myOrderListBloc.add(MyOrderListRequested());
                  },
                  child: const Icon(
                    Icons.refresh_rounded,
                    //  color: Theme.of(context).iconTheme.color,
                    size: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('no_data'.tr()),
              ],
            ));
          }
        },
      ),
    );
  }
}
