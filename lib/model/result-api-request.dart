class ResultApiRequest {
  ResultApiRequest(this.data);
  final dynamic data;
  ResultApiRequest.fromJson(Map<String, dynamic> json) : data = json['data'];
}
