#! /usr/local/bin/Rscript
library(optparse)

option_list = list(
    make_option(
        c("-i", "--input"),
        type = "character",
        default = NULL,
        help = "path to file",
        metavar = "character"
    ),
    make_option(
        c("-o", "--output"),
        type = "character",
        default = './output.txt',
        help = "path to output file [default = %default]",
        metavar = "character"
    ),
    make_option(
        c("-m", "--mode"),
        type = "character",
        default = 'Encrypt',
        help = "Encrypt  or Decrypt [default = %default]",
        metavar = "character"
    ),
    make_option(
        c("-k", "--key"),
        type = "integer",
        default = 1,
        help = "Encrypting Key [default = %default]",
        metavar = "integer"
    )
)

opt = parse_args(object = OptionParser(option_list = option_list))
message=readChar(opt$input, file.info(opt$input)$size)

cat(message)
cat('\n\n')
cat(ifelse(opt$mode=='Encrypt','Encryption','Decryption'))
cat('\n\n')

encrypt_message = function(message, key = 1) {
    suppressMessages(  library(tidyverse))
    
    message = utf8ToInt(message)
    
    chars=c(9,10,32:126,160:383)

    bases = c('A', 'T', 'G', 'C')
    
    Add_base = function(A, B) {
        x = paste0(A, B)
        return(x)
    }
    
    triplets = unlist(lapply(bases, Add_base, B = bases))
    triplets = unlist(lapply(triplets, Add_base, B = bases))
    triplets = unlist(lapply(triplets, Add_base, B = bases))
    triplets = unlist(lapply(triplets, Add_base, B = bases))
    
    set.seed(key)
    encrypt = function(message,
                        chars,
                        triplets) {
        c = sample(chars, length(chars))
        t = sample(triplets, length(triplets))
        
        return(t[which(c == message)])
        
    }
    
    message_encrypted = paste(
        lapply(
            message,
            encrypt,
            chars = chars,
            triplets = triplets
        ),
        collapse = ''
    )
    
    return(message_encrypted)
    
}
decryp_message = function(message, key = 1) {
    suppressMessages(  library(tidyverse))
    
    chars=c(9,10,32:126,160:383)

    bases = c('A', 'T', 'G', 'C')
    
    Add_base = function(A, B) {
        x = paste0(A, B)
        return(x)
    }
    
    triplets = unlist(lapply(bases, Add_base, B = bases))
    triplets = unlist(lapply(triplets, Add_base, B = bases))
    triplets = unlist(lapply(triplets, Add_base, B = bases))
    triplets = unlist(lapply(triplets, Add_base, B = bases))

    
    split_message_encrypted = function(message) {
        L = str_length(message) / 5
        L = (1:L) * 5
        return(str_sub(message, L - 4, L))
        
    }
    
    message_encrypted = split_message_encrypted(message)
    
    decryp = function(message,
                        chars,
                        triplets) {
        c = sample(chars, length(chars))
        t = sample(triplets, length(triplets))
        
        return(intToUtf8(c[which(t == message)]))
        
    }
    
    set.seed(key)
    
    message_decrypted = paste(
        lapply(
            message_encrypted,
            decryp,
            chars = chars,
            triplets = triplets
        ),
        collapse = ''
    )
    return(message_decrypted)
}


if(opt$mode=='Encrypt'){
    message=encrypt_message(message,opt$key)
    writeChar(message,opt$output)
    cat(message)
}else if (opt$mode=='Decrypt'){
    message=decryp_message(message,opt$key)
    writeChar(message,opt$output)
    cat(message)
}


