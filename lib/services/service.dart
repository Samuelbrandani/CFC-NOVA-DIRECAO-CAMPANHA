import 'package:cfc_nova_direcao_campanha/config.dart';
import 'package:cfc_nova_direcao_campanha/model/aulas-direcao.dart';
import 'package:cfc_nova_direcao_campanha/model/exame-direcao.dart';
import 'package:cfc_nova_direcao_campanha/model/financeiro-aluno.dart';
import 'package:cfc_nova_direcao_campanha/model/result-api-request.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cfc_nova_direcao_campanha/model/instrutor.dart';

class ServiceHttp {
  static String codCFC = Config.codCFC;
  static String baseUrl = Config.baseUrl;
  loginAluno(String cpf, String senha) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"cpf": "$cpf", "senha": "$senha", "player_id": ""}';
      var url = Uri.parse('${baseUrl}login-aluno/$codCFC');
      final response = await post(url, headers: headers, body: json);
      final body = jsonDecode(response.body);
      return jsonEncode(ResultApiRequest.fromJson(body).data);
    } catch (err) {
      Map<String, dynamic> error = {"data": "net_erro"};
      return jsonEncode(ResultApiRequest.fromJson(error).data);
    }
  }

  loginInstrutor(String cpf, String senha) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"cpf": "$cpf", "senha": "$senha"}';
      var url = Uri.parse('${baseUrl}login-instrutor/$codCFC');
      final response = await post(url, headers: headers, body: json);
      final body = jsonDecode(response.body);
      return jsonEncode(ResultApiRequest.fromJson(body).data);
    } catch (err) {
      Map<String, dynamic> error = {"data": "net_erro"};
      return jsonEncode(ResultApiRequest.fromJson(error).data);
    }
  }

  static checkClassesOfDayInstrutor(String cpf, String data1,
      {String data2}) async {
    if (data2 == null) data2 = data1;
    var url =
        Uri.parse('${baseUrl}check-classes-of-the-day/$codCFC/$cpf/$data1/$data2');
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await get(url, headers: headers);
      final body = jsonDecode(response.body);
      return jsonEncode(ResultApiRequest.fromJson(body).data);
    } catch (err) {
      Map<String, dynamic> error = {"data": "net_erro"};
      return jsonEncode(ResultApiRequest.fromJson(error).data);
    }
  }

  static Future<List<AulasInstrutor>> fetchPosts(
      String cpf, String data1, String data2) async {
    if (data2 == null) data2 = data1;
    var url = Uri.parse('${baseUrl}classes-of-the-day/$codCFC/$cpf/$data1/$data2');
    Response response = await get(url);
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new AulasInstrutor.fromJson(m)).toList();
  }

  static Future<List<FinanceiroAluno>> financeiroAlunoPagos(String cpf) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var url = Uri.parse('${baseUrl}aluno/v2/$codCFC/$cpf/financeiro/pagos');
      final response = await get(url, headers: headers);
      if (response.body != null) return financeiroAlunoFromJson(response.body);
      return financeiroAlunoFromJson(null);
    } catch (err) {
      return financeiroAlunoFromJson(null);
    }
  }

  static Future<List<FinanceiroAluno>> financeiroAlunoTodos(String cpf) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var url = Uri.parse('${baseUrl}aluno/v2/$codCFC/$cpf/financeiro/todos');
      final response = await get(url, headers: headers);
      return financeiroAlunoFromJson(response.body);
    } catch (err) {
      return financeiroAlunoFromJson(null);
    }
  }

  static Future<List<FinanceiroAluno>> financeiroAlunoAPagar(String cpf) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var url = Uri.parse('${baseUrl}aluno/v2/$codCFC/$cpf/financeiro/apagar');
      final response = await get(url, headers: headers);
      return financeiroAlunoFromJson(response.body);
    } catch (err) {
      return financeiroAlunoFromJson(null);
    }
  }

  static Future<List<AulasDirecao>> aulasDirecaoAluno(String cpf) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var url = Uri.parse('${baseUrl}aluno/v2/$codCFC/$cpf/aulas/direcao');
      final response = await get(url, headers: headers);
      return aulasDirecaoFromJson(response.body);
    } catch (err) {
      return aulasDirecaoFromJson(null);
    }
  }

  static Future<List<ExameDirecao>> examesDirecaoAluno(String cpf) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var url = Uri.parse('${baseUrl}aluno/v2/$codCFC/$cpf/exames/direcao');
      final response = await get(url, headers: headers);
      return exameDirecaoFromJson(response.body);
    } catch (err) {
      return exameDirecaoFromJson(null);
    }
  }
}
