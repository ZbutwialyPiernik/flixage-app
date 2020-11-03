import 'package:meta/meta.dart';

abstract class Disposable {
  void dispose();
}

abstract class DisposableParent implements Disposable {
  List<Disposable> _disposables;

  @protected
  void addDisable(Disposable disposable) => _disposables.add(disposable);

  @mustCallSuper
  void dipose() => _disposables.forEach((element) => element.dispose());
}
