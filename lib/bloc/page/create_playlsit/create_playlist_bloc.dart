import 'package:flixage/bloc/form_bloc.dart';
import 'package:flixage/bloc/page/library/library_bloc.dart';
import 'package:flixage/bloc/page/library/library_event.dart';
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
  Map<String, Validator> get validators => {
        'name': Validator.builder()
            .add((value) => value.isEmpty, "Name cannot be empty")
            .build(),
      };
}
