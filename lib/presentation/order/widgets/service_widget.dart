import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/custom_text_rich_widget.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/error_view.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/service_by_id_bloc/service_by_id_bloc.dart';

class ServiceWidget extends StatefulWidget {
  final int serviceId;

  const ServiceWidget({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  final ServiceByIdListBloc _serviceByIdListBloc = getIt<ServiceByIdListBloc>();

  @override
  void initState() {
    _serviceByIdListBloc.add(ServiceByIdRequested(
      id: widget.serviceId,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceByIdListBloc, BaseState<Service>>(
      bloc: _serviceByIdListBloc,
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
                  _serviceByIdListBloc.add(ServiceByIdRequested(
                    id: widget.serviceId,
                  ));
                },
              ),
            ),
          );
        }
        if (state.isSuccess) {
          return Builder(builder: (context) {
            if (state.item != null) {
              return CustomTextRickWidget(
                  title: 'service'.tr(),
                  description:
                      state.item!.description?.toString() ?? '');
            } else {
              return const SizedBox.shrink();
            }
          });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
