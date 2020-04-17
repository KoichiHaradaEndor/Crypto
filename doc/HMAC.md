# HMAC

## Constructor

`HMAC` **new HMAC** (message; key; algorithm)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|message|text or blob|->|Message to hash|optional|
|key|text or blob|->|Key used to sign the message|optional|
|algorithm|text or long|->|Digest algorithm|optional|
|return|object|<-|HMAC object||

HMAC object is used to sign a message with the specified key and algorothm.

HMAC ＝ Hash-based Message Authentication Code

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

## Member function

`HMAC` **HMAC.algorithm** (algorithm)

|Name|Type||Description||
|-----|-----|-----|-----|-----|
|algorithm|text or long|->|Digest algorithm|required|
|return|object|<-|HMAC object||

