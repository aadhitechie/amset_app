import 'dart:async';

import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/utils/debouncer.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';



part 'input_form_field.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      this.controller,
      this.autofocus,
      this.textInputAction,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.inputType,
      this.cursorColor,
      this.validator,
      this.maxLength,
      this.minLines,
      this.maxLines = 1,
      this.textStyle,
      this.inputFormatters,
      this.prefix,
      this.hintText,
      this.hintStyle,
      this.showCounter = false,
      this.fillColor,
      this.suffix,
      this.focusNode,
      this.readOnly = false,
      this.borderColor,
      this.borderType,
      this.borderRadius = 4.0,
      this.borderWidth,
      this.isDense,
      this.contentPadding,
      this.label,
      this.sValidator,
      this.labelStyle,
      this.sValidateDelay = 0,
      this.height,
      this.textAlign,
      this.focusBorderColor,
      this.alignLabelWithHint,
      this.floatingLabelBehavior,
      this.labelBottomHeight,
      this.suffixIconTransform,
      this.onTapOutSide,
      this.sValidatorIconPair,
      this.capitalizeFirst})
      : isSearch = false,
        onSearch = null,
        funSuffixIcon = null,
        searchOnTextChange = false,
        isPassword = false,
        debounceDelay = null;

  const InputField.password({
    super.key,
    this.controller,
    this.autofocus,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputType,
    this.cursorColor,
    this.validator,
    this.maxLength,
    this.minLines,
    this.textStyle,
    this.readOnly = false,
    this.inputFormatters,
    this.prefix,
    this.hintText,
    this.hintStyle,
    this.showCounter = false,
    this.fillColor,
    this.focusNode,
    this.borderColor,
    this.borderType,
    this.borderRadius = 4.0,
    this.borderWidth,
    this.isDense,
    this.contentPadding,
    this.label,
    this.sValidator,
    this.labelStyle,
    this.sValidateDelay = 0,
    this.height,
    this.textAlign,
    this.focusBorderColor,
    this.alignLabelWithHint,
    this.floatingLabelBehavior,
    this.labelBottomHeight,
    this.suffixIconTransform,
    this.onTapOutSide,
    this.sValidatorIconPair,
    this.capitalizeFirst = false,
  })  : isSearch = false,
        suffix = null,
        funSuffixIcon = null,
        isPassword = true,
        onSearch = null,
        searchOnTextChange = false,
        maxLines = 1,
        debounceDelay = null;

  const InputField.search({
    super.key,
    this.controller,
    this.autofocus,
    this.onEditingComplete,
    this.inputType,
    this.cursorColor,
    this.validator,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.textStyle,
    this.inputFormatters,
    this.prefix,
    this.hintText,
    this.hintStyle,
    this.showCounter = false,
    this.fillColor,
    this.readOnly = false,
    required this.onSearch,
    this.onChanged,
    bool searchOnChange = true,
    Widget? searchIcon,
    this.focusNode,
    this.debounceDelay = 400,
    this.borderColor,
    this.borderType,
    this.borderRadius = 4.0,
    this.borderWidth,
    this.isDense,
    this.searchOnTextChange = true,
    this.contentPadding,
    this.label,
    this.sValidator,
    this.labelStyle,
    this.sValidateDelay = 0,
    this.height,
    this.labelBottomHeight,
    this.textAlign,
    this.focusBorderColor,
    this.alignLabelWithHint,
    this.floatingLabelBehavior,
    this.suffixIconTransform,
    this.onTapOutSide,
    this.sValidatorIconPair,
    this.capitalizeFirst = false,
  })  : isPassword = false,
        isSearch = true,
        funSuffixIcon = searchIcon,
        textInputAction = TextInputAction.search,
        suffix = null,
        onSubmitted = onSearch;

  final TextEditingController? controller;
  final String? label;
  final bool isPassword;
  final bool isSearch;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final Color? cursorColor;
  final int? maxLength;
  final int? minLines;
  final int maxLines;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool? alignLabelWithHint;
  final bool showCounter;
  final bool? isDense;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderWidth;
  final double borderRadius;
  final Widget? funSuffixIcon;
  final bool readOnly;
  final double? height;
  final EdgeInsets? contentPadding;
  final InputFieldBorderType? borderType;
  final TextAlign? textAlign;
  final bool? capitalizeFirst;
  final Transform Function(Widget child)? suffixIconTransform;
  final Color? focusBorderColor;
  final Function(PointerEvent event)? onTapOutSide;
  //for search
  final bool searchOnTextChange;
  final int? debounceDelay;
  final void Function(String query)? onSearch;
  final FloatingLabelBehavior? floatingLabelBehavior;

  //InputFormField
  final SValidator? sValidator;
  final int sValidateDelay;
  final ValidatorIconPair? sValidatorIconPair;

  //
  final double? labelBottomHeight;

  @override
  State<InputField> createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  bool showPassword = false;
  late FocusNode focusNode;
  late TextEditingController controller;
  Debouncer? debouncer;
  ValueChanged<String>? onChanged;
  late InputBorder border;
  late InputFieldBorderType borderType;
  Rxn<ValidateState> validateState = Rxn();
  EdgeInsets? contentPadding;
  String label = '';

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    label = widget.label ?? 'empty';
    initialize();
  }

  @override
  void didChangeDependencies() {
    initialize(isUpdate: true);
    super.didChangeDependencies();
  }

  // @override
  // void didUpdateWidget(covariant InputField oldWidget) {
  //   if (oldWidget.borderType != widget.borderType ||
  //       oldWidget.borderColor != widget.borderColor) {
  //     initialize(isUpdate: true);
  //     setState(() {});
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  initialize({bool isUpdate = false}) {
    contentPadding = widget.contentPadding;
    border = getBorder();

    if (borderType.isExternal && widget.sValidator != null) {
      debouncer = Debouncer(milliseconds: widget.sValidateDelay);
      onChanged = (val) {
        widget.onChanged?.call(val);
        debouncer!.run(() => validateSValidator(val));
      };
    } else if (widget.searchOnTextChange) {
      debouncer = Debouncer(milliseconds: widget.debounceDelay!);
      onChanged = (value) {
        widget.onChanged?.call(value);

        debouncer!.run(() {
          widget.onSearch?.call(value);
        });
      };
    }
    if (borderType.isExternal && widget.contentPadding != null) {
      contentPadding = contentPadding!.copyWith(top: widget.labelBottomHeight);
    }
  }

  Future<bool> validateSValidator(String val) async {
    handleStatus((ValidateStatus, String)? status) {
      if (status == null) {
        validateState.value = null;
        return false;
      }
      validateState.value = ValidateState(status.$1, status.$2);
      return status.$1 != ValidateStatus.error;
    }

    var validator = widget.sValidator!;
    var call = validator(val);
    if (call is Future) {
      (validator as FutureSValidator).call(val).then(handleStatus);
    } else {
      handleStatus(call);
    }
    return true;
  }

  @override
  void dispose() {
    if (widget.controller == null) widget.controller?.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Row(children: [
      Expanded(
        child: TextFormField(
          textAlign: widget.textAlign ?? TextAlign.left,
          keyboardType: widget.inputType,
          controller: controller,
          autofocus: widget.autofocus ?? false,
          cursorColor: widget.cursorColor,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword && !showPassword,
          obscuringCharacter: '●',
          onChanged: onChanged ?? widget.onChanged,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          textCapitalization: widget.capitalizeFirst ??
                  (!widget.isPassword ||
                      !widget.isSearch ||
                      widget.inputType != TextInputType.emailAddress)
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          validator: widget.validator,
          style: widget.textStyle,
          focusNode: focusNode,
          onTapOutside: widget.onTapOutSide ?? (event) => focusNode.unfocus(),
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
              border: border,
              enabledBorder: border.copyWith(
                  borderSide:
                      BorderSide(color: (widget.borderColor ?? themeColor))),
              errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.red)),
              focusedBorder: border.copyWith(
                  borderSide: BorderSide(
                      color: widget.focusBorderColor ??
                          widget.borderColor ??
                          themeColor)),
              prefix: widget.prefix,
              label: widget.label != null && !borderType.isExternal
                  ? TextWidget(widget.label!)
                  : null,
              labelStyle: widget.labelStyle,
              filled: widget.fillColor != null,
              suffixIcon: !borderType.isExternal ? getSuffixIcon() : null,
              fillColor: widget.fillColor,
              isDense: widget.isDense ?? true,
              alignLabelWithHint: widget.alignLabelWithHint,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              contentPadding: contentPadding ?? _defaultContentPadding,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              counterText: !widget.showCounter ? '' : null),
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ),
      if (borderType.isExternal) ...[
        const hSpace(8),
        getSuffixIcon() ?? const SizedBox(),
        SizedBox(
          width: contentPadding?.right ?? _defaultContentPadding.right,
        )
      ],
    ]);
    if (borderType.isExternal) {
      child = _InputFormField(
        controller: controller,
        label: widget.label ?? '',
        borderRadius: widget.borderRadius,
        borderColor: widget.borderColor,
        borderWidth: widget.borderWidth,
        fillColor: widget.fillColor,
        labelStyle: widget.labelStyle,
        validateState: validateState,
        validateCallback: widget.sValidator != null ? validateSValidator : null,
        validatorIconPair: widget.sValidatorIconPair ??
            _InputFormField.defaultValidateIconPair,
        focusNode: focusNode,
        contentPadding: widget.contentPadding,
        height: widget.height,
        suffix: widget.suffix,
        child: child,
      );
    } else {
      child = SizedBox(
        height: widget.height,
        child: child,
      );
    }
    return child;
  }

  Widget? getSuffixIcon() {
    var icon = widget.isPassword
        ? passwordEye()
        : widget.isSearch
            ? searchButton()
            : !borderType.isExternal
                ? widget.suffix
                : null;
    if (icon == null) return null;
    if (widget.suffixIconTransform != null) {
      icon = widget.suffixIconTransform!.call(icon);
    }
    return icon;
  }

  InputBorder getBorder() {
    var borderSide = BorderSide(
        color: widget.borderColor ?? themeColor,
        width: widget.borderWidth ?? 1.0);
    borderType = widget.borderType ?? InputFieldBorderType.outlined;

    return switch (borderType) {
      InputFieldBorderType.none ||
      InputFieldBorderType.external =>
        InputBorder.none,
      InputFieldBorderType.outlined => OutlineInputBorder(
          borderSide: borderSide,
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      InputFieldBorderType.underlined => UnderlineInputBorder(
          borderSide: borderSide,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius)),
        )
    };
  }

  Widget searchButton() {
    return widget.funSuffixIcon != null
        ? GestureDetector(
            onTap: () => widget.onSearch!.call(controller.text),
            child: widget.funSuffixIcon)
        : IconButton(
            onPressed: () => widget.onSearch!.call(controller.text),
            icon: const Icon(Icons.search),
          );
  }

  Widget passwordEye() {
    return IconButton(
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        splashRadius: 5,
        onPressed: () {
          setState(() => showPassword = !showPassword);
        },
        icon: Icon(
            showPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 18));
  }
}

const _defaultContentPadding =
    EdgeInsets.symmetric(vertical: 0, horizontal: 16);

enum InputFieldBorderType {
  none,
  outlined,
  underlined,
  external;

  bool get isExternal => this == InputFieldBorderType.external;
}
