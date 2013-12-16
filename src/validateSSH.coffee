# The MIT License (MIT)
#
# Copyright (c) <year> <copyright holders>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

uint8ArrayToInt = (uintArray) ->
	if uintArray.length > 0
		len = uintArray.length
		return uintArray[len-1] + (uint8ArrayToInt(uintArray.slice(0,len-1)) << 8)
	else
		return 0

uint8ArrayToString = (uintArray) ->
	(String.fromCharCode(i) for i in uintArray).join('')

validateOpenSSHKey = (key) ->
	key = key.replace("\n", "").split(" ")

	if 2 <= key.length <= 3
		if key[0] == "ssh-rsa"
			uint8Array = base64binary.decode(key[1])

			if uint8ArrayToInt(uint8Array.slice(0,4)) == 7
				if uint8ArrayToString(uint8Array.slice(4,11)) == "ssh-rsa"
					secondLength = uint8ArrayToInt(uint8Array.slice(11,15))
					lengthSoFar = 4 + 7 + 4 + secondLength
					thirdLength = uint8ArrayToInt(uint8Array.slice(lengthSoFar, lengthSoFar + 4))
					lengthSoFar += 4 + thirdLength
					if lengthSoFar == uint8Array.length
						return true
					else
						return "invalid key length"
				else
					return "invalid key type: #{uint8ArrayToString(uint8Array.slice(4,11))}"
			else
				return "invalid key type length"
		else
			return "invalid key type: #{key[0]}"
	else
		return "invalid key structure"

input = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDItBls3aRTbVzfpBlRLdDCn8tErUuhBa
fqfu6mWoBalyo5+DcpTIWKP29RXNJw6tmPPAkUbWP6+I6MD9+ki1TWizIw9e8if6yhuEkBuTE8Lwimy
00NkzrUgXBicdbQL8lwusEdF+CSSQ7/SOrnkThVObUO0ZL9oVWDUNdzWX9IUu16Uwq9ZtdXcQqFCnYD
vYgdFUlUMKfe9jNEexQRBgnU4BjX89CNjgMhQ1i637QiVPKLHnLTd8u2b5V9f+UV9NYSfn37vcUGeNk
FXauvMmpv5CY2ZxuCN873UUmvCTGmyH3n7KvfVxcBlz8QgI9cW77SzAqnh5TEU7hkGTLlW8hP petrosagg@rachmaninoff"

console.log validateOpenSSHKey(input)