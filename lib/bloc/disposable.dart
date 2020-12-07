import 'package:meta/meta.dart';

abstract class Disposable {
  void dispose();
}

abstract class DisposableParent implements Disposable {
  final List<Disposable> _disposables = List();

  @protected
  void addDisposable(Disposable disposable) => _disposables.add(disposable);

  @mustCallSuper
  @override
  void dispose() => _disposables.forEach((element) => element.dispose());
}
