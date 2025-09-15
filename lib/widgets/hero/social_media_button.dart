import 'package:flutter/material.dart';

class SocialMediaButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback onTap;
  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: isHovered ? 0.3 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
          onTap: widget.onTap,
          onHover: (value) {
            setState(() {
              isHovered = value;
            });
          },
          onLongPress: () {
            setState(() {
              isHovered = true;
            });
          },
          child: Center(
            child: SizedBox(
              height: isHovered ? 40 : 35,
              width: isHovered ? 40 : 35,
              child: widget.icon,
            ),
          )),
    );
  }
}
