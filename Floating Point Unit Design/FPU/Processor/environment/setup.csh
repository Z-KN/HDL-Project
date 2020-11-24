# ****************************************************************************
#FILE NAME       : setup
#AUTHOR          : 
#FUNCTION        : environment/eda setup
#****************************************************************************** 
set OSTYPE = `uname -s`
if (${OSTYPE} == SunOS) then
  setenv ARCH sparcOS5
else if (${OSTYPE} == Linux)  then
  setenv ARCH linux
endif

setenv USE_LOCAL 0
setenv VCS_CC g++	

#Check GCC Version
set GCC_VERSION_LONG=`gcc --version`
@ n=0
foreach tmp_word ( $GCC_VERSION_LONG )
  @ n++
  if ( $n == 3 ) then
    setenv GCC_VER $tmp_word
  endif
end

setenv PROCESSOR_PATH `pwd | perl -pe "s/Processor.*/Processor\//"`
alias run '$PROCESSOR_PATH/environment/run_case'
