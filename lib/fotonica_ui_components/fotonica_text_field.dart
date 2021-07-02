import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FotonicaTextField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final Function onChange;
  final TextInputType type;
  final TextStyle textStyle;
  final TextStyle textStyleLabel;
  final InputBorder border;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final Function onTap;
  final bool readOnly;
  final Widget suffixIcon;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final bool filled;
  final Widget prefixIcon;
  final Widget suffix;
  final Function validator;
  final TextCapitalization textCapitalization;
  final bool autovalidade;
  final double radius;
  final List<TextInputFormatter> inputFormatters;
  final String hint;
  FocusNode focusNode;
  final Function(BuildContext,
      {int currentLength, bool isFocused, int maxLength}) buildCounter;
  final int maxLength;
  final String tooltipText;
  final TextInputAction textInputAction;
  final EdgeInsets contentPadding;
  final Function(String) onSubmitted;

  FotonicaTextField(
      {Key key,
      this.label,
      this.placeholder,
      this.onSubmitted,
      this.controller,
      this.autovalidade,
      this.onChange,
      this.type,
      this.textStyle,
      this.textStyleLabel,
      this.border,
      this.minLines,
      this.maxLines,
      this.onTap,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.filled = true,
      this.prefixIcon,
      this.suffix,
      this.validator,
      this.radius = 5.0,
      this.textCapitalization,
      this.edgeInsetsGeometry = EdgeInsets.zero,
      this.inputFormatters,
      this.hint,
      this.focusNode,
      this.buildCounter,
      this.maxLength,
      this.textInputAction,
      this.tooltipText,
      this.contentPadding})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FotonicaTextField();
  }
}

class _FotonicaTextField extends State<FotonicaTextField> {
  bool _textFieldFocus = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) widget.focusNode = FocusNode();

    widget.focusNode.addListener(() {
      setState(() {
        _textFieldFocus = !_textFieldFocus;
      });
    });
  }

  Widget buildLabel(BuildContext context) => widget.tooltipText != null
      ? Tooltip(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(8.0),
          message: widget.tooltipText ?? "Tooltip message not defined",
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.help,
                  size: 14.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        )
      : Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];

    if (widget.label != null) {
      content.add(buildLabel(context));
    }

    content.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          border: !_textFieldFocus
              ? Border.all(color: Colors.grey[200], width: 2)
              : Border.all(color: Colors.grey[300], width: 2),
        ),
        child: Row(children: [
          Expanded(
            child: TextFormField(
              autovalidate:
                  widget.autovalidade != null ? widget.autovalidade : false,
              readOnly: widget.readOnly,
              obscureText: widget.obscureText,
              controller: widget.controller,
              onChanged: widget.onChange,
              textCapitalization: widget.textCapitalization != null
                  ? widget.textCapitalization
                  : TextCapitalization.sentences,
              keyboardType:
                  widget.type != null ? widget.type : TextInputType.text,
              textInputAction: widget.textInputAction,
              onFieldSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                filled: widget.filled,
                fillColor: Colors.white,
                focusColor: Colors.white,
                // suffixIcon: suffixIcon,
                // suffix: suffixIcon,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: BorderSide(color: Theme.of(context).errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: BorderSide(color: Theme.of(context).errorColor),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none),
                contentPadding: widget.contentPadding != null
                    ? widget.contentPadding
                    : EdgeInsets.only(left: 16, top: 6, bottom: 6, right: 16),
                // labelText: placeholder,
                labelStyle: widget.textStyleLabel != null
                    ? widget.textStyleLabel
                    : TextStyle(color: Colors.grey[10]),
                hintText: widget.placeholder,
                hintMaxLines: widget.maxLines,
                hintStyle: widget.textStyleLabel != null
                    ? widget.textStyleLabel
                    : TextStyle(color: Colors.grey[10]),
              ),
              style: widget.textStyle,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              cursorWidth: 2.0,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLength,
              buildCounter: widget.buildCounter,
            ),
          ),
          if (widget.suffixIcon != null)
            Container(color: Colors.white, child: widget.suffixIcon)
        ]),
      ),
    );

    return Container(
      margin: widget.edgeInsetsGeometry != null
          ? widget.edgeInsetsGeometry
          : EdgeInsets.only(bottom: 8),
      child: Wrap(children: content),
    );
  }
}
