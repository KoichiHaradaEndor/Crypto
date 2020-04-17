# HMAC

## Constructor

`HMAC` **new HMAC** (message; key; algorithm)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|message|text or blob|->|Message to hash|optional|
|key|text or blob|->|Key used to sign the message|optional|
|algorithm|text or long|->|Digest algorithm|optional|
|return|object|<-|HMAC object||

HMAC object is used to sign a `message` with the specified `key` and `algorothm`.

HMAC: Hash-based Message Authentication Code

The constructor creates and returns HMAC object. Then using member functions, you can add parameters and generate signed message.

The constructor can take optional parameters which is used to initialize message, key and algorithm.

Each parameter is explained in the description of the respective function.

### Example

Just to create HMAC object:

```4D
C_OBJECT($hmac_o)
$hmac_o:=new HMAC()
```

Initialize the object when creating HMAC object:

```4D
C_OBJECT($hmac_o)
$hmac_o:=new HMAC("Sign this text";"sha256";"secret-key")
```

Step-by-step eample:

```4D
C_OBJECT($hmac_o)
C_TEXT($signed_t)
$hmac_o:=new HMAC()
$hmac_o.algorithm("sha256")
$hmac_o.key("secret-key")
$hmac_o.message("Sign this text")
$signed_t:=$hmac_o.hexDigest()
```

Call chain example:

```4D
C_TEXT($signed_t)
$signed_t:=new HMAC()\
    .algorithm("sha256")\
    .key("secret-key")\
    .message("Sign this text")\
    .hexDigest()
```

## Member function

`HMAC` **HMAC.algorithm** (algorithm)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|algorithm|text or long|->|Digest algorithm|required|
|return|object|<-|HMAC object||

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
