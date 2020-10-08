#! /usr/local/bin/Rscript
library(optparse)

option_list = list(
  make_option(
    c("-i", "--input"),
    type = "character",
    default = NA,
    help = "path to the file to encrypt/decrypt",
    metavar = "character"
  ),
  make_option(
    c("-o", "--output"),
    type = "character",
    default = './output.txt',
    help = "output file",
    metavar = "character"
  ),
  make_option(
    c("-m", "--mode"),
    type = "character",
    default = 'Encrypt',
    help = "Encrypt or Decrypt [default=%default]",
    metavar = "character"
  ),
  make_option(
    c("-k", "--key"),
    type = "integer",
    default = 1,
    help = "Encryption Key",
    metavar = "integer"
  )
)

opt = parse_args(object = OptionParser(option_list = option_list))


if(file.exists(opt$input)){
    message=readChar(opt$input, file.info(opt$input)$size)
}else{
    stop('Please provide a text file to encrypt. For help use the option -h')
}


cat(message)
cat('\n\n')
cat(ifelse(opt$mode=='Encrypt','Encrypting','Decrypting'))
cat('\n\n')
set.seed(opt$key)
Encrypt_message = function(message) {

  Chars=c(9,10,32:126,160:383)
 
  message = utf8ToInt(message)

  encrypt = function(message,Chars) {
    c = sample(Chars, length(Chars))
    t = sample(Chars, length(Chars))
    
    return(intToUtf8(t[which(c == message)]))
    
  }
  
  Encrypted_message = paste(
    lapply(
      message,
      encrypt,
      Chars = Chars
    ),
    collapse = ''
  )
  
  return((Encrypted_message))

  
}
Decrypt_message = function(message) {
    Chars=c(9,10,32:126,160:383)

  Encrypted_message = utf8ToInt(message)
  
  decrypt = function(message,Chars) {
    c = sample(Chars, length(Chars))
    t = sample(Chars, length(Chars))
    
    return(intToUtf8(c[which(t == message)]))
    
  }
  
  Decyrted_message = paste(
    lapply(
      Encrypted_message,
      decrypt,
      Chars = Chars
    ),
    collapse = ''
  )
  return(Decyrted_message)
}

if(opt$mode=='Encrypt'){
  message=Encrypt_message(message)
  writeChar(message,opt$output,eos='')
  cat(message)
}else if (opt$mode=='Decrypt'){
  message=Decrypt_message(message)
  writeChar(message,opt$output,eos='')
  cat(message)
}else{
    stop('wrong -m option provided')
}
