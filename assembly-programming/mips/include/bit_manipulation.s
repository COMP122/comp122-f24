
.macro bic(%rd, %rs, %mask)   # Bit Clear -- Native in ARM
                li $at, %mask
                nor $at, $at, $zero
                and %rd, %rs, $at
.end_macro  
