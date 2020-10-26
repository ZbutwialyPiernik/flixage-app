import 'package:flixage/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BlocBuilder<B extends BaseBloc<S>, S> extends StatefulWidget {
  final B Function(BuildContext context) create;
  final Widget Function(BuildContext context, AsyncSnapshot<S> state) builder;
  final Function(BuildContext context, B bloc) init;

  const BlocBuilder({
    Key key,
    @required this.builder,
    this.create,
    this.init,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocBuilderState<B, S>();
}

class _BlocBuilderState<B extends BaseBloc<S>, S> extends State<BlocBuilder<B, S>> {
  B bloc;
  bool isLocal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    isLocal = widget.create != null;

    bloc = isLocal ? widget.create(context) : Provider.of<B>(context);

    if (widget.init != null) {
      widget.init(context, bloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      stream: bloc.state,
      builder: widget.builder,
    );
  }

  void dispose() {
    if (isLocal) {
      bloc?.dispose();
    }

    super.dispose();
  }
}
