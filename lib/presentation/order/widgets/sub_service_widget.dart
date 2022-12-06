
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
import 'package:gulf_sky_provider/presentation/core/widgets/error_view.dart';
import 'package:gulf_sky_provider/presentation/order/blocs/sub_service_by_id_bloc/sub_service_by_id_bloc.dart';

class SubServiceWidget extends StatefulWidget {
  final int subServiceId;

  const SubServiceWidget({
    Key? key,
    required this.subServiceId,
  }) : super(key: key);

  @override
  State<SubServiceWidget> createState() => _SubServiceWidgetState();
}

class _SubServiceWidgetState extends State<SubServiceWidget> {
  final SubServiceByIdListBloc _subServiceByIdListBloc =
      getIt<SubServiceByIdListBloc>();

  @override
  void initState() {
    _subServiceByIdListBloc.add(SubServiceByIdRequested(
      id: widget.subServiceId,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubServiceByIdListBloc, BaseState<Service>>(
      bloc: _subServiceByIdListBloc,
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
                  _subServiceByIdListBloc.add(SubServiceByIdRequested(
                    id: widget.subServiceId,
                  ));
                },
              ),
            ),
          );
        }
        if (state.isSuccess) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.57,
            child: Text(
              state.item?.name?.toString() ?? '',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
