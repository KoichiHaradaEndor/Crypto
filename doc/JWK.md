# JWK

## Constructor

`JWK` **new JWK** ()

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|return|object|<-|JWK object||

JWK object is used to store JWK (JSON Web Key) set and to query a key by specifying algorithm and key ID.

The constructor creates and returns JWK object. Then using member functions, you can query a key object stored in JWK set.

JWK set is a list of the JSON Web Keys. It is defined in the file named "jwk-secret.key" stored in the host database folder whose structure is as follows:

```JSON
{"keys": [
    {
        "kty": "oct",
        "alg": "HS256",
        "kid": "used-to-identify-a-key",
        "k": "secret_key_value_encoded_with_base64url"
    }
]}
```

For detail of the JWK set representation, please refer to [RFC7517](https://tools.ietf.org/html/rfc7517).

Please note that the attributes `alg` and `kid` are optional by the spec, they are mandatory in this component since they are used when querying a key.

Only `HS256` and `HS512` are supported as `alg` value by this component.

`k` is a key encoded with Base64url. Be noted it is not Base64 encoding.

When creating this object, the JWK set is read from the file and stored in the component's Storage for later use.

### Example

Creating JWK object and query a JSON Web key:

```4D
C_OBJECT($jwk_o;$key_o)
$jwk_o:=new JWK()
$key_o:=$jwk_o.find("HS256";"kid-value")
```

Call chain example:

```4D
C_OBJECT($key_o)
$key_o:=new JWK().find("HS256";"kid-value")
```

## Member function

`object` **JWK.find** (algorithm; keyId)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|algorithm|text|->|"alg" value to search|required|
|keyId|text|->|"kid" value to search|required|
|return|object|<-|JSON Web Key object found||

This method is used to find a key from JWK set that matches given algorithm and keyId combination.
