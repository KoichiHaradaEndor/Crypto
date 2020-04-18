# JWT

## Constructor

`JWT` **new JWT** (header; payload; key)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|header|object|->|JWT header|optional|
|payload|object|->|JWT payload|optional|
|key|object|->|Signing algorithm|optional|
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
    header("typ";"JWT")\
    payload("iss";"joe")\
    payload("http://example.com/is_root";True)\
    key($key_o)\
    generate()
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

`text` **JWT.generate** (algorithm)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|return|text|<-|Signed JSON Web Token||

This method sets `algorithm` parameter which is used when signing the message.

It accepts text literal or 4D constant (Digest theme).

Only "sha256" (SHA256 digest) or "sha512" (SHA512 digest) are supported.

---

`text` **HMAC.hexDigest** ()

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|return|text|<-|Signed message||

This method executes HMAC signing based on the values stored in the HMAC object, then returns it.

---

`HMAC` **HMAC.key** (key)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|key|text or blob|->|Key used for signing|required|
|return|Object|<-|HMAC object||

This method is used to set a `key` that will be used for signing.

When it is already set, it is replaced with the new key.

The key parameter can be of type text or blob.

---

`HMAC` **HMAC.message** (message)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|message|text or blob|->|Message to be signed|required|
|return|Object|<-|HMAC object||

This method is used to specify `message` to be signed.

When a message is already set, given text is appended to the original message.

The message parameter can be of type text or blob.

Please note that when this function is called subsequently, type text and blob cannot be mixed. When text type is used in the first call, use text type in the following call.
