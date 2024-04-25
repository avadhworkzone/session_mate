enum ValidationTypeEnum { password, email, pNumber, name,address }

///API TYPES
enum APIType { aPost, aGet, aDelete, aPut }

enum APIHeaderType {
  fileUploadWithToken,
  fileUploadWithoutToken,
  jsonBodyWithToken,
  jsonBodyWithoutToken,
  onlyToken,
  withoutHeader
}
