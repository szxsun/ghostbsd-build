#!/bin/sh
#####################################################################
# Copyright (c) 2015, GhostBSD. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistribution's of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistribution's in binary form must reproduce the above
#    copyright notice,this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
# 3. Neither then name of  GhostBSD nor the names of its
#    contributors maybe used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#####################################################################
set -e

rm -rf /usr/obj/i386/
rm -rf /usr/obj/amd64/

Build_MATE_amd64()
{
  cd clscripts
  sh clean_mate_amd64
  cd ..
  cd mkscripts
  sh make_mate_amd64_iso
  cd ..
  cd clscripts
  sh clean_mate_amd64
  cd ..
}

Build_XFCE_amd64()
{
  cd clscripts
  sh clean_xfce_amd64
  cd ..
  cd mkscripts
  sh make_xfce_amd64_iso
  cd ..
  cd clscripts
  sh clean_xfce_amd64
  cd ..
}

Build_MATE_amd64
Build_XFCE_amd64
