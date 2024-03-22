Ideas for the Fall...

1. In mapping section bring up 
   - variables to locations in memory
   - variables to frames

1. Exercise in Mapping section
   - Talk about  "my stuff" and "common"  stuff -- apartment: bedroom versus kitchen
   - enumarate all the variables you have and organize them somehow
     - formal, locals, class, constants/final
   - enumerate all of the registers into groups
      - (reserved: gp, at, k1, k2), T-s, S-es, a-s, v-s, fp, sp



## Multiplication
   - [ ] update the slides to include cost analysis
   - based upon the timing chart, multiplication take ?32
   - revisit writing a multiplication using the tricks...


## Activiation Records Lecture
   - use Miro
   - have a scattering of formals and locals
   - have a scattering of registers
   - group them
   - talk about the catagors: 
       - location: shared vurses private: 
       - value: shared vurses private: 

   - reorganize the stuff into a box: i.e., a activation frame
   - [ ] Develop a new set of slides associated with frames

## TAC
   - [ ] Consider having a special section on Boolean expressions
     - then loops and conditions use b-gtz for true
       ```mips
       slti    $t3, $t1, 5         # if i < 5 goto done
       bgtz    $t3, done           # 
       ```

     - pseudo instruction
       * bset  $t3, done   --> bgtz
       * bclear $t3, done  --> bz (syname:  bne,  beq $t3, $zero, done)

     * note that b can be an immediate
       - a == b:   seq  $at, a, b
       - a <= b    sle  $at, a, b
       - a < b     slt  $at, a, b
       - a > b     sgt  $at, a, b
       - a >= b    sge  $at, a, b
       - a != b    sne  $at, a, b

  - [ ] Consider creatint an ARM version for TAC
  - [ ] Consider notation for preshifts
    - Nope this would be better as a peep-hole optimizer
      *  x = x op imm
      *  x = x op y
      *  x = x op (shift)    # extended version for ARM
      *  x = x op ( b << imm)

      ```
      y = b << imm
      z = z op y
      ```
      =>
      ```
      z = z op (b << imm)
      ```


