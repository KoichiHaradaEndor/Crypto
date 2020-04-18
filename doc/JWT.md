# JWT

## Constructor

`JWT` **new JWT** (header; payload; key)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|header|object|->|JWT header|optional|
|payload|object|->|JWT payload|optional|
|key|object|->|Key used to sign the JWT|optional|
|return|object|<-|JWT object||

JWT object is used to generate JSON Web Token.

The constructor creates and returns JWT object. Then using member functions, you can add parameters and generate JWT.

The constructor can take optional parameters which are used to initialize JWT parameters.

Each parameter is explained in the description of the respective function.

### Example

Step-by-step example:

```4D
C_OBJECT($jwt_o)
C_TEXT($token_t)
$jwt_o:=new JWT ()
$jwt_o.header("typ";"JWT")
$jwt_o.payload("iss";"joe")
$jwt_o.payload("http://example.com/is_root";True)
$jwt_o.key($key_o) // the $key_o is set using JWK.find()
$token_t:=$jwt_o.generate()
```

Call chain example:

```4D
C_TEXT($token_t)
$token_t:=new JWT ()\
    .header("typ";"JWT")\
    .payload("iss";"joe")\
    .payload("http://example.com/is_root";True)\
    .key($key_o)\
    .generate()
```

If you are familiar with JWT spec, you may think `alg` header parameter is missing in the above example and it's an error. It is explained in the description of the JWT.header function.

Verify a token:

```4D
C_OBJECT($jwt_o)
C_TEXT($token_t)
C_BOOLEAN($verified_b)
// $token_t variable contains retrieved token
$jwt_o:=new JWT ()
$verified_b:=$jwt_o.verify($token_t;"HS256")
```

## Member function

`text` **JWT.generate** ()

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|return|text|<-|Signed JSON Web Token||

This method generates signed JWT based on the values stored in this object, then returns it.

---

`JWT` **JWT.header** (header)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|header|object|->|Object that contains full header information|required|
|return|object|<-|JWT object||

`JWT` **JWT.header** (headerName; headerValue)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|headerName|text|->|Header parameter name to set|required|
|headerValue|text|->|Header parameter value to set|required|
|return|object|<-|JWT object||

Used to set JWT header to JWT object.

This function has two forms. One is accepting an object that contains full JWT header information. And the other is, you can pass JWT header field one by one.

When the same header field name is passed multiple times, the latter value is stored.

**Important note**:
The `alg`  and `kid` parameter in the JWT header will be set by this component by looking up the description of key parameter. The key parameter is a JWK type key that contains `alg` and `kid` parameter, then it will be used. So if `alg` or `kid`  is set by this function, it will be overwritten.

---

`JWT` **JWT.key** (key)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|key|object|->|Key used for signing|required|
|return|object|<-|JWT object||

This method is used to set a `key` that will be used for signing.

When it is already set, it is replaced with the new key.

The key is an object retrieved with `JWK.find()` function.

---

`JWT` **JWT.payload** (payload)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|payload|object|->|Object that contains full payload information|required|
|return|object|<-|JWT object||

`JWT` **JWT.payload** (payloadName; payloadValue)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|payloadName|text|->|Payload parameter name to set|required|
|payloadValue|text|->|Payload parameter value to set|required|
|return|object|<-|JWT object||

Used to set JWT payload to JWT object.

This function has two forms. One is accepting an object that contains full JWT payload information. And the other is, you can pass JWT payload field one by one.

When the same payload field name is passed multiple times, the latter value is stored.

---

`JWT` **JWT.verify** ()

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|token|text|->|JWT token|required|
|algorithm|text|->|Algorithm name used to sign the JWT token|required|
|payload|object|<-|Object variable that receives decoded payload|optional|
|extra|object|->|Extra verification values|optional|
|return|boolean|<-|True if verified, otherwise false||

This method parses given JWT `token` and verify it.

If the test passes, it returns true, otherwise false. Also the payload parameter receives parsed payload.

Note that the payload parameter must be initialized using `New object()` command in the caller method before verifying. Otherwise it will not receive the content.

In the `algorithm` parameter, pass an algorithm that was used when generating the JWT. This value must match with the one in the JWT header. If not, verification fails.

Then a key is queried using the alg and the kid specidfied in the JWT header. Then the signature is verified using the key.

If "exp" and/or "nbf" claim are specified in the payload, they are checked.

* exp  : (IntDate) Expiration Time, must after current IntDate
* nbf  : (IntDate) Not Before, must before current IntDate

IntDate is numeric value that represents the number of seconds from 1970-01-01T00:00:00Z UTC until the specified UTC date/time

In the optional `extra` object type parameter, you can pass some elements that will invoke additional verification. Supported elements are:

* iss  : (text) Issuer, case sensitive exact match
* nonce: (text) Random value, case sensitive exact match

If one of these are specified, each element is checked with the one in the payload. If one of the specified element does not included in the payload or does not match, verification fails.

**Important note**:
When generating JWT with `JWT.generate()` function, you must register `key` parameter beforehand.

By spec of this components, the `key` must contains `alg` and `kid` attributes, and only `HS256` and `HS512` are supported for `alg` value. this means `none` is not supported. This is for security reason

Also `kid` is mandatory even though it's use is optional by JWT specification. In this component, the `kid` is used to find a key from JWK set along with the `alg` value that was passed to `JWT.verify()` function. This way, this component try to avoid `alg` fixation and/or tampering attack.
