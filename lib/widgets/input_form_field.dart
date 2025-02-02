part of 'input_field.dart';

class _InputFormField extends FormField<String> {
  final TextEditingController controller;
  final Widget child;
  final String label;
  final TextStyle? labelStyle;
  final Color? borderColor;
  final Color? fillColor;
  final double borderRadius;
  final double? borderWidth;
  final EdgeInsets? contentPadding;
  final FocusNode focusNode;
  final double? height;
  final Future<bool> Function(String val)? validateCallback;
  final ValidatorIconPair validatorIconPair;
  final Rxn<ValidateState> validateState;
  final Widget? suffix;

  _InputFormField({
    required this.controller,
    required this.child,
    required this.label,
    this.borderColor,
    this.fillColor,
    required this.borderRadius,
    this.borderWidth,
    this.labelStyle,
    this.validateCallback,
    this.contentPadding,
    required this.focusNode,
    // ignore: unused_element
    this.validatorIconPair = defaultValidateIconPair,
    required this.validateState,
    this.height,
    this.suffix,
  }) : super(builder: (FormFieldState<String> field) {
          return GestureDetector(
            onTap: () {
              focusNode.requestFocus();
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 0,
                      right:
                          contentPadding?.right ?? _defaultContentPadding.right,
                      top: contentPadding?.top ?? 0,
                      bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(label,
                          fontSize: 12.sp, color: themeColor),
                      () {
                        return Obx(() {
                          if (validateState.value == null) {
                            return const SizedBox();
                          }
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget(
                                validateState.value!.message,
                                fontSize: 10.sp,
                                color: kWhite,
                              ),
                              const hSpace(10),
                              validatorIconPair[validateState.value!.status] ??
                                  const SizedBox()
                            ],
                          );
                        });
                      }.call()
                    ],
                  ),
                ),
                const vSpace(10),
                Container(
                  height: height ?? 56.h,
                  decoration: BoxDecoration(
                    color: fillColor ?? kWhite,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: borderColor ?? kBlack,
                        width: borderWidth ?? 1.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(child: child),
                          if (suffix != null)
                            Padding(
                              padding: EdgeInsets.only(
                                  right: contentPadding?.right ??
                                      _defaultContentPadding.right,
                                  bottom: contentPadding?.bottom ??
                                      _defaultContentPadding.bottom),
                              child: suffix,
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });

  @override
  FormFieldState<String> createState() => _InputFormFieldState();

  static const ValidatorIconPair defaultValidateIconPair = {
    ValidateStatus.valid:
        SvgIcon('assets/svg/val_success_icon.svg', size: 12.95),
    ValidateStatus.error: SvgIcon('assets/svg/val_error_icon.svg', size: 12.95),
  };
}

class _InputFormFieldState extends FormFieldState<String> {
  _InputFormField get _formField => super.widget as _InputFormField;

  @override
  bool validate() {
    _formField.validateCallback?.call(_formField.controller.text);
    return _formField.validateState.value?.status != ValidateStatus.error;
  }
}

typedef SValidator = FutureOr<(ValidateStatus, String)?> Function(String value);
typedef SValidatorStatus = (ValidateStatus, String)?;
typedef FutureSValidator = Future<(ValidateStatus, String)?> Function(
    String value);
typedef ValidatorIconPair = Map<ValidateStatus, Widget>;

enum ValidateStatus {
  valid,
  error,
  none,
}

class ValidateState {
  ValidateState(this.status, this.message);
  final ValidateStatus status;
  final String message;
}
