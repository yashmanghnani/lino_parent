import 'package:lino_parents/src/Model/Request/login_req.dart';
import 'package:lino_parents/src/Model/Response/login_res.dart';
import 'package:lino_parents/src/Model/repository.dart';
import 'package:state_extended/state_extended.dart';

class AllController extends StateXController {
  late AuthRepository _repo;

  AllController() {
    _repo = AuthRepository();
  }

  Future<LoginResponse> login({
    required String mobile,
    required String password,
  }) async {
    final request = LoginRequest(
      mobile: mobile,
      password: password,
    );

    return await _repo.login(request);
  }
}
