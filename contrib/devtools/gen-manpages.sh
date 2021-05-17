#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BAZCOIND=${BAZCOIND:-$BINDIR/bazcoind}
BAZCOINCLI=${BAZCOINCLI:-$BINDIR/bazcoin-cli}
BAZCOINTX=${BAZCOINTX:-$BINDIR/bazcoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/bazcoin-wallet}
BAZCOINQT=${BAZCOINQT:-$BINDIR/qt/bazcoin-qt}

[ ! -x $BAZCOIND ] && echo "$BAZCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BAZVER <<< "$($BAZCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for bazcoind if --version-string is not set,
# but has different outcomes for bazcoin-qt and bazcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$BAZCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $BAZCOIND $BAZCOINCLI $BAZCOINTX $WALLET_TOOL $BAZCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BAZVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BAZVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
