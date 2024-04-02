#! /bin/bash

# Simple Test Harness (sth)
###########################
#
# This file contains a set of bash functions to facilitate the unit testing of MIPS and Java subroutines
#     via the mips_subroutine and java_subroutine program.
#
#     It is expected that this file will be sourced to allow the defined functions to be executed
#     directly from the command line.
# 
# In COMP122, it is typical that a student must execute a set of commands to test their assignments.
# Each test case requires the student to run the following, exemplar, command:
#
#   $ java_subroutine  -L '*.j'  BinaryReal 8 "\#" 1234 "." 43
#   2# 1010011100.10001010001111010111000
#   $ echo $?
#   10
#   $
#
# The command line above can be broken down and each component can be assigned to a VARABLE. 
# Moreover, the output and return value can also be assigned a VARABLE.
#
# The "sth" system 
#   - allows the student to effectively define these variables within a configuration file
#   - executes and validates each of the defined test cases automatically
#
#
# | VARABLE  | Description                        | Example                  | Option    |
# |----------|------------------------------------|--------------------------|-----------|
# | DRIVER   | The default driver program         | java_subroutine          | Parameter |
# | OPTIONS  | The options passed to ${PROG}      | "-L '*.j'"               | Optional  |
# | ENTRY    | The entry point to start testing   | BinaryReal               | Required  |
# | ARGS     | The arguments passed to ${ENTRY}   | '8 \# 1234 "." 4300000'  | Optional  |
# | INPUT    | The provided input (stdin)         |                          | Optional  |
# | OUTPUT   | The expect output (stdout)         | "2# 1010011100.100011    | Optional  |
# | RETVAL   | The expected return value          | 0                        | Optional  |
#
# Given the example values above, the following command line is executed
#
#    cat | java_subroutine  -L '*.j'  BinaryReal 8 "\#" 1234 "." 43
#
# Notes:
#    - the value of DRIVER can provided to each of the sth functions
#      * if provided, it overrides the parameter
#    - the value of INPUT can either be a string or a filename
#    - the value of OUTPUT can either be a string or a filename
#
# CONFIGURATION FILE
#   Configuration files can either be named:
#     - {file}.case:   which contains -- by intent -- a single test case
#     - {file}.config: which contains -- as expected -- a set of test cases
#
#   Configuration file contains 3 types of stanza: [default], [global], and [case]
#     - [default]  # To define default values of any VARABLE
#     - [global]   # To define the global value of any VARABLE (not override-able)
#     - [case]     # To define the value for a single test case
#
#   Within each stanza, a set of environment variable definitions are defined.
#
#   Example:
#     ```
#     [default]
#     PROG=mips_subroutine
#     INPUT=  
#      
#     [global]
#     OPTIONS="-L '*' -S"
#     ENTRY=binaryReal
#      
#     [case]
#     ARGS='10 \# "1234\0" . 4321'   
#     OUTPUT="2# 10011010010.01101110100111100001101"
#     RETVAL=10
#      
#     [case]
#     ARGS='8 \# 1234 . 4300000'   
#     OUTPUT="2# 1010011100.100011"
#     RETVAL=8
#     ```
#
# EXTERNAL FUNCTIONS
#
#   1. sth_validate {directory | file} [ {driver} ]
#      - for each of the {test}.config and {test}.case files in {directory}
#        executes and validates each associated test case.
#      - the optional {driver} overrides the {DRIVER} value defined within {test}.config
#      - a summary of activities is emitted to stdout
#      - a transcription of activities is emitted to stderr
#
#   1. sth_execute {directory | file} [ {driver} ]
#      - Identical functional of sth_validate except for the generated output
#      - Output is restricted to that the execution and not the validation process. I.e., 
#        - no summary information is presented to stdout
#        - no transcription of activites is presented to stderr
#      - useful prior to the automated testing/validation process
#
# INTERNAL FUNCTIONS
#   1. sth_case_validate [ {driver} ]
#      - executes a single test case based upon the defined ENV variables
#      - the optional {driver} overrides the {DRIVER} value defined for all test cases
#
#   1. sth_config_reader   {file}
#      - reads a file and generates a set of temporary files, one per test case
#
#   1. sth_strips_comments  {file}
#      - strips comments and blank lines from a given file
#
# FILES: Naming Convention
#   Each test case or set of test cases is given a name: {test}.  This basename is 
#   used to identify, by convention, the users files associated with the "sth" system.
#
#    - {test}.config  : a set of test cases, delimited by stanzas 
#        * The "[default]" stanza defines the default values for all test cases 
#        * The "[case]" stanza defines the values for a single test case
#        * The "[global]" stanza defines values that override values associated with individual test cases
#        * It is presumed that the zeroth line of the file contains "[case]"
#          - that is to say, if not stanza is provided, it defaults to "[case]"
#
#    - {test}.input   : recommended naming
#    - {test}.output  : recommended naming
#

