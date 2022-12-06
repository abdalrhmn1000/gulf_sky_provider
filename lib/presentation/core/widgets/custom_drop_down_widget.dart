import 'package:flutter/material.dart';

typedef OnDisableClicked = void Function();
typedef OnRetry = void Function();

class CustomDropDownWidget<T> extends StatelessWidget {
  final String? hint;
  final List<T>? options;
  final Function(T)? onChange;
  final bool? showError;
  final String? messageError;
  final bool? isLoading;
  final bool? showRetryIcon;
  final OnRetry? onRetry;
  final double? hintWidth;
  final bool? disabled;
  final OnDisableClicked? onDisableClicked;
  final T? selectedOption;
  final Color? borderColor;
  final String label;

  const CustomDropDownWidget({
    Key? key,
    required this.label,
    this.hint,
    required this.options,
    required this.onChange,
    this.showError = false,
    this.messageError = '',
    this.isLoading = false,
    this.borderColor,
    this.showRetryIcon = false,
    this.disabled = false,
    required this.onRetry,
    this.hintWidth,
    this.onDisableClicked,
    this.selectedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (T == String) options!.removeAt(0);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (disabled!) {
              onDisableClicked!();
            }
          },
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              filled: true,
              label: Text(label),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            hint: hint != null
                ? Text(
                    hint!,
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme.secondary

                    ),
                  )
                : const SizedBox(),
            iconSize: 20.0,
            icon: isLoading!
                ? const SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                    ),
                  )
                : const Icon(Icons.keyboard_arrow_down),
            value: selectedOption,
            items: options!.map<DropdownMenuItem<T>>((option) {
              return DropdownMenuItem<T>(
                value: option,
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: hintWidth,
                  child: Text(
                    getTitle(option),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // style: const TextStyle(
                    //   fontSize: Dimensions.largeText,
                    // ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (disabled == null || disabled == false)
                ? (val) => onChange!(val as T)
                : (item) {},
          ),
        ),
        showError!
            ? const SizedBox(
                height: 3.0,
              )
            : Container(),
        showError!
            ? Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    onRetry!();
                  },
                  child: Row(
                    children: [
                      Text(
                        messageError!,
                        style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      showRetryIcon!
                          ? Icon(
                              Icons.refresh,
                              color: Theme.of(context).errorColor,
                              size: 16.0,
                            )
                          : Container()
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  String getTitle(T item) {
    return item.toString();
  }
}
