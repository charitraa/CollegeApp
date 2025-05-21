import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lbef/model/TaxModel.dart';
import 'package:lbef/model/credit_note_model.dart';
import 'package:lbef/model/statement.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/repository/daily_class_repository/daily_class_repository.dart';
import 'package:lbef/repository/fees_repository/fees_repository.dart';
import 'package:logger/logger.dart';
import '../../data/api_response.dart';
import '../../model/balance_model.dart';
import '../../utils/utils.dart';

class CollegeFeeViewModel with ChangeNotifier {
  var logger = Logger();
  final FeesRepository _myrepo = FeesRepository();
  final List<StatementModel> _statementList = [];
  final List<CreditNoteModel> _creditList = [];
  final List<TaxModel> _taxList = [];
  ApiResponse<BalanceModel> userData = ApiResponse.loading();
  bool _isLoading = false;

  int _currentPage = 1;
  int _limit = 10;
  int get totalPages => (_statementList.length / _limit).ceil();
  bool get isLoading => _isLoading;
  BalanceModel? get currentUser => userData.data;
  List<StatementModel> get statementList => _statementList;
  List<CreditNoteModel> get creditList => _creditList;
  List<TaxModel> get taxList => _taxList;
  int get currentPage => _currentPage;
  void goToPage(int index) {
    if (index >= 0 && index < totalPages) {
      _currentPage = index;
      notifyListeners();
    }
  }

  void nextPage(BuildContext context) {
    if (_currentPage < totalPages - 1) {
      _currentPage++;
      loadMore(context);
      notifyListeners();
    }
  }

  void previousPage(BuildContext context) {
    if (_currentPage > 0) {
      _currentPage--;
      loadMore(context);
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  //setBalance
  void setBalance(ApiResponse<BalanceModel> response) {
    userData = response;
    Future.microtask(() => notifyListeners());
  }

  //statements
  Future<void> fetchStatement(BuildContext context) async {
    if (_isLoading) return;
    setLoading(true);
    try {
      _currentPage = 1;
      _statementList.clear();
      final Map<String, dynamic> response =
          await _myrepo.getStatements(1, _limit, context);
      _statementList.addAll(response['statements']);
      if (response['statements'] != [] && response['statements'] != null) {
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data s: $error", context);
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadMore(BuildContext context) async {
    try {
      final Map<String, dynamic> response =
          await _myrepo.getStatements(_currentPage, _limit, context);
      if (response['statements'] != []&& response['statements'] != null) {
        _statementList.addAll(response['statements']);
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }

  //Receipts
  Future<void> fetchReceipts(BuildContext context) async {
    try {
      final Map<String, dynamic> response = await _myrepo.getReceipts(context);
      if (response['receipts'] != []&& response['statements'] != null) {
        _taxList.addAll(response['receipts']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }

  //Receipts
  Future<void> fetchCredits(BuildContext context) async {
    try {
      final Map<String, dynamic> response = await _myrepo.getCredits(context);
      if (response['credits'] != []&& response['statements'] != null) {
        _creditList.addAll(response['credits']);
        _currentPage++;
      }
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage("Error fetching data: $error", context);
    }
  }

  //Get Balance
  Future<void> getBalance(BuildContext context) async {
    setLoading(true);
    setBalance(ApiResponse.loading());
    try {
      BalanceModel balance = await _myrepo.getBalance(context);
      if (kDebugMode) {
        logger.d('Balance data: ${balance.toJson()}');
      }
      setBalance(ApiResponse.completed(balance));
    } catch (e) {
      setBalance(ApiResponse.error(e.toString()));
    } finally {
      setLoading(false);
    }
  }
}
