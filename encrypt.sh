#!/bin/bash

helper() {
	mode=$1
	inputfile=''
	outputfile=''
	keyfile=''

	# Get positional arguments
	while [[ $# -gt 0 ]]; do
		case $1 in
		--in | -i)
			inputfile=$2
			;;
		--out | -o)
			outputfile=$2
			;;
		--key | -k)
			keyfile=$2
			;;
		--help | -h)
			echo "Usage:"
			echo "	encrypt --in inputfile --out outputfile [optional] --key keyfile"
			echo "	decrypt --in encryptedfile --out decryptedfile [optional] --key keyfile"
			echo "	genkey keyfilename"
			kill -INT $$
			;;
		esac
		shift
	done

	# Really Basic Error Handling
	if [[ -z $inputfile || -z $outputfile ]]; then
		echo "Input or output file missing, use --help to see usage."
		kill -INT $$
	fi

	# Encrypt with key file or without
	if [[ $mode -eq 0 ]]; then
		if [[ -z $keyfile ]]; then
			openssl enc -aes-256-cbc -pbkdf2 -in $inputfile -out $outputfile
		else
			openssl enc -aes-256-cbc -pbkdf2 -in $inputfile -out $outputfile -pass file:$keyfile
		fi
	else
		if [[ -z $keyfile ]]; then
			openssl aes-256-cbc -d -pbkdf2 -in $inputfile -out $outputfile
		else
			openssl aes-256-cbc -d -pbkdf2 -in $inputfile -out $outputfile -pass file:$keyfile
		fi
	fi
}

encrypt() {
	helper 0 $@
}

decrypt() {
	helper 1 $@
}

genkey() {
	keyfile=$1
	if [[ $# -eq 0 || $# -gt 1 || "$keyfile" == "--help" || "$keyfile" == "-h" ]]; then
		echo "Usage:"
		echo "	encrypt --in inputfile --out outputfile [optional] --key keyfile"
		echo "	decrypt --in encryptedfile --out decryptedfile [optional] --key keyfile"
		echo "	genkey keyfilename"
	fi
	
	openssl rand 1000 > $keyfile
}
