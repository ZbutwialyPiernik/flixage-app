import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/util/validation/validator.dart';

class CreatePlaylistBloc extends FormBloc {
  final LibraryBloc libraryBloc;

  CreatePlaylistBloc(this.libraryBloc);

  @override
  Future<FormBlocState> onValid(SubmitForm event) async {
    libraryBloc.dispatch(CreatePlaylist(name: event.fields['name']));

    return FormSubmitSuccess();
  }

  @override
  List<FormBlocField> get fields => [
        FormBlocField(
            key: 'name',
            label: S.current.createPlaylistPage_namePlaylist,
            validator: Validator.builder()
                .add((value) => value.isEmpty, "Name cannot be empty")
                .build())
      ];
}