STH_TMPDIR=/tmp/STH.$$
alias sth_strip_comments="sed -e '/^ *#.*/d' -e '/^ *$/d'"

function sth_execute () {
  (
    local config="$1"
    local driver="$2"
    local return_val=

    STH_OLD_EXECUTE_ONLY=${STH_EXECUTE_ONLY}    
    STH_EXECUTE_ONLY=TRUE
    
    sth_validate "$config" ${driver}
    return_val="$?"

    STH_EXECUTE_ONLY=${STH_OLD_EXECUTE_ONLY}
    
    return ${ret_val}
  )
}


function sth_case_validate () {
  (   
    local driver="$1"
    local failed=2


    [[ -n ${driver} ]] && DRIVER=${driver}
    [[ -z ${DRIVER} ]] && { echo "Driver Program is undefined"; return 1; }
    [[ -z ${INPUT}  ]] && INPUT=/dev/null
    [[ -z ${OUTPUT} ]] && OUTPUT=/dev/null

    SHOW_INPUT='cat'
    SHOW_OUTPUT='cat'
    [[ ! -f ${INPUT}  ]] && SHOW_INPUT='echo'
    [[ ! -f ${OUTPUT} ]] && SHOW_OUTPUT='echo'

    actual_return=
    actual_output="${STH_TMPDIR}/${DRIVER}.output"      

    echo "Testing: ${DRIVER} ${OPTIONS} ${ENTRY} ${ARGS}"  >$(tty)
    ${SHOW_INPUT} ${INPUT} | eval ${DRIVER} ${OPTIONS} ${ENTRY} ${ARGS} > ${actual_output}
    actual_return="$?"

    # PROCESS the OUTPUT
    if [[ ${OUTPUT} != '/dev/null' ]] ; then
      ${SHOW_OUTPUT} ${OUTPUT} | diff -q - ${actual_output} >/dev/null
      if [[  $? != 0 ]] ; then
        echo "    Error: Incorrect Output"
        echo
        (( failed ++ ))
      fi
      echo "Correct Output followed by Your Output"
      echo "=============="
      ${SHOW_OUTPUT}  ${OUTPUT}
      echo "=============="
      cat  ${actual_output} 
      echo "=============="
      rm -f ${actual_output}
    else
      cat ${actual_output}  >$(tty)
    fi
    rm -f ${actual_output}

    # Process the RETURN VALUE
    if [[ -n ${RETVAL} ]] ; then
      if [[ ${RETVAL} != ${actual_return} ]] ; then
        echo "    Error: Expected Return Value: ${RETVAL}"
        echo "           Your Return Value: ${actual_return}"
        (( failed ++ ))
      fi
    fi 
    if [[ ${STH_EXECUTE_ONLY} == "TRUE" ]] ; then 
      return ${actual_return}
    else
      echo
      (( failed == 0 ))
    fi
  )
 } > /dev/stderr


function sth_validate () {
  local file_dir="$1"
  local driver="$2"	

  local return_val=
  local count=0
  local passed=0
  local test_case=

  local files=
  [[ -d ${file_dir} ]] && files=$(echo ${file_dir}/*.config ${file_dir}/*.case)
  [[ -f ${file_dir} ]] && files=${file_dir}

  mkdir -p ${STH_TMPDIR}
  for f in ${files} ; do 
    [[ ! -s $f ]] && continue

    rm -rf ${STH_TMPDIR}/*
    sth_config_reader ${f}
       # create individual files  
       #   1. the 'default' file
       #   1. the 'global' file
       #   1. a set of test cases: *.case
    for test_case in ${STH_TMPDIR}/*.case ; do
      source ${STH_TMPDIR}/default
      source ${test_case}
      source ${STH_TMPDIR}/global

      if [[ ${STH_EXECUTE_ONLY} == "TRUE" ]] ; then 
        OUTPUT=''
        RETVAL=''
      fi
      sth_case_validate ${driver}
      return_val=$?

      [[ ${return_val} == 0 ]] && ((passed ++))
      (( count ++ ))
    done
  done
  rm -fr ${STH_TMPDIR}

  if [[ ${STH_EXECUTE_ONLY} = "TRUE" ]] ; then
    return ${return_val}
  else
    echo "Summary: ${passed}/${count}  (Passed/Count)"
    return $((  count - passed ))
  fi
}


function sth_config_reader () {
  local config_file=$1

  local count=0
  local output=${STH_TMPDIR}/${count}.case

  cat /dev/null > ${STH_TMPDIR}/default
  cat /dev/null > ${STH_TMPDIR}/global
  while read -r _line ; do
    case "${_line}" in
       \[default\]* ) output=${STH_TMPDIR}/default
                      ;;

       \[global\]*  ) output=${STH_TMPDIR}/global
                      ;;

       \[case\]*    ) ((count ++))
                      output=${STH_TMPDIR}/${count}.case
                      ;; 

       *            ) echo "${_line}" >> ${output}
                      ;;
    esac
  done < <( sth_strip_comments ${config_file} )
}


