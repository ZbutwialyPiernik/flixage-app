import 'package:flixage/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BlocBuilder<B extends BaseBloc<S>, S> extends StatefulWidget {
  final B Function(BuildContext context) create;
  final Widget Function(BuildContext context, B bloc, AsyncSnapshot<S> state) builder;
  final void Function(BuildContext context, B bloc) onInit;

  const BlocBuilder({
    Key key,
    @required this.builder,
    this.create,
    this.onInit,
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

    if (widget.onInit != null) {
      widget.onInit(context, bloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      stream: bloc.state,
      builder: (context, snapshot) => widget.builder(context, bloc, snapshot),
    );
  }

  void dispose() {
    if (isLocal) {
      bloc?.dispose();
    }

    super.dispose();
  }
}
