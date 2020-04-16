//%attributes = {"invisible":true}
  // https://tools.ietf.org/html/rfc4231

C_TEXT:C284($key_t;$message_t;$result_t;$target_t)
C_OBJECT:C1216($hmac_o)
C_BLOB:C604($key_x;$message_x)

  // Test case 1

$key_x:=hexToBlob ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b")
$message_t:="Hi There"
$target_t:="b0344c61d8db38535ca8afceaf0bf12b"\
+"881dc200c9833da726e9376c2e32cff7"

$result_t:=new Hmac ()\
.algorithm(SHA256 digest:K66:4)\
.key($key_x)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

$target_t:="87aa7cdea5ef619d4ff0b4241a1d6cb0"\
+"2379f4e2ce4ec2787ad0b30545e17cde"\
+"daa833b7d6b8a702038b274eaea3f4e4"\
+"be9d914eeb61f1702e696c203a126854"

$result_t:=new Hmac ()\
.algorithm(SHA512 digest:K66:5)\
.key($key_x)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

  // Test case 2
  // Test with a key shorter than the length of the HMAC output.

$key_t:="Jefe"
$message_t:="what do ya want for nothing?"
$target_t:="5bdcc146bf60754e6a042426089575c7"\
+"5a003f089d2739839dec58b964ec3843"

$result_t:=new Hmac ()\
.algorithm(SHA256 digest:K66:4)\
.key($key_t)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

$target_t:="164b7a7bfcf819e2e395fbe73b56e0a3"\
+"87bd64222e831fd610270cd7ea250554"\
+"9758bf75c05a994a6d034f65f8f0e6fd"\
+"caeab1a34d4a6b4b636e070a38bce737"

$result_t:=new Hmac ()\
.algorithm(SHA512 digest:K66:5)\
.key($key_t)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

  // Test case 3
  // Test with a combined length of key and data that is larger than 64
  // bytes (= block-size of SHA-224 and SHA-256).

$key_x:=hexToBlob ("a"*40)
$message_x:=hexToBlob ("d"*100)
$target_t:="773ea91e36800e46854db8ebd09181a7"\
+"2959098b3ef8c122d9635514ced565fe"

$result_t:=new Hmac ()\
.algorithm(SHA256 digest:K66:4)\
.key($key_x)\
.message($message_x)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

$target_t:="fa73b0089d56a284efb0f0756c890be9"\
+"b1b5dbdd8ee81a3655f83e33b2279d39"\
+"bf3e848279a722c806b485a47e67c807"\
+"b946a337bee8942674278859e13292fb"

$result_t:=new Hmac ()\
.algorithm(SHA512 digest:K66:5)\
.key($key_x)\
.message($message_x)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

  // Test case 4
  // Test with a combined length of key and data that is larger than 64
  // bytes (= block-size of SHA-224 and SHA-256).

$key_x:=hexToBlob ("0102030405060708090a0b0c0d0e0f10111213141516171819")
$message_x:=hexToBlob ("cd"*50)
$target_t:="82558a389a443c0ea4cc819899f2083a"\
+"85f0faa3e578f8077a2e3ff46729665b"

$result_t:=new Hmac ()\
.algorithm(SHA256 digest:K66:4)\
.key($key_x)\
.message($message_x)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

$target_t:="b0ba465637458c6990e5a8c5f61d4af7"\
+"e576d97ff94b872de76f8050361ee3db"\
+"a91ca5c11aa25eb4d679275cc5788063"\
+"a5f19741120c4f2de2adebeb10a298dd"

$result_t:=new Hmac ()\
.algorithm(SHA512 digest:K66:5)\
.key($key_x)\
.message($message_x)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

  // Test case 5
  // Test with a truncation of output to 128 bits.
  // Truncation is not implemented


  // Test case 6
  // Test with a key larger than 128 bytes (= block-size of SHA-384 and
  // SHA-512).

$key_x:=hexToBlob ("a"*262)
$message_t:="Test Using Larger Than Block-Size Key - Hash Key First"
$target_t:="60e431591ee0b67f0d8a26aacbf5b77f"\
+"8e0bc6213728c5140546040f0ee37f54"

$result_t:=new Hmac ()\
.algorithm(SHA256 digest:K66:4)\
.key($key_x)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

$target_t:="80b24263c7c1a3ebb71493c1dd7be8b4"\
+"9b46d1f41b4aeec1121b013783f8f352"\
+"6b56d037e05f2598bd0fd2215d6a1e52"\
+"95e64f73f63f0aec8b915a985d786598"

$result_t:=new Hmac ()\
.algorithm(SHA512 digest:K66:5)\
.key($key_x)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

  // Test case 7
  // Test with a key and data that is larger than 128 bytes (= block-size
  // of SHA-384 and SHA-512).

$key_x:=hexToBlob ("a"*262)
$message_t:="This is a test using a larger than "\
+"block-size key and a larger than block-size "\
+"data. The key needs to be hashed before being used "\
+"by the HMAC algorithm."
$target_t:="9b09ffa71b942fcb27635fbcd5b0e944"\
+"bfdc63644f0713938a7f51535c3a35e2"

$result_t:=new Hmac ()\
.algorithm(SHA256 digest:K66:4)\
.key($key_x)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

$target_t:="e37b6a775dc87dbaa4dfa9f96e5e3ffd"\
+"debd71f8867289865df5a32d20cdc944"\
+"b6022cac3c4982b10d5eeb55c3e4de15"\
+"134676fb6de0446065c97440fa8c6a58"

$result_t:=new Hmac ()\
.algorithm(SHA512 digest:K66:5)\
.key($key_x)\
.message($message_t)\
.hexDigest()

ASSERT:C1129($result_t=$target_t)

