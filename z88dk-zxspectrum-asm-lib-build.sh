#!/bin/bash
#
# :dbolli:20121201 19:14:46 z88dk Z80 Development Kit

# :dbolli:20121204 16:25:31 Following defines are now correctly added in .profile
# PATH=$PATH:~/dev/unix-src/z88dk/bin/
# export PATH
# ZCCCFG=~/dev/unix-src/z88dk/lib/config/
# export ZCCCFG
# Z80_OZFILES=~/dev/unix-src/z88dk/lib/
# export Z80_OZFILES
Z80_STDLIB=/usr/local/lib/z88dk/lib/clibs/zx_clib.lib
#Z80_STDLIB=/usr/local/share/z88dk/lib/clibs/zx_clib.lib
export Z80_STDLIB

z88dkpathinitialised=`echo $PATH | grep 'z88dk'`
if [ "$z88dkpathinitialised" == "" ]
then
    # :dbolli:20121201 19:14:46 z88dk Z80 Development Kit
    PATH=$PATH:~/dev/unix-src/z88dk/bin/:/usr/local/bin/
    export PATH
    ZCCCFG=~/dev/unix-src/z88dk/lib/config/
    export ZCCCFG
    Z80_OZFILES=~/dev/unix-src/z88dk/lib/
    export Z80_OZFILES
fi

Z80EXECNAME=asm-lib

#cd "/Users/dbolli/dev/Z80 src/z88dk-zxspectrum/pacmen/"
cd ~/dev/Z80\ src/z88dk-zxspectrum/asmtest/$Z80EXECNAME-z88dk/

rm -fv "$Z80EXECNAME"_CODE.bin

#z80asm -xasm-lib -s -l -m -g @asm-lib.lst
z80asm -v -x$Z80EXECNAME -s -l -m -g @$Z80EXECNAME.lst

#z88dk-z80nm -a $Z80EXECNAME.lib

exit

#z80asm +zx -s -l -m -g -r$((0x6100)) -lasm-lib asm-lib-test.asm
z80asm +zx -v -s -l -m -g -r$((0x6100)) -l$Z80EXECNAME -L../../Ticker-zasm/ticker-lib-z88dk/ -lticker-lib $Z80EXECNAME.asm

tapfilecreated=`find ./$Z80EXECNAME.tap -type f -ctime -5s | grep $Z80EXECNAME.tap`
#echo $tapfilecreated		# DEBUG
if [ "$tapfilecreated" != "" ]
then
	open $Z80EXECNAME.tap
fi