part of swagger.api;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {

  String basePath;
  var client = new Client();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: "http://localhost"}) {
    // Setup authentications (key: authentication name, value: authentication).
  }

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'Args':
          return new Args.fromJson(value);
        case 'Args1':
          return new Args1.fromJson(value);
        case 'Args10':
          return new Args10.fromJson(value);
        case 'Args11':
          return new Args11.fromJson(value);
        case 'Args12':
          return new Args12.fromJson(value);
        case 'Args13':
          return new Args13.fromJson(value);
        case 'Args14':
          return new Args14.fromJson(value);
        case 'Args15':
          return new Args15.fromJson(value);
        case 'Args16':
          return new Args16.fromJson(value);
        case 'Args17':
          return new Args17.fromJson(value);
        case 'Args2':
          return new Args2.fromJson(value);
        case 'Args3':
          return new Args3.fromJson(value);
        case 'Args4':
          return new Args4.fromJson(value);
        case 'Args5':
          return new Args5.fromJson(value);
        case 'Args6':
          return new Args6.fromJson(value);
        case 'Args7':
          return new Args7.fromJson(value);
        case 'Args8':
          return new Args8.fromJson(value);
        case 'Args9':
          return new Args9.fromJson(value);
        case 'CollectionReport':
          return new CollectionReport.fromJson(value);
        case 'Hash':
          return new Hash.fromJson(value);
        case 'InlineResponse200':
          return new InlineResponse200.fromJson(value);
        case 'InlineResponse2001':
          return new InlineResponse2001.fromJson(value);
        case 'KasseConfig':
          return new KasseConfig.fromJson(value);
        case 'KeyPair':
          return new KeyPair.fromJson(value);
        case 'MoneyReport':
          return new MoneyReport.fromJson(value);
        case 'ProgramInfo':
          return new ProgramInfo.fromJson(value);
        case 'RelayConfig':
          return new RelayConfig.fromJson(value);
        case 'RelayReport':
          return new RelayReport.fromJson(value);
        case 'RelayStat':
          return new RelayStat.fromJson(value);
        case 'StationReport':
          return new StationReport.fromJson(value);
        case 'StationStatus':
          return new StationStatus.fromJson(value);
        case 'StationsVariables':
          return new StationsVariables.fromJson(value);
        case 'Status':
           return new Status.fromJson(value);
        case 'StatusCollectionReport':
          return new StatusCollectionReport.fromJson(value);
        case 'StatusReport':
          return new StatusReport.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw new ApiException.withInner(500, 'Exception during deserialization.', e, stack);
    }
    throw new ApiException(500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return jsonVal;

    var decodedJson = json.decode(jsonVal);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(String path,
                             String method,
                             Iterable<QueryParam> queryParams,
                             Object body,
                             Map<String, String> headerParams,
                             Map<String, String> formParams,
                             String contentType,
                             List<String> authNames) async {

    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams.where((p) => p.value != null).map((p) => '${p.name}=${p.value}');
    String queryString = ps.isNotEmpty ?
                         '?' + ps.join('&') :
                         '';

    String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if(body is MultipartRequest) {
      var request = new MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded" ? formParams : serialize(body);
      switch(method) {
        case "POST":
          return client.post(url, headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: headerParams);
        case "PATCH":
          return client.patch(url, headers: headerParams, body: msgBody);
        default:
          return client.get(url, headers: headerParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames, List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null) throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }
}
