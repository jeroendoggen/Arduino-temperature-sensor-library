#!/bin/bash
##
# build.sh - Script to build several Arduino .ino files at the same time
# Copyright 2012 Jeroen Doggen (jeroendoggen@gmail.com)
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


SCRIPTPATH="`pwd`"

SUCCESCOUNTER=0
FAILURECOUNTER=0

##################################################################  
# SELECT FILES TO BUILD                                          #
##################################################################

FILES[0]='examples/RawData/'
FILES[1]='examples/Temperature/'

# select the range of file you want to build (from FIRSTFILE up to LASTFILE)
FIRSTFILE=0
LASTFILE=1

##################################################################  
# FUNCTIONS                                                      #
##################################################################  

function buildFile 
{
  cleanPreviousBuilds
  scons > /dev/null
  if [ $? -eq 0 ] 
    then
      echo "Build OK in folder: '`pwd | awk -F/ '{print $NF}'`' "
      echo "`date`: Build OK in folder: '`pwd | awk -F/ '{print $NF}'`' " >> $SCRIPTPATH/succes.log
        let SUCCESCOUNTER++ 

    else
      echo "Errors in folder: '`pwd | awk -F/ '{print $NF}'`' "
      echo "`date`: Errors in folder: '`pwd | awk -F/ '{print $NF}'`' " >> $SCRIPTPATH/errors.log
      let FAILURECOUNTER++
  fi
}

function cleanPreviousBuilds
{
  ls | grep .elf > /dev/null
  if [ $? -eq 0 ] 
    then 
      rm *.elf
  fi

  ls | grep .hex> /dev/null
  if [ $? -eq 0 ] 
    then 
      rm *.hex
  fi

  ls | grep build> /dev/null
  if [ $? -eq 0 ] 
    then 
      rm -rf build
  fi
}

function CreateLogfiles 
{
  if [ -f $SCRIPTPATH/succes.log ];
  then
    echo -ne ""
  else
    echo "File succes.log does not exist, creating it now"
    touch $SCRIPTPATH/succes.log
  fi

  if [ -f $SCRIPTPATH/errors.log ];
  then
    echo -ne ""
  else
    echo "File errors.log does not exist, creating it now"
    touch $SCRIPTPATH/errors.log
  fi
}

function PrintStats
{
  echo "-------------------------'"
  echo "| Succesfull builds : $SUCCESCOUNTER |"
  echo "| Failed builds     : $FAILURECOUNTER |"
  echo "-------------------------'"
}

##################################################################  
# MAIN CODE STARTS HERE                                          #
##################################################################

CreateLogfiles

for ((i=FIRSTFILE;i<=LASTFILE;i++)); do
  cd ${FILES[i]}
  buildFile
  cd $SCRIPTPATH
done

PrintStats
