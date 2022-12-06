
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/domain/order/entities/service.dart';
import 'package:gulf_sky_provider/injection.dart';
import 'package:gulf_sky_provider/presentation/core/blocs/core/base_state.dart';
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
          return Builder(
            builder: (context) {
              if(state.item!=null){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.57,
                    child: Text(
                      state.item!.name?.toString() ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child:  SizedBox(
                      width: MediaQuery.of(context).size.width*0.57,
                      child: Text(
                        state.item!.description?.toString() ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              );} else{
                return const SizedBox.shrink();
              }
            }
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
