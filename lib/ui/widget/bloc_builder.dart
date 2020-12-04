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
  State<StatefulWidget> createState() => BlocBuilderState<B, S>();
}

class BlocBuilderState<B extends BaseBloc<S>, S> extends State<BlocBuilder<B, S>> {
  B _bloc;
  bool _isLocal;

  B get bloc => _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _isLocal = widget.create != null;

    _bloc = _isLocal ? widget.create(context) : Provider.of<B>(context);

    if (widget.onInit != null) {
      widget.onInit(context, _bloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      stream: _bloc.state,
      builder: (context, snapshot) => widget.builder(context, _bloc, snapshot),
    );
  }

  void dispose() {
    if (_isLocal) {
      _bloc?.dispose();
    }

    super.dispose();
  }
}
