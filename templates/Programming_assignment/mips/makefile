J_SRC=
M_SRC=

#########################################################################################----
TO_GRADE ?= grade_all

COMMITS=${shell git log --oneline | wc -l}
MIN_COMMITS=20
SHELL=/bin/bash


test: validate_tags validate_number_commits
	@echo 
	@echo \"make test_java\" to test your current java version
	@echo \"make test_mips\" to test your current mips version
	@echo \"make final\" to test all your final versions (java, java_tac, and mips)
	@echo \"make validate\" to validate your final submission
	@echo 
	@echo Make sure you are in the correct directory when you type the above commands


test_java: ${J_SRC}
	sth_validate ../test_cases java_subroutine 

test_java_tac: ${J_SRC}
	sth_validate ../test_cases java_subroutine

test_mips: ${M_SRC}
	sth_validate ../test_cases mips_subroutine


final: final_java_code final_java_tac_code final_mips_code
	@git checkout main


final_java_code: java_code
	@git checkout java_code 2> /dev/null || { echo "Error Unable to checkout java_code" ; false ; }
	cd java ; make -f ${MAKEFILE} test_java ; cd ..
	@git checkout main

final_java_tac_code: java_tac_code
	@git checkout java_tac_code 2> /dev/null || { echo "Error Unable to checkout java_tac_code" ; false ; }
	cd java_tac ; make -f ${MAKEFILE} test_java ; cd ..
	@git checkout main


final_mips_code: mips_code
	@git checkout mips_code  2> /dev/null || { echo "Error Unable to checkout mips_code" ; false ; }
	cd mips ; make -f ${MAKEFILE} test_mips ; cd ..
	@git checkout main


validate: validate_tags validate_number_commits
	-make -f ${MAKEFILE} -k final > validation.tmp 2>&1
	@mv validation.tmp validation.output
	@git add validation.output
	@git commit -m 'Auto-commit: validation step' validation.output >/dev/null 2>&1 
	@echo Validation File has been committed if there were changes



# Currently, the number of commits does not work on the server side
# the log file only shows the most recent entry -- 
# not sure why or what the work around is.
validate_number_commits:
	@-test ! ${COMMITS} -lt ${MIN_COMMITS} || \
	  { echo You need a minimum of ${MIN_COMMITS} commits && false ; } 

validate_tags: 
	@-git show-ref --quiet --tags java_code      || { echo "Missing java_code tag" && false ; }
	@-git show-ref --quiet --tags java_tac_code  || { echo "Missing java_tac_code tag" && false ; }
	@-git show-ref --quiet --tags java_mips_code || { echo "Missing mips_ava_code tag" && false ; }


java_code:
	@-git show-ref --quiet --tags java_code      || echo "Missing java_code tag"

java_tac_code:
	@-git show-ref --quiet --tags java_tac_code  || echo "Missing java_tac_code tag"

mips_code:	
	@-git show-ref --quiet --tags mips_code      || echo "Missing mips_code tag"



#  The following section is the code the prof will use to determine
#    - what he will and what he will not grade.
#  This section is left here for transparency.
#  His criteria for grading for a particular assignment may change!
#
#  At very most, he will grade 
#    - only material that is submitted by the due_date
#      * unless prior arrangements have been made
#    - a task based upon the point in time in which you asserted is done
#      * by virtue of appropriate tagging

# Create a set of "list of students" to be graded based upon a set of criteria
pre_grade:
	bash -lc 'checkout_due_date'
	bash -lc 'meets_criteria "git tag --list java_code --merged     | grep java_code"'      | sort >criteria_task_1
	bash -lc 'meets_criteria "git tag --list java_tac_code --merged | grep java_tac_code"'  | sort >criteria_task_2
	bash -lc 'meets_criteria "git tag --list mips_code --merged     | grep java_mips_code"' | sort >criteria_task_3
	bash -lc 'meets_criteria "ls validation.output" ' | sort >criteria_task_4
	sort ${CLASS_ROSTER} > master_list
	comm -23 master_list criteria_task_1       > No_Criteria_met
	comm -23 criteria_task_1 criteria_task_2   > task_1_complete
	comm -23 criteria_task_2 criteria_task_3   > task_2_complete
	comm -23 criteria_task_3 criteria_task_4   > task_3_complete
	#cat                     criteria_task_4   > task_4_complete

# Use the TO_GRADE variable to restate what to grade
grade: ${TO_GRADE}

grade_all: grade_java_code grade_java_tac_code grade_mips_code grade_validation

# How about...
mkdir gradinging sucheckout
checkout each tag
copy the appropriate files into that location
cd ins solution
make in that directory...


grade_java_code: final_java_code
	mkdir -p grading ; subl grading
	git checkout java_code
	cp -R java grading
	git checkout main

grade_java_tac_code: grade_java_code final_java_tac_code
	mkdir -p grading ; subl grading
	git checkout java_tac_code
	cp -R java_tac grading
	git checkout main

grade_mips_code: grade_java_tac_code final_mips_code
	mkdir -p grading ; subl grading
	git checkout mips_code
	cp -R mips grading
	git checkout main

grade_validate: grade_mips_code	
	mkdir -p grading ; subl grading
	git checkout grading_information
	cp validation.output grading
	subl grading validation.output
	git checkout main

