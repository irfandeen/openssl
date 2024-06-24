# Encrypt - A simple wrapper for OpenSSL
The encrypt bash script is a wrapper for the OpenSSL tool, and it simplifies the process of encryption, decryption, and key generation.
This version only supports symmetric encryption using AES-256-CBC with -pbkdf2 for key derivation, with salt.

## Usage
### Encryption
*To encrypt using password:*
```sh
encrypt --in inputfile --out outputfile
```
*To encrypt using key file:*
```sh
encrypt --in inputfile --out outputfile --key keyfile
```

### Decryption
*To decrypt using password:*
```sh
decrypt --in inputfile --out outputfile
```
*To decrypt using key file:*
```sh
decrypt --in inputfile --out outputfile --key keyfile
```

### Key Generation
*To generate key file:*
```sh
genkey keyfile
```

## Installation

```sh
git clone https://github.com/irfandeen/openssl.git
cd openssl
cp encrypt.sh ~ # or whichever directory you want

# If using bash
echo "source ./encrypt >> ~/.bashrc" # wherever encrypt.sh was installed

# If using zsh
echo "source ./encrypt >> ~/.zshrc" # wherever encrypt.sh was installed
```

## Remarks
More wrappers for the OpenSSL library will be added in the future, if I have the time.