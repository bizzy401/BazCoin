// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BAZCOIN_QT_BAZCOINADDRESSVALIDATOR_H
#define BAZCOIN_QT_BAZCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BazCoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BazCoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** BazCoin address widget validator, checks for a valid bazcoin address.
 */
class BazCoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BazCoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // BAZCOIN_QT_BAZCOINADDRESSVALIDATOR_H
