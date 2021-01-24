part of 'helpers.dart';

navegarMapaFadeIn(BuildContext context, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        page,
    transitionDuration: Duration(milliseconds: 1000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut)));
    },
  );
}
