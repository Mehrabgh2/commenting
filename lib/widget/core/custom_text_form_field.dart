import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    required this.setter,
    required this.require,
    this.minChars,
    this.maxChars,
    this.focusNode,
    this.title = '',
    this.hint = '',
    this.isLink = false,
    this.isNumber = false,
  }) : super(key: key);

  final int? minChars;
  final int? maxChars;
  final bool require;
  final bool isLink;
  final bool isNumber;
  final String title;
  final String hint;
  final Function setter;
  final FocusNode? focusNode;
  final _CustomTextFormFieldState customTextFormFieldState =
      _CustomTextFormFieldState();

  void clear() => customTextFormFieldState.clear();

  @override
  State<CustomTextFormField> createState() => customTextFormFieldState;
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late final TextEditingController _controller = TextEditingController()
    ..text = widget.title;

  void clear() => _controller.clear();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          focusNode: widget.focusNode,
          autofocus: true,
          textAlign: TextAlign.right,
          controller: _controller,
          style: TextStyle(color: Theme.of(context).hoverColor),
          keyboardType:
              widget.isNumber ? TextInputType.number : TextInputType.multiline,
          decoration: InputDecoration(
            suffixIcon: widget.isNumber
                ? null
                : IconButton(
                    onPressed: () {
                      Clipboard.getData(Clipboard.kTextPlain).then((value) {
                        _controller.text =
                            value != null ? value.text ?? '' : '';
                        widget.setter(_controller.text);
                      });
                    },
                    icon: Icon(
                      Icons.paste,
                      color: Theme.of(context).hoverColor,
                    ),
                  ),
            labelText: widget.hint,
            labelStyle: TextStyle(color: Theme.of(context).hoverColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).hoverColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).hoverColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).hoverColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).hoverColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).hoverColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).hoverColor,
              ),
            ),
          ),
          onChanged: (newValue) {
            if (widget.isNumber || widget.isLink) {
              widget.setter(newValue);
            }
          },
          onSaved: (value) => widget.setter(value),
          validator: (value) {
            if (value != null) {
              if (value.isEmpty && widget.require) {
                return 'این فیلد را پر کنید';
              }
              if (!value.startsWith('http') && widget.isLink) {
                return 'آدرس صحبح وارد کنید';
              }
              if (widget.minChars != null) {
                if (value.length < widget.minChars!) {
                  return 'حداقل کارکتر مجاز ${widget.minChars}';
                }
              }
              if (widget.maxChars != null) {
                if (value.length > widget.maxChars!) {
                  return 'حداکثر کارکتر مجاز ${widget.maxChars}';
                }
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
